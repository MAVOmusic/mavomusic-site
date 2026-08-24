# ----------------------------------------------------------
# YouTube players - local server
#
# YouTube embeds refuse to load from file:// pages
# ("Error 153 - Video player configuration error"),
# so open the HTML files through this tiny server instead.
#
# How to use:
#   1. Put this file in the SAME folder as the HTML files.
#   2. Right-click it -> "Run with PowerShell"
#      (or run:  powershell -ExecutionPolicy Bypass -File Localhost.ps1)
#   3. Your browser opens http://localhost:8000 automatically.
#   4. Press Ctrl+C in the console window to stop the server.
# ----------------------------------------------------------

$port = 8000
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Server running at http://localhost:$port/ - press Ctrl+C to stop"
Start-Process "http://localhost:$port/"

$mime = @{
    ".html" = "text/html; charset=utf-8"
    ".htm"  = "text/html; charset=utf-8"
    ".css"  = "text/css"
    ".js"   = "text/javascript"
    ".json" = "application/json"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
}

while ($listener.IsListening) {
    $context = $listener.GetContext()

    # Decode %20 etc. so file names containing spaces work.
    $path = [System.Uri]::UnescapeDataString($context.Request.Url.LocalPath).TrimStart("/")
    if ($path -eq "") { $path = "index.html" }

    $file = Join-Path (Get-Location) $path

    if (Test-Path $file) {
        try {
            $bytes = [System.IO.File]::ReadAllBytes($file)
            $ext = [System.IO.Path]::GetExtension($file).ToLower()
            if ($mime.ContainsKey($ext)) {
                $context.Response.ContentType = $mime[$ext]
            }
            $context.Response.ContentLength64 = $bytes.Length
            $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
        } catch {
            $context.Response.StatusCode = 500
        }
    } else {
        $context.Response.StatusCode = 404
        $msg = [System.Text.Encoding]::UTF8.GetBytes("404 - '$path' not found next to Localhost.ps1")
        $context.Response.OutputStream.Write($msg, 0, $msg.Length)
    }

    $context.Response.OutputStream.Close()
}
