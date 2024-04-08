# File Integrity Monitoring with Email Alerts
# Description:
# This PowerShell script provides a file integrity monitoring mechanism with email alerts for system administrators or users concerned about file changes within a specific folder. It allows users to:
#   - Collect a new baseline of file hashes (Option A).
#   - Begin monitoring files against the saved baseline (Option B).
# When monitoring (Option B) is chosen:
#   - The script continuously checks files in the specified folder against the baseline hashes.
#   - Sends email notifications for:
#       - New files created.
#       - Changes in existing files.
#       - Deleted files.
#***************************************************************************************************************
# Author: Mohammad Heidari
# Date: September 2023
# Version: 1.0
# Last Updated: April 15, 2024
#
# Dependencies:
#   - PowerShell 5.1 or higher
#   - Access to an SMTP server for sending emails
#---------------------------------------------------------------------------------------------------------------

# Function to calculate SHA512 hash of a file
Function Calculate-File-Hash($filepath) {
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $filehash
}

# Function to erase baseline.txt if it already exists
Function Erase-Baseline-If-Already-Exists() {
    $baselineExists = Test-Path -Path .\baseline.txt

    if ($baselineExists) {
        # Delete baseline.txt
        Remove-Item -Path .\baseline.txt
    }
}

# Function to send email notification
Function Send-NotificationEmail($subject, $body) {
    $sendmbx = "heidarimhd@outlook.com"
    $receivembx = "heidarimhd@outlook.com"
    $passwordFile = "C:\Users\Mohammad\Documents\PowerShell-Integrity Project\password.txt"

    # Read the secure password from file
    $securePassword = Get-Content -Path $passwordFile | ConvertTo-SecureString

    $credential = New-Object System.Management.Automation.PSCredential($sendmbx, $securePassword)

    $props = @{
        SMTPServer = "smtp.office365.com"
        From = $sendmbx
        To = $receivembx
        Subject = $subject
        Body = $body
        UseSSL = $true
        Port = 587
        Credential = $credential
    }

    Send-MailMessage @props
}

# Set TLS 1.2 for secure communication
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host ""
Write-Host "What would you like to do?"
Write-Host ""
Write-Host "    A) Collect new Baseline?"
Write-Host "    B) Begin monitoring files with saved Baseline?"
Write-Host ""
$response = Read-Host -Prompt "Please enter 'A' or 'B'"
Write-Host ""

if ($response -eq "A".ToUpper()) {
    # Delete baseline.txt if it already exists
    Erase-Baseline-If-Already-Exists

    # Calculate Hash from the target files and store in baseline.txt
    # Collect all files in the target folder
    $files = Get-ChildItem -Path .\FIM

    # For each file, calculate the hash, and write to baseline.txt
    foreach ($f in $files) {
        $hash = Calculate-File-Hash $f.FullName
        "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append
    }
}
elseif ($response -eq "B".ToUpper()) {
    # Dictionary to keep track of changed and created files
    $fileHashDictionary = @{}
    $changedFiles = @{}
    $createdFiles = @{}

    # Load file|hash from baseline.txt and store them in a dictionary
    $filePathsAndHashes = Get-Content -Path .\baseline.txt
    
    foreach ($f in $filePathsAndHashes) {
         $fileHashDictionary.add($f.Split("|")[0], $f.Split("|")[1])
    }

    # Begin (continuously) monitoring files with saved Baseline
    while ($true) {
        Start-Sleep -Seconds 1
        
        $files = Get-ChildItem -Path .\FIM

        foreach ($f in $files) {
            $hash = Calculate-File-Hash $f.FullName

            # Notify if a new file has been created
            if ($fileHashDictionary[$hash.Path] -eq $null -and -not $createdFiles.ContainsKey($hash.Path)) {
                # A new file has been created!
                $createdFiles[$hash.Path] = $true

                Write-Host "$($hash.Path) has been created!" -ForegroundColor Green

                $subject = "New File Created: $($hash.Path)"
                $body = "A new file $($hash.Path) has been created."
                Send-NotificationEmail $subject $body
            }
            elseif ($fileHashDictionary[$hash.Path] -ne $null) {
                # Check if file hash has changed
                if ($fileHashDictionary[$hash.Path] -ne $hash.Hash) {
                    # File has changed
                    if (-not $changedFiles.ContainsKey($hash.Path)) {
                        # File has changed and not already notified
                        $changedFiles[$hash.Path] = $true

                        Write-Host "$($hash.Path) has changed!!!" -ForegroundColor Yellow

                        $subject = "File Changed: $($hash.Path)"
                        $body = "The file $($hash.Path) has been changed."
                        Send-NotificationEmail $subject $body
                    }
                }
                else {
                    # Reset the flag for this file if the hash matches
                    $changedFiles.Remove($hash.Path)
                }
            }
        }

        # Check for deleted files
        foreach ($key in $fileHashDictionary.Keys) {
            $baselineFileStillExists = Test-Path -Path $key
            if (-Not $baselineFileStillExists) {
                # File has been deleted
                if (-not $changedFiles.ContainsKey($key)) {
                    # File deletion not yet notified
                    $changedFiles[$key] = $true

                    Write-Host "$($key) has been deleted!" -ForegroundColor DarkRed -BackgroundColor Gray

                    $subject = "File Deleted: $($key)"
                    $body = "The file $($key) has been deleted."
                    Send-NotificationEmail $subject $body
                }
            }
        }
    }
}
