#!/bin/sh

EXTERNAL="${SWAY_MONITOR:-HDMI-A-1}"
# EXTERNAL=$SWAY_MONITOR
# EXTERNAL=HDMI-A-1
# EXTERNAL=DP-1
#3 EXTERNAL=DP-2
INTERNAL=eDP-1
HAS_EXTERNAL_MONITOR=$?

workspace_list=$(swaymsg -p -t get_workspaces | grep Workspace)
all_workspaces=$(echo "${workspace_list}" | sed -e 's,^Workspace \([0-9]*\).*,\1,')
focused_workspace=$(echo "${workspace_list}" | grep focused | sed -e 's,^Workspace \([0-9]*\).*,\1,')

if swaymsg -t get_outputs | grep $EXTERNAL; then
  for workspace in ${all_workspaces}; do
    swaymsg workspace ${workspace}
    swaymsg move workspace to output $EXTERNAL
  done

  swaymsg workspace ${focused_workspace}
else
  for workspace in ${all_workspaces}; do
    swaymsg workspace ${workspace}
    swaymsg move workspace to output $INTERNAL
  done

  swaymsg workspace ${focused_workspace}
fi


