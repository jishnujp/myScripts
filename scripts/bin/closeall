#!/bin/bash

# Get the list of open windows
windows=$(wmctrl -l | awk '{print $1}')

# Iterate through the list of windows
for window in $windows; do
  # Close the current window
  wmctrl -ic $window
done

