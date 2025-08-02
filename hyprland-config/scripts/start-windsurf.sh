#!/bin/bash

# Clear the log file
echo "=== Starting Windsurf at $(date) ===" > /tmp/windsurf-startup.log

# Wait for the system to be ready
echo "Waiting for system to be ready..." >> /tmp/windsurf-startup.log
sleep 2

# Check if Windsurf is already running
echo "Checking for existing Windsurf processes..." >> /tmp/windsurf-startup.log
if pgrep -x "windsurf" > /dev/null; then
    echo "Windsurf is already running" >> /tmp/windsurf-startup.log
    exit 0
fi

# Start Windsurf
echo "Starting Windsurf..." >> /tmp/windsurf-startup.log
/usr/local/bin/windsurf --no-sandbox 2>&1 | tee -a /tmp/windsurf-startup.log &
WINDSURF_PID=$!
echo "Windsurf started with PID: $WINDSURF_PID" >> /tmp/windsurf-startup.log

# Keep the script running to prevent it from being terminated
while kill -0 $WINDSURF_PID 2>/dev/null; do
    sleep 1
done

echo "Windsurf process ended" >> /tmp/windsurf-startup.log
exit 1
