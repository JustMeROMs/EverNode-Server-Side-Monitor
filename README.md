# EverNode Server Side Monitor for Ubuntu

<p align="center">
  <a href='https://postimages.org/' target='_blank'><img src='https://i.postimg.cc/SNrWQfs7/root.png' width="500" border='0' alt='root'/></a>
</p>

This script is designed for Ubuntu servers to compile a comprehensive system report covering aspects like network traffic, disk usage, service status, and more. It then sends this report via email, including a personal message encouraging donations in EVRs (a hypothetical cryptocurrency). This script is particularly useful for system administrators or users who need regular insights into their system's health and performance without manually checking each metric.
Features:

    Public IP and Country Code: Fetches the system's public IP address and determines the country code.
    Service Status Check: Verifies if the xahaud service is active.
    Network Traffic: Reports the total upload and download traffic through the specified network interface.
    Disk Usage: Checks the disk usage of the root filesystem.
    Ubuntu Version: Retrieves the running Ubuntu version.
    Nginx Allowed IPs: Lists allowed IP addresses from the Nginx configuration for a specific site.
    Speed Test: Performs a simple speed test to measure internet bandwidth.
    Email Reporting: Compiles the gathered information into a report and sends it via email.
    

Prerequisites:

The script requires the following utilities to be installed on your Ubuntu server:

    curl: For fetching the public IP address and country code.
    vnstat: For network traffic monitoring.
    speedtest-cli: For performing speed tests.
    mailx: For sending the report via email.
    jq: For processing JSON data, particularly from vnstat.
    systemctl: For checking the status of services.
    lsb_release: For retrieving the Ubuntu version.

Additional commands used include df, uptime, grep, awk, and sed, which are typically pre-installed in Ubuntu.
Installation:

Install Required Utilities:

sudo apt update
sudo apt install curl vnstat speedtest-cli mailutils jq -y

Setup vnstat (if using network traffic monitoring):

    Initialize vnstat database for your network interface:

sudo vnstat -u -i enp1s0

Replace enp1s0 with your actual network interface name.
Start and enable vnstat service:

sudo systemctl start vnstat
sudo systemctl enable vnstat

Configure mailx:

    Edit or create the ~/.mailrc file to configure mailx with your SMTP settings. The configuration will vary based on your email provider.

Script Setup:

    Copy the script into a file, e.g., system_report.sh.
    Make the script executable:

    chmod +x system_report.sh

        Run the script with ./system_report.sh --report.

Usage:

Execute the script manually by running:

./system_report.sh --report


donations in EVRs, support project funding by shouting me coffee!. rEYDaCM5wdr1oGcgYxXPxBJB3mTj817yee
