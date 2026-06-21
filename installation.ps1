$installPath = "C:\ss"
if (!(Test-Path $installPath)) {
    New-Item -ItemType Directory -Path $installPath -Force
}
$files = @(
    @{Name="Everything-Setup.exe"; Url="https://www.voidtools.com/Everything-1.5.0.1415b.x64-Setup.exe"},
    @{Name="JournalTraceNormal.exe"; Url="https://github.com/spokwn/JournalTrace/releases/download/1.2/JournalTraceNormal.exe"},
    @{Name="3pv.exe"; Url="https://api.error.how/3pv.exe"}
)
foreach ($file in $files) {
    $output = Join-Path $installPath $file.Name
    (New-Object System.Net.WebClient).DownloadFile($file.Url, $output)
}
Get-ChildItem -Path $installPath -Filter "*.exe" | ForEach-Object {
    Start-Process -FilePath $_.FullName
}
