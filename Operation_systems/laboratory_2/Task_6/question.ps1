$OutputEncoding = [System.Text.Encoding]::UTF8

Add-Type -AssemblyName System.Drawing

function Get-ImageSize {
    param(
        [string]$filePath
    )

    try {
        $image = [System.Drawing.Image]::FromFile($filePath)
        $size = $image.Width * $image.Height * 3  # Умножаем на 3, так как каждый пиксель состоит из 3 байт (RGB)
        $image.Dispose()
        return $size
    } catch {
        return 0
    }
}

function Get-TotalSize {
    param(
        [string]$directory
    )

    $totalSize = 0
    $files = Get-ChildItem -Path $directory -Recurse -Include *.bmp,*.jpg,*.jpeg -ErrorAction SilentlyContinue

    foreach ($file in $files) {
        $totalSize += Get-ImageSize $file.FullName
    }

    return $totalSize
}

$windowsDirectory = 'C:\Windows'
$totalSize = Get-TotalSize $windowsDirectory
Write-Host "Общий объем графических файлов (BMP, JPG) в каталоге Windows и его подкаталогах: $totalSize байт"
