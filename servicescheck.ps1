$services = @("Explorer", "DPS", "PCAsvc", "Bam", "CDPSvc", "Event Log", "SysMain")
foreach ($service in $services) {
    $serviceInfo = Get-Service -Name $service -ErrorAction SilentlyContinue
    if ($serviceInfo) {
        if ($serviceInfo.Status -eq "Running") {
            $status = "Включено"
            $color = "Green"
        } else {
            $status = "Отключено"
            $color = "Red"
        }
    } else {
        $status = "Включено"
        $color = "Green"
    }
    Write-Host "Служба: $service - " -NoNewline
    Write-Host $status -ForegroundColor $color
}    
