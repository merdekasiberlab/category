<#
.SYNOPSIS
  One-click installer & runner untuk “category” (auto-sort Downloads).
.DESCRIPTION
  1. Membuat folder instalasi di %LOCALAPPDATA%\category  
  2. Menyimpan skrip watcher (AutoSortDownloads)  
  3. Meng-compile watcher menjadi EXE (menggunakan PS2EXE)  
  4. Menambahkan shortcut ke folder Startup user  
  5. Langsung menjalankan watcher sekali (opsional)
#>

param(
  [switch]$RunNow
)

# --- 1. Direktori instalasi ---
$installDir = Join-Path $env:LOCALAPPDATA 'category'
if (-not (Test-Path $installDir)) {
    New-Item -Path $installDir -ItemType Directory | Out-Null
}

# --- 2. Isi skrip watcher (AutoSortDownloads.ps1) ---
$watcherCode = @'
# ===== AutoSortDownloads.ps1 =====

# Lokasi Downloads
$DownloadsPath = Join-Path $HOME 'Downloads'

# Kategori & ekstensi
$Categories = @{
    'Documents'     = @('doc','docx','pdf','txt','rtf','odt','md')
    'Spreadsheets'  = @('xls','xlsx','csv','ods')
    'Presentations' = @('ppt','pptx','odp')
    'Images'        = @('jpg','jpeg','png','gif','bmp','tiff','svg','webp')
    'Audio'         = @('mp3','wav','aac','flac','ogg','m4a')
    'Video'         = @('mp4','avi','mkv','mov','wmv','flv','webm')
    'Archives'      = @('zip','rar','7z','tar','gz','bz2','tgz')
    'Source_Code'   = @('py','js','java','cpp','c','cs','rb','go','php','html','css','ts','swift','rs')
    'Executables'   = @('exe','msi','apk','bin','app')
    'Data'          = @('json','xml','yaml','yml','sql','db','mdb','sqlite')
    'Fonts'         = @('ttf','otf','woff','woff2','eot')
    'System'        = @('dll','sys','ini','cfg','log')
}

# Buat folder kategori + sub-folder ekstensi
foreach ($cat in $Categories.Keys) {
    $dir = Join-Path $DownloadsPath $cat
    if (-not (Test-Path $dir)) { New-Item $dir -ItemType Directory | Out-Null }
    foreach ($ext in $Categories[$cat]) {
        $sub = Join-Path $dir $ext
        if (-not (Test-Path $sub)) { New-Item $sub -ItemType Directory | Out-Null }
    }
}
$others = Join-Path $DownloadsPath 'Others'
if (-not (Test-Path $others)) { New-Item $others -ItemType Directory | Out-Null }

# Fungsi move
function Process-File {
    param($path, $name)
    $ext = [IO.Path]::GetExtension($path).TrimStart('.').ToLower()
    $found = $false
    foreach ($cat in $Categories.Keys) {
        if ($Categories[$cat] -contains $ext) {
            $target = Join-Path (Join-Path $DownloadsPath $cat) $ext
            Move-Item $path $target -Force
            $found = $true; break
        }
    }
    if (-not $found) {
        $sub = Join-Path $others $ext
        if (-not (Test-Path $sub)) { New-Item $sub -ItemType Directory | Out-Null }
        Move-Item $path $sub -Force
    }
}

# Scan awal
Get-ChildItem $DownloadsPath -File | % { Process-File $_.FullName $_.Name }

# Watcher Created & Renamed
$fsw = New-Object IO.FileSystemWatcher $DownloadsPath -Property @{
    IncludeSubdirectories = $false; Filter='*.*';
    NotifyFilter = [IO.NotifyFilters]'FileName,LastWrite'
}
$action = {
    param($s,$e)
    Start-Sleep 500
    if (Test-Path $e.FullPath) { Process-File $e.FullPath $e.Name }
}
Register-ObjectEvent $fsw Created -Action $action | Out-Null
Register-ObjectEvent $fsw Renamed -Action $action | Out-Null

# Keep-alive
while ($true) { Start-Sleep 3600 }
'@

# Tulis ke disk
$ps1Path = Join-Path $installDir 'AutoSortDownloads.ps1'
Set-Content -Path $ps1Path -Value $watcherCode -Encoding UTF8

# --- 3. Compile jadi EXE (butuh modul PS2EXE) ---
Import-Module PS2EXE -ErrorAction Stop
$exePath = Join-Path $installDir 'AutoSortDownloads.exe'
Invoke-PS2EXE -InputFile $ps1Path -OutputFile $exePath -NoConsole

# --- 4. Buat shortcut ke Startup ---
$startup = [Environment]::GetFolderPath('Startup')
$link    = Join-Path $startup 'category.lnk'
$shell   = New-Object -ComObject WScript.Shell
$sc      = $shell.CreateShortcut($link)
$sc.TargetPath     = $exePath
$sc.WorkingDirectory = $installDir
$sc.WindowStyle    = 7  # Minimized
$sc.Save()

Write-Host "`n[OK] Instalasi selesai!`n" -ForegroundColor Green

# --- 5. Opsional: langsung jalankan watcher kali ini juga ---
if ($RunNow) {
    Start-Process -FilePath $exePath
    Write-Host "Watcher dijalankan sekarang…"
}
