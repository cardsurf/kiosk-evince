# kiosk-evince
A script that launches Evince in kiosk mode for Linux Mint Cinnamon

## Requirements
To make the script work the following packages needs to be installed:
* evince
* xdotool

## Usage
1. Create a system user `kiosk`
2. Automatically launch the `kiosk_evince.sh` script when `kiosk` user logs in.  
   Copy `kiosk_evince.sh` and `kiosk_evince.desktop` files to `/home/kiosk/.config/autostart` directory,
3. Give ownership of these files to `kiosk` user and grant executable permission to the `kiosk_evince.sh` file.
   ```
   cd /home/kiosk/.config/autostart
   sudo chown kiosk:kiosk kiosk_evince.sh kiosk_evince.desktop
   sudo chmod +x kiosk_evince.sh
   ```
4. Login as `kiosk` user.
