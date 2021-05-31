#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# required for gnome-keyring and seahorse to somehow work; see: https://unix.stackexchange.com/a/295652
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
hash dbus-update-activation-environment && \
	dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

gammastep -m wayland -r >& /dev/null &

mako >& /dev/null &

kanshi >& /dev/null &

# TODO jprokop: polkit-gnome sucks but polkit-mate segfaults under sway/wayland :-( (revisit later; revisited 11/2020 and was still happening)
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 >& /dev/null &

# screensharing with Zoom running on X11 (check zoom folder)
# TODO jprokop: consider usage of https://aur.archlinux.org/packages/gnome-shell-screenshot-dbus-emulator (instead of having the binary in the repo directly)
$DIR/../zoom/gnome-shell-screenshot-dbus-emulator >& /dev/null &

# TODO jprokop: instead of notification I could integrate it with the swaybar
yubikey-touch-detector --libnotify

# screensharing with Chrome/Chromium/Firefox (and Electron later on); the below are supposed to be start by DBus automatically but it doesn't work for me for some reason
# TODO jprokop: re-evaluate if this is still needed after a while
/usr/lib/xdg-desktop-portal-wlr -r >& /dev/null &
sleep 2
/usr/lib/xdg-desktop-portal -r -v >& /dev/null &
