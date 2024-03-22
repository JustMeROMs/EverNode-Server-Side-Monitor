# Ubuntu NetWatcher
 System Metrics Reporter: A script that monitors network traffic, performs periodic speed tests, tracks system uptime, checks disk usage, and sends human-readable email reports, ensuring efficient system management and timely awareness of critical system metrics.
This script is designed to monitor and report various system metrics via email in a human-readable format. It performs the following tasks:

Monitoring Network Traffic: It gathers data about the network traffic, including received (RX) and transmitted (TX) data, using the vnstat command-line tool.

Performing Speed Test: It conducts periodic speed tests using the speedtest-cli utility, which measures the download and upload speeds of the network connection.

Checking System Uptime: It retrieves information about the system's uptime and downtime using the uptime command.

Monitoring Disk Usage: It checks the disk usage percentage using the df command to ensure that it doesn't exceed a predefined threshold (80% by default).

Sending Email Reports: The script compiles all the collected data into a comprehensive report and sends it via email to a specified recipient address.

Human-Readable Format: To ensure readability, the email report is structured with headings for each metric, including uptime and downtime, speed test results, network traffic data, and disk usage.

Overall, the script provides administrators or users with regular updates on important system metrics, helping them to monitor system performance and address any potential issues promptly.

Here's how to install these packages on Ubuntu:

vnStat: You can install vnStat using the following command:
sudo apt-get install vnstat

speedtest-cli: You can install speedtest-cli using pip (Python package manager). First, install pip if you haven't already:
sudo apt-get install python3-pip

Then, install speedtest-cli:
sudo pip3 install speedtest-cli

mailutils: This package provides the mail command used for sending emails. Install it using:
sudo apt-get install mailutils


After installing these packages, you can run the script on your Ubuntu system. Make sure to adjust any configurations or variables (like the email recipient address) as needed for your setup.
