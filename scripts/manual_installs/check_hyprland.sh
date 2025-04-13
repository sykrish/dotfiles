#!/bin/zsh

# Call this file using source or .

# I assume that hyprland is installable when it results in more than two lines.
# If some hyprland package is available, hyprland itself is probably available.

export INSTALL_HYPRLAND=$(($(apt search hyprland | wc -l) > 2))
