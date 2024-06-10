#!/bin/bash

# Get the current player status
status=$(playerctl status 2>/dev/null)

# Define the icon based on the status
if [ "$status" == "Playing" ]; then
    icon=""  # Pause icon
else
    icon=""  # Play icon
fi

# Get the metadata for the current track
metadata=$(playerctl metadata --format "{{ artist }} - {{ title }}" 2>/dev/null)

# Output the full_text with icon and metadata
echo "$icon $metadata"
echo "$icon $metadata"

# Signal i3blocks on click
case $BLOCK_BUTTON in
    1) playerctl play-pause ;;  # Left-click to pause/play
    3) playerctl next ;;        # Right-click to skip to the next track
    4) playerctl position 10+ ;;    # Scroll up to seek forwards 10 seconds
    5) playerctl position 10- ;; # Scroll down to seek backwards 10 seconds
esac