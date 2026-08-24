# ============================================================================
#  Feedbacks-to-MD.ps1  —  MAVOmusic feedback exporter
# ----------------------------------------------------------------------------
#  WHY:  A static website cannot write files onto itself. Your feedback box
#        is collected safely by Netlify Forms instead. This script turns the
#        Netlify export into the numbered MD files you asked for:
#            feedbacks\Feedbacks (1).md
#            feedbacks\Feedbacks (2).md
#            feedbacks\Feedbacks (3).md ...
#
#  HOW TO USE (2 minutes, once every so often):
#   1. Open  https://app.netlify.com  -> your "mavomusic" site
#      -> left menu "Forms" -> the "feedback" form.
#      (Every message that passes the on-page validation is listed there,
#       with name, message, date. You can read them right there too.)
#   2. Click  "Export to CSV"  and save the file INTO THIS FOLDER.
#   3. Right-click this script -> "Run with PowerShell".
#   4. A new  feedbacks\  folder appears with one MD file per message,
#      numbered oldest -> newest. Open any of them in Notepad.
#
#  The script is safe: it only READS the csv and only WRITES inside
#  the new "feedbacks" folder. Re-run it any time — it rebuilds the folder.
# ============================================================================

$here   = Split-Path -Parent $MyInvocation.MyCommand.Path
$csvHit = Get-ChildItem -Path $here -Filter *.csv |
          Sort-Object LastWriteTime -Descending | Select-Object -First 1

if (-not $csvHit) {
    Write-Host ""
    Write-Host "No .csv file found in this folder." -ForegroundColor Yellow
    Write-Host "Download it first: Netlify -> your site -> Forms -> feedback -> Export to CSV." -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "Reading: $($csvHit.Name)" -ForegroundColor Cyan
$rows = Import-Csv -Path $csvHit.FullName
if ($rows.Count -eq 0) { Write-Host "That csv is empty." -ForegroundColor Yellow; exit 1 }

# Find the real column names (Netlify labels them loosely, we guess safely).
$props   = $rows[0].psobject.Properties.Name
$nameCol = $props | Where-Object { $_ -match 'name' }   | Select-Object -First 1
$msgCol  = $props | Where-Object { $_ -match 'message' } | Select-Object -First 1
$dateCol = $props | Where-Object { $_ -match 'created|date|submit|time' } | Select-Object -First 1
if (-not $nameCol) { $nameCol = $props[0] }
if (-not $msgCol)  { $msgCol  = $props[1] }

# Oldest first so early messages get the low numbers.
if ($dateCol) {
    $rows = $rows | Sort-Object { try { [datetime]$_.$dateCol } catch { [datetime]::MinValue } }
}

$outDir = Join-Path $here "feedbacks"
if (Test-Path $outDir) { Remove-Item $outDir -Recurse -Force }
New-Item -ItemType Directory -Path $outDir | Out-Null

$i = 1
foreach ($row in $rows) {
    $name = ($row.$nameCol | Out-String).Trim()
    $msg  = ($row.$msgCol  | Out-String).Trim()
    $when = if ($dateCol) { ("{0}" -f $row.$dateCol) } else { "date not in export" }
    if ($name.Length -eq 0 -and $msg.Length -eq 0) { continue }

    $body = @"
# Feedback $i — $name

*Received: $when*

---

$msg

---

*Collected by the feedback box on https://mavomusic.co.uk*
"@
    $file = Join-Path $outDir ("Feedbacks ({0}).md" -f $i)
    Set-Content -Path $file -Value $body -Encoding UTF8
    $i++
}

Write-Host ""
Write-Host ("Done: {0} feedback file(s) written into  feedbacks\" -f ($i - 1)) -ForegroundColor Green
Write-Host "They are numbered: Feedbacks (1).md, Feedbacks (2).md, ..." -ForegroundColor Green
Write-Host ""
