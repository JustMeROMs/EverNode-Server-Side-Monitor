#!/bin/bash

# Clear the terminal and announce the start of the test
clear
echo "Sit back while we run a test on your node!"

# Configuration variables
network_interface="eth0" replace with your own network adapter here
recipient="put_your_own@email_adress_here.com" replace with your own email address here
donation_message="Please shout me a coffee by donating some EVRs. My Address is: rEYDaCM5wdr1oGcgYxXPxBJB3mTj817yee"

# Check for the availability of required commands
required_cmds="curl vnstat speedtest-cli mailx df uptime jq bc systemctl lsb_release mpstat grep awk sed"
for cmd in $required_cmds; do
    if ! command -v $cmd &> /dev/null; then
        echo >&2 "Error: Required command '$cmd' is not installed."
    fi
done

# Fetch the public IP address of the system
get_ipv4_address() {
    curl -s ifconfig.me
}

# Determine the country code based on the public IP address
get_country_code() {
    local ip=$(get_ipv4_address)
    curl -s "https://ipinfo.io/${ip}/country"
}

# Check the status of the xahaud service
check_xahaud() {
    if systemctl is-active --quiet xahaud; then
        echo "xahaud service is **ACTIVE**."
    else
        echo "xahaud service is **NOT ACTIVE**."
    fi
}

# Perform a simple speed test
run_speedtest() {
    speedtest-cli --simple
}

# Get network traffic statistics for the specified interface
get_network_traffic() {
    local interface="$1"
    local traffic=$(vnstat -i "$interface" --json)
    local rx_gb=$(echo "$traffic" | jq ".interfaces[0].traffic.total.rx" | awk '{printf "%.0f G", $1/1024/1024}')
    local tx_gb=$(echo "$traffic" | jq ".interfaces[0].traffic.total.tx" | awk '{printf "%.0f G", $1/1024/1024}')
    echo "Upload: ${tx_gb}, Download: ${rx_gb}"
}

# Check disk usage for the root filesystem
check_disk_usage() {
    df -h / | awk 'NR==2 {print "Disk Usage - Used: " $3 " / Free: " $4 " (" $5 " used)"}'
}

# Fetch the Ubuntu version of the system
get_ubuntu_version() {
    lsb_release -d | cut -f2
}

# Fetch allowed IP addresses from the Nginx configuration
get_allowed_ips() {
    echo "Fetching allowed IP list from Nginx configuration..."
    grep 'allow' /etc/nginx/sites-available/xahau | awk '{print $2}' | sed 's/;//'
}

# Compile the system report
compile_report() {
    local ubuntu_version=$(get_ubuntu_version)
    local uptime_info=$(uptime -p)
    local ipv4_address=$(get_ipv4_address)
    local country_code=$(get_country_code)
    local xahaud_status=$(check_xahaud)
    local allowed_ips=$(get_allowed_ips)
    local speedtest_results=$(run_speedtest)
    local network_traffic_results=$(get_network_traffic "$network_interface")
    local disk_usage=$(check_disk_usage)
    echo -e "\nSystem Report\n=============\n"
    echo "Ubuntu Version: $ubuntu_version"
    echo "Uptime: $uptime_info"
    echo "IPv4 Address: $ipv4_address"
    echo "Country Code: $country_code"
    echo "$xahaud_status"
    echo -e "Allowed IPs from Nginx Configuration:\n$allowed_ips"
    echo -e "\nSpeedtest Results:\n$speedtest_results"
    echo -e "\nNetwork Traffic:\n$network_traffic_results"
    echo "Disk Usage:\n$disk_usage"
    echo -e "\n$donation_message" # Add donation message to report
}

# Send the compiled report via email
send_report_email() {
    local report_content=$(compile_report)
    echo "$report_content" | mailx -s "System Report for $(hostname) - $(date +'%Y-%m-%d %H:%M:%S')" "$recipient"
    if [[ $? -eq 0 ]]; then
        echo -e "Email sent successfully to $recipient.\n$donation_message" # Echo donation message
    else
        echo "Failed to send email. Check your mailx configuration."
    fi
}

# Main execution
if [[ "$1" == "--report" ]]; then
send_report_email
else
echo "Usage: $0 --report"
fi
