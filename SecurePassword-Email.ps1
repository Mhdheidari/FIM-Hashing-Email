# Convert your password to a secure string
$securePassword = ConvertTo-SecureString -String "Password" -AsPlainText -Force

# Export the secure password to a file
$securePassword | ConvertFrom-SecureString | Out-File -FilePath "C:\Users\Mohammad\PowerShell-Integrity Project\password.txt"