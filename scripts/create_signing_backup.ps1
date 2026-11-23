param(
    [Parameter(Mandatory = $true)]
    [string]$RepositoryRoot,
    [Parameter(Mandatory = $true)]
    [string]$BackupDirectory,
    [Parameter(Mandatory = $true)]
    [string]$CredentialsDirectory
)

$ErrorActionPreference = 'Stop'
$repo = [IO.Path]::GetFullPath($RepositoryRoot)
$androidDirectory = Join-Path $repo 'android'
$keystore = Join-Path $androidDirectory 'filarithm-release.jks'
$properties = Join-Path $androidDirectory 'key.properties'
$backupDirectoryResolved = [IO.Path]::GetFullPath($BackupDirectory)
$credentialsDirectoryResolved = [IO.Path]::GetFullPath($CredentialsDirectory)

if ($backupDirectoryResolved.StartsWith($repo, [StringComparison]::OrdinalIgnoreCase)) {
    throw 'The signing backup must be outside the Git repository.'
}
if ($credentialsDirectoryResolved.StartsWith($repo, [StringComparison]::OrdinalIgnoreCase)) {
    throw 'The signing credentials must be outside the Git repository.'
}

[IO.Directory]::CreateDirectory($backupDirectoryResolved) | Out-Null
[IO.Directory]::CreateDirectory($credentialsDirectoryResolved) | Out-Null

$randomBytes = [byte[]]::new(36)
[Security.Cryptography.RandomNumberGenerator]::Fill($randomBytes)
$password = [Convert]::ToBase64String($randomBytes).Replace('+', '-').Replace('/', '_').TrimEnd('=')
$alias = 'filarithm-release'
$keytool = if ($env:JAVA_HOME) {
    Join-Path $env:JAVA_HOME 'bin\keytool.exe'
} else {
    (Get-Command keytool.exe -ErrorAction Stop).Source
}

if (Test-Path -LiteralPath $keystore) {
    throw "Refusing to overwrite existing keystore: $keystore"
}

& $keytool -genkeypair -v -keystore $keystore -storetype JKS -storepass $password -keypass $password -alias $alias -keyalg RSA -keysize 4096 -validity 10000 -dname 'CN=AVEONEX Filarithm, OU=Mobile, O=AVEONEX, L=Dubai, ST=Dubai, C=AE'
if ($LASTEXITCODE -ne 0) {
    throw "keytool failed with exit code $LASTEXITCODE"
}

$propertiesContent = @(
    'storeFile=filarithm-release.jks'
    "storePassword=$password"
    "keyPassword=$password"
    "keyAlias=$alias"
) -join [Environment]::NewLine
[IO.File]::WriteAllText($properties, $propertiesContent, [Text.UTF8Encoding]::new($false))

$backupFile = Join-Path $backupDirectoryResolved 'filarithm-release-keystore-backup.jks'
[IO.File]::Copy($keystore, $backupFile, $false)
$sha256 = (Get-FileHash -LiteralPath $backupFile -Algorithm SHA256).Hash.ToLowerInvariant()
$credentialsFile = Join-Path $credentialsDirectoryResolved 'filarithm-signing-credentials.txt'
$credentialsContent = @(
    'Filarithm Android release signing credentials'
    "Alias: $alias"
    "Store password: $password"
    "Key password: $password"
    "Backup SHA-256: $sha256"
    "Backup file: $backupFile"
) -join [Environment]::NewLine
[IO.File]::WriteAllText($credentialsFile, $credentialsContent, [Text.UTF8Encoding]::new($false))

Write-Output "Keystore: $keystore"
Write-Output "Encrypted backup: $backupFile"
Write-Output "Credentials: $credentialsFile"
Write-Output "SHA256: $sha256"
