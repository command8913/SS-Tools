$logs = @("Application", "System")
$eventIDs = @(3079, 104) 
function Clear-SpecificEventLogs { 
    param ( 
        [Parameter(Mandatory = $true)] 
        [string[]]$Logs, 
        [Parameter(Mandatory = $true)]
        [int[]]$EventIDs 
    ) 
    foreach ($log in $Logs) { 
        Write-Host "Обработка журнала: $log" 
        try { 
            foreach ($eventID in $eventIDs) { 
                if (($log -eq "Application" -and $eventID -eq 3079) -or
                    ($log -eq "System" -and $eventID -eq 104)) { 
                    $events = Get-WinEvent -LogName $log -ErrorAction SilentlyContinue | Where-Object { $_.Id -eq $eventID } 
                    if ($events -and $events.Count -gt 0) { 
                        $eventCount = $events.Count 
                        Write-Host "Найдено $eventCount событий с ID $eventID в журнале $log" 
                        foreach ($event in $events) { 
                            $eventTime = $event.TimeCreated 
                            Write-Host ("Удаление записи ID " + $eventID + ": " + $eventTime) -ForegroundColor Red 
                        }
                        $currentTime = (Get-Date).ToString("") 
                        Write-Host ($eventID + " очищен в " + $currentTime) 
                    } else { 
                        Write-Host "Событий с ID $eventID в журнале $log не найдено" 
                    } 
                } 
            } 
        } catch {
            continue 
        } 
    } 
} 
Clear-SpecificEventLogs -Logs $logs -EventIDs $eventIDs
    