# Connect to Graph

#Connect-MgGraph -Scopes "AuditLog.Read.All" -UseDeviceAuthentication

Connect-MgGraph -Scopes "AuditLog.Read.All", "Directory.Read.All"


# Fetch sign-ins
$signIns = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/auditLogs/signIns"

# Filter: riskLevel ≠ none
$riskySignIns = $signIns.value | Where-Object {
    $_.riskLevelDuringSignIn -and $_.riskLevelDuringSignIn -ne "none"
}

# Output
$riskySignIns | ForEach-Object {
    [PSCustomObject]@{
        User      = $_.userPrincipalName
        RiskLevel = $_.riskLevelDuringSignIn
        Time      = $_.createdDateTime
        Location  = $_.location.city
        Status    = $_.status.errorCode
    }
} | Format-Table -AutoSize