#!/bin/bash

# Check if evince package is installed
dpkg -s "evince" > /dev/null
if [ "$?" -ne "0" ]; then 
    echo "evince package is not installed. Script is being aborted."
    exit
fi
# Check if xdotool package is installed
dpkg -s "xdotool" > /dev/null
if [ "$?" -ne "0" ]; then 
    echo "xdotool package is not installed. Script is being aborted."
    exit
fi





# Declare application variables
pdf_filepath="$HOME/Desktop/test.pdf"

# Declare script variables
application="evince"
window="Evince"
launch_command="evince --presentation $pdf_filepath"
check_interval=1
launch_delay=0.5
shutdown_shortcut="KP_Subtract"
suspend_shortcut="Scroll_Lock"

# Set shutdown shortcut
gsettings set org.cinnamon.desktop.keybindings.media-keys shutdown "['<Control><Alt>End', 'XF86PowerOff', '$shutdown_shortcut']"
# Set supsend shortcut
gsettings set org.cinnamon.desktop.keybindings.media-keys suspend "['XF86Sleep', '$suspend_shortcut']"
# Disable showing popup window when power button is pressed
gsettings set org.cinnamon.settings-daemon.plugins.power button-power 'shutdown'
# Disable showing file explorer when USB drive is mounted
gsettings set org.cinnamon.desktop.media-handling automount-open 'false'

# Disable keystrokes
xmodmap -e 'keycode 9 = '   # Esc
xmodmap -e 'keycode 64 = '  # Alt
xmodmap -e 'keycode 71 = '  # F5
xmodmap -e 'keycode 76 = '  # F10
xmodmap -e 'keycode 95 = '  # F11
xmodmap -e 'keycode 133 = ' # Windows key

# Disable mouse buttons
xmodmap -e "pointer = 97 98 99"





# Periodically launches application in fullscreen mode
while true;
do
   # Check if application is launched
   pgrep -U "$USER" -x "$application" > /dev/null
   is_launched="$?"

   # If application is not launched
   if [ "$is_launched" -ne 0 ]; then

      # Launch application and detach from terminal
      $launch_command &
      # While application is not launched
      while [ "$is_launched" -ne 0 ];
      do
         # Wait for application launch
         sleep "$launch_delay"

         # Check if application is launched
         pgrep -U "$USER" -x "$application" > /dev/null
         is_launched="$?"
      done;
      # Check if application window is created
      is_created=$(xdotool search --onlyvisible --desktop 0 --class "$window")

      # While application window is not created
      while [ -z "${is_created}" ];
      do
         # Wait for application window creation
         sleep "$launch_delay"

         # Check if application window is created
         is_created=$(xdotool search --onlyvisible --desktop 0 --class "$window")
      done;
   fi

sleep "$check_interval";

done;


