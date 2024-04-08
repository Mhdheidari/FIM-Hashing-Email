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
  
<br /><br />

<h2>Program walk-through:</h2>

<p align="center">
<b>Unrestricted policy and set the file path:</b>  <br />
<img src="https://i.imgur.com/toODk1m.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />  
<b>Collect new Baseline:</b> <br />
<img src="https://i.imgur.com/k9L4EHz.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br /> 
<b>Hashing the password:</b> <br />
<img src="https://i.imgur.com/QbKTMjp.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br /> 
<b>Content of the original files:</b> <br />
<img src="https://i.imgur.com/svvjLxw.png"80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br /> 
<b>Changing the content and pop up the "First.txt has changed!!!" alert message:</b> <br />
<img src="https://i.imgur.com/BCFWFo7.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br /> 
<b>Receiving the alert email:</b> <br />
<img src="https://i.imgur.com/wn7wFZF.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Adding a new file and pop up "Forth.txt has been created!:</b> <br />
<img src="https://i.imgur.com/z9zG5ae.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Receiving the alert email:</b> <br />
<img src="https://i.imgur.com/l9hBaBj.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Deleting an original file and pop up the "Third.txt has been deleted!:</b> <br />
<img src="https://i.imgur.com/dvExEqb.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br /><br /><br />
<b>Receiving the alert email:</b> <br />
<img src="https://i.imgur.com/hpd8OSK.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
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
