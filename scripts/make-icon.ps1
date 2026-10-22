# Rendert das FPRE-Icon (drei abgerundete Balken aus assets/icon.svg) als 512x512 PNG.
# Anthropic's Directory verlangt laut Community-Berichten ein PNG/JPEG im Plugin-Ordner; SVG reicht dort nicht.
param(
    [string]$Plugin = "fpre-tools",
    [int]$Size = 512
)

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

$repoRoot = Split-Path -Parent $PSScriptRoot
$outPath = Join-Path $repoRoot "plugins\$Plugin\assets\icon.png"

# Geometrie aus icon.svg (viewBox 24x24): Balken als (x, y, w, h, Farbe), Eckradius 2.5
$bars = @(
    @{ x = 3;  y = 11; w = 6; h = 10; color = "#FFD400"; corners = "left"  },
    @{ x = 15; y = 7;  w = 6; h = 14; color = "#F75858"; corners = "right" },
    @{ x = 9;  y = 3;  w = 6; h = 18; color = "#FFA43D"; corners = "top"   }
)
$scale = $Size / 24.0
$radius = 2.5 * $scale

function New-BarPath([double]$x, [double]$y, [double]$w, [double]$h, [double]$r, [string]$corners) {
    $p = New-Object System.Drawing.Drawing2D.GraphicsPath
    $d = 2 * $r
    switch ($corners) {
        "top" {
            $p.AddArc($x, $y, $d, $d, 180, 90)
            $p.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
            $p.AddLine($x + $w, $y + $h, $x, $y + $h)
        }
        "left" {
            $p.AddArc($x, $y, $d, $d, 180, 90)
            $p.AddLine($x + $w, $y, $x + $w, $y + $h)
            $p.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
        }
        "right" {
            $p.AddLine($x, $y, $x + $w - $r, $y)
            $p.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
            $p.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
            $p.AddLine($x, $y + $h, $x, $y)
        }
    }
    $p.CloseFigure()
    return $p
}

$bmp = New-Object System.Drawing.Bitmap $Size, $Size
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.Clear([System.Drawing.Color]::Transparent)

foreach ($b in $bars) {
    $path = New-BarPath ($b.x * $scale) ($b.y * $scale) ($b.w * $scale) ($b.h * $scale) $radius $b.corners
    $brush = New-Object System.Drawing.SolidBrush ([System.Drawing.ColorTranslator]::FromHtml($b.color))
    $g.FillPath($brush, $path)
    $brush.Dispose(); $path.Dispose()
}

$g.Dispose()
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Host "PNG erstellt: $outPath"
