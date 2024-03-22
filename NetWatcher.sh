#!/bin/bash

# Set your threshold values
rx_limit="30" # in TiB
tx_limit="30" # in TiB
speedtest_interval=28800  # 8 hours in seconds
uptime_interval=86400  # 24 hours in seconds
storage_threshold=80  # percentage
recipient="your_email@example.com"  # Change this to the recipient email address

# Set your preferred network interface name here
network_interface="eth0"  # Change "eth0" to your preferred network interface name

# Function to get network traffic in TiB
get_network_traffic() {
    local interface="$1"
    local result=$(vnstat -i "$interface" --oneline | awk '{print $10, $11}')
    echo "$result"
}

# Function to run speedtest and get results
run_speedtest() {
    local result=$(speedtest-cli --simple)
    echo "$result"
}

# Function to get uptime and downtime
get_uptime_downtime() {
    local uptime=$(uptime | awk '{print $3 " " $4}' | sed 's/,//')
    local downtime=$(awk '{print $1}' /proc/uptime)
    echo "$uptime $downtime"
}

# Function to check disk usage
check_disk_usage() {
    local usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "$usage"
}

# Function to send email with report
send_report_email() {
    local uptime_downtime
    local speedtest_results
    local network_traffic_results
    local disk_usage

    uptime_downtime=$(get_uptime_downtime)
    speedtest_results=$(run_speedtest)
    network_traffic_results=$(get_network_traffic "$network_interface")
    disk_usage=$(check_disk_usage)

    {
        echo "Uptime and Downtime: $uptime_downtime"
        echo
        echo "Speedtest Results:"
        echo "$speedtest_results"
        echo
        echo "Network Traffic Results ($network_interface):"
        echo "$network_traffic_results"
        echo
        echo "Disk Usage: $disk_usage%"
    } | mail -s "System Report" "$recipient"

    # Check if disk usage exceeds threshold and send warning email
    if (( disk_usage >= storage_threshold )); then
        echo "Warning: Disk usage exceeded $storage_threshold%." \
            | mail -s "Disk Usage Warning" "$recipient"
    fi
}

# Main loop to send report email every 24 hours
while true; do
    send_report_email
    sleep "$uptime_interval"
done
