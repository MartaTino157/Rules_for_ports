$data=Import-Csv "C:\Users\Administrator\Desktop\ports.csv" -Delimiter ":" -Header title,status,protocol,port
$remote_host=New-PSSession -ComputerName 192.168.11.2 -Credential User
foreach ($edit in $data)
{
    Invoke-Command -ScriptBlock{
    #Get-NetTCPConnection -State Listen
       # if(Get-NetTCPConnection -LocalPort $Using:edit.port -State Listen -ErrorAction Ignore){
            New-NetFirewallRule -DisplayName $Using:edit.title -Action $Using:edit.status -Protocol $Using:edit.protocol -LocalPort $Using:edit.port | Out-Null
            Write-Host "The settings for port" $Using:edit.port "was edited!" -ForegroundColor DarkCyan
       # }else{
        #    Write-Host "The port" $Using:edit.port "does not exist in the system!" -ForegroundColor Red
        #}
    } -Session $remote_host
}