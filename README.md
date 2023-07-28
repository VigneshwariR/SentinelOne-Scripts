## Installation and Usage

1. **Download the Script**
   
   Download the script file (e.g., `sentinal-agent-install-win.ps1`) from this repository.

2. **Configure the Script**
   
   Before running the script, open it using a text editor and replace the following placeholders with your actual values:

   - Replace `https://example.com/sentinelone_package.msi` with the actual download URL for the SentinelOne package in `$SentinelOneUrl`. Please note, the package needs to be hosted so that it is reachable from the endpoints.
   - Replace `YOUR_SITE_TOKEN_HERE` with your actual SentinelOne site token in `$SiteToken`.

3. **Run the Script**

   - Open PowerShell with Administrator privileges.

   - Run the script using the following command:

     ```powershell
     .\sentinal-agent-install-win.ps1
     ```

   The script will perform the following steps:
   - Check if SentinelOne is already running. If it is, the installation will be skipped.
   - Check if the SentinelOne package already exists in the specified folder. If it does, it will proceed with the installation. Otherwise, it will download the package and then install it.
   - Link the package with the provided SentinelOne site token (`$SiteToken`).
   - Check if the SentinelOne service is running successfully after the installation.

4. **Completion**

   After the script completes, it will print a message indicating whether SentinelOne is installed and the status of the SentinelOne service.

Please ensure you have the necessary permissions to run scripts on your system. If you encounter any issues during the installation, check the PowerShell execution policy and ensure it allows running scripts.

**Note:** Do not forget to replace the placeholder values (`https://example.com/sentinelone_package.msi` and `YOUR_SITE_TOKEN_HERE`) with your actual URLs and site token, respectively.

**Disclaimer:**

Before proceeding with mass deployment of the script, we strongly recommend testing it in a controlled environment to ensure compatibility and desired outcomes. Running the script in a test environment allows you to evaluate its behavior, validate configurations, and verify its effectiveness. This practice helps mitigate potential risks and ensures a smooth deployment process when executing it at scale. Additionally, always create backups and exercise caution when making changes to critical systems.
