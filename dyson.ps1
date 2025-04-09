# Prompt for inputs
$userPrincipalName = Read-Host "Enter your User Principal Name (e.g., user@domain.com)"
$searchName = Read-Host "Enter a name for the Compliance Search"
$emailSubject = Read-Host "Enter the email subject to search for"
$senderAddress = Read-Host "Enter the sender email address"

# Connect to IPPSSession
Write-Host "Connecting to IPPSSession for $userPrincipalName..." -ForegroundColor Cyan
Connect-IPPSSession -UserPrincipalName $userPrincipalName

# Build the query
$contentMatchQuery = "subject:`"$emailSubject`" AND from:`"$senderAddress`""

# Create the Compliance Search
Write-Host "Creating Compliance Search: $searchName" -ForegroundColor Green
New-ComplianceSearch -Name $searchName -ExchangeLocation All -ContentMatchQuery $contentMatchQuery

# Wait for search to initialize
Write-Host "Waiting for search to initialize..." -ForegroundColor Yellow

# Wait x seconds 
Start-Sleep -Seconds 30

# Start the search
Write-Host "Starting Compliance Search: $searchName" -ForegroundColor Cyan
Start-ComplianceSearch -Identity $searchName

# Wait x seconds 
Start-Sleep -Seconds 60

# Check Status
Write-Host "Checking Status: $searchName" -ForegroundColor Cyan
Get-ComplianceSearch -Identity $searchName

Write-Host "Compliance Search '$searchName' started successfully!" -ForegroundColor Magenta