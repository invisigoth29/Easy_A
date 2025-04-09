# Import Graph SDK (install if not present)
#if (-not (Get-Module -ListAvailable -Name Microsoft.Graph)) {
 #   Install-Module Microsoft.Graph -Scope CurrentUser -Force
#}
#Import-Module Microsoft.Graph

# Connect to Microsoft Graph (interactive auth)
Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.ReadWrite.All"

# Display current context
$context = Get-MgContext
Write-Host "Connected as: $($context.Account)"

# Prompt for UserPrincipalName or ObjectId
$userUPN = Read-Host "Enter the UserPrincipalName or ObjectId of the user"

# Revoke MFA session
try {
    Revoke-MgUserSignInSession -UserId $userUPN
    Write-Host "`n✅ Successfully revoked MFA session for user: $userUPN"
}
catch {
    Write-Error "❌ Failed to revoke session. $_"
}

# Optional: Disconnect session
#Disconnect-MgGraph