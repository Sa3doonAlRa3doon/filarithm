package ae.aveonex.filarithm

import android.content.ActivityNotFoundException
import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.security.MessageDigest

class MainActivity : FlutterActivity() {
    private val immersiveChannel = "ae.aveonex.filarithm/immersive"
    private val shareChannel = "ae.aveonex.filarithm/share"
    private val updateChannel = "ae.aveonex.filarithm/update"

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
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, updateChannel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "supportedAbis" -> result.success(Build.SUPPORTED_ABIS.toList())
                    "canInstallPackages" -> result.success(canInstallPackages())
                    "openInstallPermission" -> {
                        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
                            result.success(true)
                            return@setMethodCallHandler
                        }
                        try {
                            startActivity(
                                Intent(
                                    Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES,
                                    Uri.parse("package:$packageName"),
                                ),
                            )
                            result.success(true)
                        } catch (error: ActivityNotFoundException) {
                            result.error(
                                "INSTALL_PERMISSION_UNAVAILABLE",
                                "Android could not open the install-permission screen.",
                                error.message,
                            )
                        }
                    }
                    "installApk" -> {
                        val filePath = call.argument<String>("filePath")
                        if (filePath.isNullOrBlank()) {
                            result.error("INVALID_APK", "An APK path is required.", null)
                            return@setMethodCallHandler
                        }
                        try {
                            verifyAndInstallApk(File(filePath))
                            result.success(true)
                        } catch (error: Exception) {
                            result.error(
                                "APK_INSTALL_REJECTED",
                                error.message ?: "The APK could not be verified.",
                                null,
                            )
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun canInstallPackages(): Boolean =
        Build.VERSION.SDK_INT < Build.VERSION_CODES.O ||
            packageManager.canRequestPackageInstalls()

    private fun verifyAndInstallApk(apk: File) {
        if (!apk.isFile) throw IllegalArgumentException("The downloaded APK no longer exists.")
        val cacheRoot = cacheDir.canonicalFile
        val canonicalApk = apk.canonicalFile
        if (!canonicalApk.path.startsWith(cacheRoot.path + File.separator)) {
            throw SecurityException("Updates must be installed from Filarithm's private cache.")
        }

        @Suppress("DEPRECATION")
        val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            PackageManager.GET_SIGNING_CERTIFICATES
        } else {
            PackageManager.GET_SIGNATURES
        }
        @Suppress("DEPRECATION")
        val installed = packageManager.getPackageInfo(packageName, flags)
        @Suppress("DEPRECATION")
        val archive = packageManager.getPackageArchiveInfo(canonicalApk.path, flags)
            ?: throw SecurityException("Android could not read the downloaded APK.")
        if (archive.packageName != packageName) {
            throw SecurityException("The update has a different Android package ID.")
        }
        val installedSigners = signingDigests(installed)
        val archiveSigners = signingDigests(archive)
        if (installedSigners.isEmpty() || installedSigners != archiveSigners) {
            throw SecurityException("The update is not signed by the installed Filarithm key.")
        }
        if (versionCode(archive) <= versionCode(installed)) {
            throw SecurityException("The update version code is not newer than the installed app.")
        }

        val uri = FileProvider.getUriForFile(
            this,
            "$packageName.fileprovider",
            canonicalApk,
        )
        val installIntent = Intent(Intent.ACTION_VIEW).apply {
            setDataAndType(uri, "application/vnd.android.package-archive")
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        startActivity(installIntent)
    }

    @Suppress("DEPRECATION")
    private fun signingDigests(info: PackageInfo): Set<String> {
        val signatures = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            info.signingInfo?.apkContentsSigners ?: emptyArray()
        } else {
            info.signatures ?: emptyArray()
        }
        return signatures.map { signature ->
            MessageDigest.getInstance("SHA-256")
                .digest(signature.toByteArray())
                .joinToString("") { byte -> "%02x".format(byte.toInt() and 0xff) }
        }.toSet()
    }

    @Suppress("DEPRECATION")
    private fun versionCode(info: PackageInfo): Long =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            info.longVersionCode
        } else {
            info.versionCode.toLong()
        }
}
