# Function to display ASCII art banner
function Display-Banner {
    Write-Host "▓█████▓██   ██▓▓█████     ▒█████    █████▒" -ForegroundColor Cyan
    Write-Host "▓█   ▀ ▒██  ██▒▓█   ▀    ▒██▒  ██▒▓██   ▒" -ForegroundColor Cyan
    Write-Host "▒███    ▒██ ██░▒███      ▒██░  ██▒▒████ ░" -ForegroundColor Cyan
    Write-Host "▒▓█  ▄  ░ ▐██▓░▒▓█  ▄    ▒██   ██░░▓█▒  ░" -ForegroundColor Cyan
    Write-Host "░▒████▒ ░ ██▒▓░░▒████▒   ░ ████▓▒░░▒█░" -ForegroundColor Cyan
    Write-Host "░░ ▒░ ░  ██▒▒▒ ░░ ▒░ ░   ░ ▒░▒░▒░  ▒ ░" -ForegroundColor Cyan
    Write-Host " ░ ░  ░▓██ ░▒░  ░ ░  ░     ░ ▒ ▒░  ░" -ForegroundColor Cyan
    Write-Host "   ░   ▒ ▒ ░░     ░      ░ ░ ░ ▒   ░ ░" -ForegroundColor Cyan
    Write-Host "   ░  ░░ ░        ░  ░       ░ ░" -ForegroundColor Cyan
    Write-Host "       ░ ░"
    Write-Host "  ██████  ▄▄▄       █    ██  ██▀███   ▒█████   ███▄    █" -ForegroundColor Cyan
    Write-Host "▒██    ▒ ▒████▄     ██  ▓██▒▓██ ▒ ██▒▒██▒  ██▒ ██ ▀█   █" -ForegroundColor Cyan
    Write-Host "░ ▓██▄   ▒██  ▀█▄  ▓██  ▒██░▓██ ░▄█ ▒▒██░  ██▒▓██  ▀█ ██▒" -ForegroundColor Cyan
    Write-Host "  ▒   ██▒░██▄▄▄▄██ ▓▓█  ░██░▒██▀▀█▄  ▒██   ██░▓██▒  ▐▌██▒" -ForegroundColor Cyan
    Write-Host "▒██████▒▒ ▓█   ▓██▒▒▒█████▓ ░██▓ ▒██▒░ ████▓▒░▒██░   ▓██░" -ForegroundColor Cyan
    Write-Host "▒ ▒▓▒ ▒ ░ ▒▒   ▓▒█░░▒▓▒ ▒ ▒ ░ ▒▓ ░▒▓░░ ▒░▒░▒░ ░ ▒░   ▒ ▒" -ForegroundColor Cyan
    Write-Host "░ ░▒  ░ ░  ▒   ▒▒ ░░░▒░ ░ ░   ░▒ ░ ▒░  ░ ▒ ▒░ ░ ░░   ░ ▒░" -ForegroundColor Cyan
    Write-Host "░  ░  ░    ░   ▒    ░░░ ░ ░   ░░   ░ ░ ░ ░ ▒     ░   ░ ░" -ForegroundColor Cyan
    Write-Host "      ░        ░  ░   ░        ░         ░ ░           ░" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Welcome to the Eye of Sauron - IP/Domain Lookup" -ForegroundColor Green
    Write-Host ""
}

# Call the banner function at the beginning of the script
Display-Banner
# Function to perform IP information lookup using ipinfo.io (Geolocation)
function Get-IpInfo {
    param (
        [string]$IPAddress
    )
    Write-Host "[IP Info Lookup]" -ForegroundColor Yellow
    try {
        # Use Invoke-RestMethod to query ipinfo.io
        $uri = "https://ipinfo.io/$IPAddress/json"
        $response = Invoke-RestMethod -Uri $uri -ErrorAction Stop

        if ($response) {
            Write-Host "Geolocation and IP Info for ${IPAddress}:" -ForegroundColor Cyan
            Write-Host "IP: $($response.ip)"
            Write-Host "Hostname: $($response.hostname)"
            Write-Host "City: $($response.city)"
            Write-Host "Region: $($response.region)"
            Write-Host "Country: $($response.country)"
            Write-Host "Location: $($response.loc)"
            Write-Host "Organization: $($response.org)"
            Write-Host "Postal Code: $($response.postal)"
            Write-Host "Timezone: $($response.timezone)"
        } else {
            Write-Host "No data returned from ipinfo.io for ${IPAddress}" -ForegroundColor Red
        }
    } catch {
        Write-Host "Error querying ipinfo.io for ${IPAddress}. Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Function to perform DNS lookup for a domain using nslookup
function Get-DnsInfo {
    param (
        [string]$Domain
    )
    Write-Host "[DNS Lookup using nslookup]" -ForegroundColor Yellow

    # Perform A Record lookup
    try {
        Write-Host "Querying A records for ${Domain}..."
        $aRecords = nslookup $Domain 2>&1 | Select-String "Address:" | ForEach-Object { $_.Line -replace "Address:\s+", "" }
        if ($aRecords) {
            foreach ($record in $aRecords) {
                Write-Host "A Record (IP Address): $record" -ForegroundColor Cyan
            }
        } else {
            Write-Host "No A records found." -ForegroundColor Red
        }
    } catch {
        Write-Host "Error querying A records for ${Domain}. Error: $($_.Exception.Message)" -ForegroundColor Red
    }

    # Perform MX Record lookup
    try {
        Write-Host "Querying MX records for ${Domain}..."
        $mxRecords = nslookup -query=MX $Domain 2>&1 | Select-String "mail exchanger" | ForEach-Object { $_.Line -replace "mail exchanger = ", "" }
        if ($mxRecords) {
            foreach ($record in $mxRecords) {
                Write-Host "MX Record (Mail Exchange): $record" -ForegroundColor Cyan
            }
        } else {
            Write-Host "No MX records found." -ForegroundColor Red
        }
    } catch {
        Write-Host "Error querying MX records for ${Domain}. Error: $($_.Exception.Message)" -ForegroundColor Red
    }

    # Perform TXT Record lookup
    try {
        Write-Host "Querying TXT records for ${Domain}..."
        $txtRecords = nslookup -query=TXT $Domain 2>&1 | Select-String "text" | ForEach-Object { $_.Line -replace "text = ", "" }
        if ($txtRecords) {
            foreach ($record in $txtRecords) {
                Write-Host "TXT Record: $record" -ForegroundColor Cyan
            }
        } else {
            Write-Host "No TXT records found." -ForegroundColor Red
        }
    } catch {
        Write-Host "Error querying TXT records for ${Domain}. Error: $($_.Exception.Message)" -ForegroundColor Red
    }

    # Perform PTR Record lookup
    try {
        Write-Host "Querying PTR records for ${Domain}..."
        $ptrRecords = nslookup -query=PTR $Domain 2>&1 | Select-String "name =" | ForEach-Object { $_.Line -replace "name = ", "" }
        if ($ptrRecords) {
            foreach ($record in $ptrRecords) {
                Write-Host "PTR Record (Reverse DNS): $record" -ForegroundColor Cyan
            }
        } else {
            Write-Host "No PTR records found." -ForegroundColor Red
        }
    } catch {
        Write-Host "Error querying PTR records for ${Domain}. Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Main Execution: Validate IPv4 or domain and perform lookups
$ipv4Regex = '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'

# User input validation
$input = Read-Host "Enter an IP Address or Domain"
if ($input -match $ipv4Regex) {
    Get-IpInfo -IPAddress $input
} else {
    Get-DnsInfo -Domain $input
}