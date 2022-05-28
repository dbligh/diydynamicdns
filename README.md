# DIY Dynamic DNS
Wish you could run a web host from your home network, but you're stuck with a dynamic IP address from your ISP?

These scripts allow you to dynamically update an AWS Route 53 A Record with your current ISP assigned IP address.

Run the script on a schedule to ensure the DNS record is updated in near-real time.

## Requirements

This is a Powershell script, so currently it is only supported on Windows.

This requires an AWS account. AWS has a free tier, so the cost of this solution will be neglible or free.

## Setup Instructions

Set up an AWS Route53 Hosted Zone for your domain:
https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html

Set up an A Record for your domain:
https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html

Create AWS credentials which are scoped down to only update the A Record. This is good security practice. Set up this credential locally on your Windows system.

Update the script with your AWS A Record hostname, AWS Hosted Zone ID and a location for logging.

Either execute the script manually via Powershell, or run as a scheduled task.

For Scheduled Tasks:

**Program/script**: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

**Add arguments**: -command & 'C:\path-to-your-script\dynamicDNS.ps1'

