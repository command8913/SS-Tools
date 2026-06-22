[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

$installPath = "C:\ss"
if (!(Test-Path $installPath)) {
    New-Item -ItemType Directory -Path $installPath -Force | Out-Null
}

$files = @(
    @{Name="Everything15.exe"; Url="https://github.com/command8913/SS-Tools/raw/main/Everything15.exe"},
    @{Name="JournalTraceNormal.exe"; Url="https://github.com/spokwn/JournalTrace/releases/download/1.2/JournalTraceNormal.exe"},
    @{Name="pv+.exe"; Url="https://github.com/command8913/SS-Tools/raw/main/pv%2B.exe"}
)

foreach ($file in $files) {
    $output = Join-Path $installPath $file.Name
    try {
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($file.Url, $output)
        Write-Host "Downloaded: $($file.Name)"
    } catch {
        Write-Host "Failed to download $($file.Name): $_"
    }
}

Get-ChildItem -Path $installPath -Filter "*.exe" | ForEach-Object {
    Start-Process -FilePath $_.FullName
}
