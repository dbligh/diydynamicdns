# Update the variable below with your AWS Route53 A Record Hostname
$hostname = 'yourdomain.com'
$hostedZoneID = 'Z00000000000000'
$logFile = 'C:\tmp\log.json'

# Start Function Block

function debugLog {
    param (
        $log
    )
    $date = Get-Date -Format "[yyyy/MM/dd - HH:mm:ss]"
    "$date - $log" | Out-File -FilePath $logFile -Encoding ascii -Append
} 

# End Function Block

debugLog( "Start Script" )

# Get your external IP address
$WebResponse = curl https://api.ipify.org?format=json | ConvertFrom-Json
debugLog( "Web Response: $WebResponse" )
$IP = $WebResponse.ip
$BatchJob=@"
{
  "Comment": "Essentially a dynamic DNS solution",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "$hostname",
        "Type": "A",
        "TTL": 120,
        "ResourceRecords": [
          {
            "Value": "$IP"
          }
        ]
      }
    }
  ]
}
"@

$BatchJob | Out-File -FilePath C:\tmp\change-record-set-dynamic.json -Encoding ascii
debugLog( "Completed Writing to File" )
$executeAWS = aws route53 change-resource-record-sets --hosted-zone-id $hostedZoneID --change-batch file://C:\tmp\change-record-set-dynamic.json --profile Route53Prod 2>&1
debugLog( $executeAWS )
debugLog( "Completed AWS Command - Exiting" )

Exit

