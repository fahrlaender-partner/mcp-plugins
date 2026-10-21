# Baut das Submission-ZIP für das ChatGPT Plugin Directory.
# Der Plugin-Inhalt liegt im ZIP auf oberster Ebene (plugin.json im Root), wie OpenAI es für den Upload erwartet.
# Compress-Archive wird bewusst nicht verwendet: es schreibt unter Windows PowerShell 5.1 Backslashes in die
# Eintragsnamen, was beim Entpacken auf Linux-Systemen zu kaputten Pfaden führt.
param(
    [string]$Plugin = "fpre-tools"
)

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$repoRoot = Split-Path -Parent $PSScriptRoot
$pluginDir = Join-Path $repoRoot "plugins\$Plugin"
$manifest = Get-Content (Join-Path $pluginDir "plugin.json") -Raw -Encoding UTF8 | ConvertFrom-Json
$distDir = Join-Path $repoRoot "dist"
$zipPath = Join-Path $distDir "$Plugin-$($manifest.version).zip"

New-Item -ItemType Directory -Force $distDir | Out-Null
Remove-Item -Force $zipPath -ErrorAction SilentlyContinue

$zip = [IO.Compression.ZipFile]::Open($zipPath, [IO.Compression.ZipArchiveMode]::Create)
try {
    Get-ChildItem -Recurse -File $pluginDir | ForEach-Object {
        $entryName = $_.FullName.Substring($pluginDir.Length + 1).Replace('\', '/')
        [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $_.FullName, $entryName, [IO.Compression.CompressionLevel]::Optimal) | Out-Null
    }
}
finally {
    $zip.Dispose()
}

Write-Host "ZIP erstellt: $zipPath"
