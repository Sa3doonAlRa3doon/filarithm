package ae.aveonex.filarithm

import android.content.ActivityNotFoundException
import android.content.Intent
import android.content.pm.PackageManager
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private val immersiveChannel = "ae.aveonex.filarithm/immersive"
    private val shareChannel = "ae.aveonex.filarithm/share"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, immersiveChannel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "capability" -> {
                        val hasArCamera = packageManager.hasSystemFeature("android.hardware.camera.ar")
                        val hasArCore = try {
                            packageManager.getApplicationInfo("com.google.ar.core", 0)
                            true
                        } catch (_: PackageManager.NameNotFoundException) {
                            false
                        }
                        val hasGyroscope = packageManager.hasSystemFeature(
                            PackageManager.FEATURE_SENSOR_GYROSCOPE
                        )
                        val arAvailable = hasArCamera && hasArCore
                        result.success(
                            mapOf(
                                "ar" to arAvailable,
                                "vr" to hasGyroscope,
                                "message" to when {
                                    !arAvailable && !hasGyroscope -> "This device has neither an ARCore runtime nor a gyroscope for phone-headset VR."
                                    !arAvailable -> "AR requires an ARCore-certified device with Google Play Services for AR. Sensor-tracked phone VR is available."
                                    !hasGyroscope -> "AR is available. VR requires a gyroscope-equipped phone or a separate supported runtime."
                                    else -> "ARCore surface placement and sensor-tracked phone-headset VR are available."
                                }
                            )
                        )
                    }
                    "enterAr", "enterVr" -> result.error(
                        "IMMERSIVE_UNAVAILABLE",
                        "A compatible ARCore/OpenXR runtime is required.",
                        null
                    )
                    else -> result.notImplemented()
                }
            }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, shareChannel)
            .setMethodCallHandler { call, result ->
                if (call.method != "shareWhatsApp") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }
                val filePath = call.argument<String>("filePath")
                val text = call.argument<String>("text") ?: ""
                if (filePath.isNullOrBlank()) {
                    result.error("INVALID_FILE", "A PDF path is required.", null)
                    return@setMethodCallHandler
                }
                val file = File(filePath)
                if (!file.exists()) {
                    result.error("MISSING_FILE", "The PDF no longer exists.", null)
                    return@setMethodCallHandler
                }
                val uri = FileProvider.getUriForFile(
                    this,
                    "$packageName.fileprovider",
                    file,
                )
                val intent = Intent(Intent.ACTION_SEND).apply {
                    type = "application/pdf"
                    putExtra(Intent.EXTRA_STREAM, uri)
                    putExtra(Intent.EXTRA_TEXT, text)
                    setPackage("com.whatsapp")
                    addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                }
                try {
                    startActivity(intent)
                    result.success(true)
                } catch (_: ActivityNotFoundException) {
                    result.success(false)
                }
            }
    }
}
