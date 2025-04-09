
Write-Host "================================================"
Write-Host "    	   🧙‍♂️ YOU SHALL NOT PASS! 🧙‍♂️     "            
Write-Host "     Phishy senders will be cast into the void! "
Write-Host "================================================"

#Adds transport rule to block email based on address or domain
# Ensure Exchange Online Module is loaded
if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
    Write-Host "ExchangeOnlineManagement module not found. Install it using:" -ForegroundColor Red
    Write-Host "Install-Module ExchangeOnlineManagement -Scope CurrentUser" -ForegroundColor Yellow
    return
}

# Connect to Exchange Online
Write-Host "Connecting to Exchange Online..." -ForegroundColor Cyan
Connect-ExchangeOnline -ShowBanner:$false

# Prompt for transport rule name
$ruleName = Read-Host "Enter a name for the new transport rule"

# Check if rule already exists
if (Get-TransportRule -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq $ruleName }) {
    Write-Host "A rule with that name already exists. Aborting." -ForegroundColor Red
    return
}

# Prompt for email addresses/domains
$inputList = Read-Host "Enter email addresses or domains to block (comma-separated)"

# Clean and process input
$blockedSenders = $inputList -split "," | ForEach-Object { $_.Trim() }

# Convert to regex patterns for FromAddressMatchesPatterns
$patterns = @()
foreach ($sender in $blockedSenders) {
    if ($sender -like "*@*") {
        $patterns += "^(?i)" + [Regex]::Escape($sender) + "$"
    } else {
        $patterns += "^(?i)[\w\.\-]+@" + [Regex]::Escape($sender) + "$"
    }
}

# Display the patterns
Write-Host "`nPrepared sender block patterns:" -ForegroundColor Cyan
$patterns | ForEach-Object { Write-Host $_ -ForegroundColor Yellow }

# Confirm before rule creation
$confirm = Read-Host "`nCreate rule '$ruleName' and send to hosted quarantine? (Y/N)"
if ($confirm -ne "Y") {
    Write-Host "Operation canceled." -ForegroundColor Red
    return
}

# Create transport rule to quarantine messages
New-TransportRule -Name $ruleName `
    -FromAddressMatchesPatterns $patterns `
    -Quarantine $true `
    -Comments "Redirecting blocked senders to hosted quarantine" `
    -Priority 0

Write-Host "`n✅ Transport rule '$ruleName' created successfully." -ForegroundColor Green
