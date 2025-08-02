#!/bin/bash

# Clear the log file
echo "=== Starting Waybar at $(date) ===" > /tmp/waybar-startup.log

# Kill any existing waybar instances
echo "Checking for existing Waybar processes..." >> /tmp/waybar-startup.log
if pgrep -x "waybar" > /dev/null; then
    echo "Found existing Waybar processes, killing them..." >> /tmp/waybar-startup.log
    killall -q waybar
    # Wait until the processes are shut down
    while pgrep -x "waybar" > /dev/null; do sleep 0.1; done
    # Wait a bit longer to ensure cleanup is complete
    echo "Waiting for cleanup to complete..." >> /tmp/waybar-startup.log
    sleep 1
fi

# Start waybar with a clean environment
echo "Starting Waybar..." >> /tmp/waybar-startup.log
/usr/bin/waybar -c ~/.config/waybar/config 2>&1 | tee -a /tmp/waybar-startup.log &
WAYBAR_PID=$!
echo "Waybar started with PID: $WAYBAR_PID" >> /tmp/waybar-startup.log

# Keep the script running to prevent Hyprland from terminating it
while kill -0 $WAYBAR_PID 2>/dev/null; do
    sleep 1
    # Check if Waybar is still running properly
    if ! pgrep -x "waybar" > /dev/null; then
        echo "Waybar process disappeared unexpectedly" >> /tmp/waybar-startup.log
        break
    fi
done

echo "Waybar process ended unexpectedly" >> /tmp/waybar-startup.log
exit 1
