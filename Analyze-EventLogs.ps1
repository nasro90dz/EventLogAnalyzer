# Analyze-EventLogs.ps1

$logName = "System"  # Could be Application, Security, etc.
$days = 3            # Logs from the last X days
$level = 2           # 1=Critical, 2=Error, 3=Warning, 4=Information

$since = (Get-Date).AddDays(-$days)
$output = ".\eventlog_$logName_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').csv"

$logs = Get-WinEvent -FilterHashtable @{
    LogName = $logName;
    Level = $level;
    StartTime = $since
} -ErrorAction SilentlyContinue | 
    Select-Object TimeCreated, Id, LevelDisplayName, Message

$logs | Export-Csv -Path $output -NoTypeInformation -Encoding UTF8

Write-Host "✅ $logName log scan complete. Output saved to: $output"
