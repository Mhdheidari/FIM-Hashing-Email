<h1>Integrity_PowerShell_FIM_Email </h1>

#### Automated Cybersecurity Analyzing:
These scripts `SecurePassword-Email.ps1` `FIM-Hashing-Email.ps1` are designed to enhance cybersecurity measures through automated monitoring and alerting, providing real-time notifications of any file changes within the specified folder. These scripts provides a file integrity monitoring (FIM) mechanism with email alerts for system administrators or users concerned about file changes within a specific folder. 

#### Script Functionality:
The script monitors a specified folder for changes in files. It can:
- Create a baseline of file hashes in a "baseline.txt" file.
- Continuously monitor files in the specified folder against this baseline.
- Send email notifications when:
  - A new file is created.
  - An existing file is changed.
  - A file is deleted.

### Usage:

#### Collecting Baseline (Option A):
- Run the script and select option A to collect a baseline of file hashes.
- This scans all files in the specified folder and calculates their SHA512 hashes.
- Writes the file paths and hashes to a `baseline.txt` file in the script directory.

#### Monitoring Files (Option B):
- Run the script and select option B to begin monitoring files against the baseline.
- Continuously checks files in the specified folder against the baseline hashes.
- Sends email notifications when:
  - A new file is created (not in the baseline).
  - An existing file's hash does not match the stored baseline hash.
  - A file is deleted (not found in the monitored folder).

### Email Notifications:
- Emails are sent using the specified SMTP server.
- Email notifications include:
  - Subject indicating the event type (new file, changed file, deleted file).
  - Body providing details such as the file path and event description.

### Secure Password:
- The script`SecurePassword-Email.ps1` uses a secure password stored in a file for sending emails.
- The secure password is retrieved from the file `password.txt`.
- This ensures the password is not directly visible in the script for security.

### Script Execution:
- **Choose Action:**
  - Select option A to collect a baseline or option B to monitor files.

#### Baseline Collection (Option A):
- Calculates file hashes for all files in the specified folder.
- Stores file paths and hashes in `baseline.txt`.

#### File Monitoring (Option B):
- Continuously checks for file changes against the baseline.
- Sends email notifications for:
  - New files created.
  - Changes in existing files.
  - Deleted files.

### Example Usage:
#### Scenario:
- You have a folder `FIM` that should not have any unexpected changes.
- You want to be notified if:
  - New files are added.
  - Existing files are modified.
  - Files are deleted from the folder.

#### Steps:
1. Run the script and choose option A to set the baseline.
2. Leave the script running or run it periodically in the background.
3. If any changes occur in the `FIM` folder:
   - You'll receive email notifications indicating the nature of the change.
   - Emails will only be sent once per change event (creation, modification, deletion).

### Notes:
- Ensure you have configured SMTP server settings for email notifications.
- Customize the script variables (`$sendmbx`, `$receivembx`, `$pwd_2`, etc.) as per your email setup.
- Adjust the monitored folder path (`.\FIM`) as needed for your environment.
- This script provides a file integrity monitoring mechanism with email alerts for system administrators or users concerned about file changes within a specific folder.
- It uses a secure password stored in `password.txt` for sending emails, enhancing script security.



<br /><br /><br /><br /><br /><br />

- <b>Server 2019</b>

<h2>Program walk-through:</h2>

<p align="center">
<b>Project Scenario:</b>  <br />
<img src="https://i.imgur.com/qVqBZJo.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />  
<b>Install Oracle VirtualBox:</b> <br />
<img src="https://i.imgur.com/Jrrj3lR.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br /> 
<b>Install Windows Server 2019 ISO on VM:</b> <br />
<img src="https://i.imgur.com/NTMjlL2.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br /> 
<b>Install Windows 10 ISO on VM:</b> <br />
<img src="https://i.imgur.com/DLG2F9L.png"80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br /> 
<b>Rename the Network Connections:</b> <br />
<img src="https://i.imgur.com/ypDq1sx.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br /> 
<b>Set (TCP/IP) properties for Internal Connection:</b> <br />
<img src="https://i.imgur.com/ZJ9szlY.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Install Active Directory Domain Services on Server:</b> <br />
<img src="https://i.imgur.com/Nr6S8Dx.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Creat a domain name:</b> <br />
<img src="https://i.imgur.com/j7lQcqb.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Creat Admin Organization Unit:</b> <br />
<img src="https://i.imgur.com/4TFp8RS.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Creat Admin User:</b> <br />
<img src="https://i.imgur.com/s7M1T5l.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/rBPHtrY.jpeg" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Setup Remote Access Server (RAS):</b> <br />
Allow Client1 on Windows 10 to access to the internet throughout the Domain Controller (DC)
<img src="https://i.imgur.com/NLCb2IK.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/VWLf3IN.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/lFy3Z2f.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/r5c6MSm.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/aMvmNWl.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Setup DHCP Server on Domain Controller:</b> <br />
Allow Client1 on Windows 10 to to get IP address that get them allow to browse the internet
<img src="https://i.imgur.com/7Ch2ik2.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /> 
<img src="https://i.imgur.com/D0LfRvA.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/TtLou4W.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/uWqG8O0.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/2CgXxYR.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/YrDfOQU.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Create sample users by PowerShell:</b> <br />
<img src="https://i.imgur.com/v9e1Orw.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /> 
<img src="https://i.imgur.com/FuUvwfS.jpeg" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /> 
<img src="https://i.imgur.com/vGk1Vvu.jpeg" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /> 
<img src="https://i.imgur.com/DdepuLs.jpeg" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Create New VM as a Client1 and install Windows 10 ISO:</b> <br />
<img src="https://i.imgur.com/G4w0cm8.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/KxEQjSt.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/InDi0Vp.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />  
<img src="https://i.imgur.com/ElQ8ABN.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br /> 
<b>Change the computer name and login with one of the users:</b> <br />
<img src="https://i.imgur.com/4CWkkpy.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<img src="https://i.imgur.com/lnnjo5X.jpeg" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />  
</p>
<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
