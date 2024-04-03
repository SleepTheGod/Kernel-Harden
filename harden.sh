#!/bin/sh

# Linux / Mac Harden By Taylor Christian Newsome 
echo "https://www.linkedin.com/in/clumsy/"


# Patch that BIOS
echo "Flashing coreboot..."
sudo flashrom -w /path/to/coreboot.rom

# Enable FileVault (Full Disk Encryption)
sudo fdesetup enable

# Set a firmware password
sudo firmwarepasswd -setpasswd -mode command -setmode command

# Enable Firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Disable remote login (SSH)
sudo systemsetup -f -setremotelogin off

# Disable automatic login
sudo defaults write /Library/Preferences/com.apple.loginwindow DisableFDEAutoLogin -bool YES

# Enable Gatekeeper (Allow apps from the App Store and identified developers)
sudo spctl --master-enable

# Enable automatic updates
sudo softwareupdate --schedule on

# Set a screen lock with password (Note: This step must be done manually)
echo "Please go to System Preferences > Security & Privacy > General and enable 'Require password [time] after sleep or screen saver begins'"

# Disable guest user
sudo dscl . -create /Users/Guest UserShell /usr/bin/false
sudo dscl . -create /Users/Guest RealName "Guest User"
sudo dscl . -create /Users/Guest UniqueID 600
sudo dscl . -create /Users/Guest PrimaryGroupID 201
sudo dscl . -create /Users/Guest NFSHomeDirectory /Library/Guests
sudo dscl . -create /Users/Guest IsHidden 1


# Disable that fancy firmware
echo "Disabling firmware..."
sudo mokutil --disable-validation

# Lock down those network ports
echo "Closing off unused ports..."
sudo ufw enable
sudo ufw default deny incoming
sudo ufw allow ssh

# Keep that software fresh
echo "Updating..."
sudo apt update && sudo apt upgrade -y

# Strong passwords, please
echo "Time for strong passwords..."
sudo passwd

# Disable FDE auto-login
echo "Disabling FDE auto-login..."
sudo defaults write /Library/Preferences/com.apple.loginwindow DisableFDEAutoLogin -bool YES

# Set a firmware password
echo "Setting firmware password..."
sudo firmwarepasswd -setpasswd

# Enable the firewall
echo "Enabling the firewall..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Enable stealth mode in the firewall
echo "Enabling stealth mode in the firewall..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Disable remote login
echo "Disabling remote login..."
sudo systemsetup -f -setremotelogin off

# Create a guest user
echo "Creating a guest user..."
sudo dscl . -create /Users/Guest UserShell /usr/bin/false
sudo dscl . -create /Users/Guest RealName "Guest User"
sudo dscl . -create /Users/Guest UniqueID 600
sudo dscl . -create /Users/Guest PrimaryGroupID 201
sudo dscl . -create /Users/Guest NFSHomeDirectory /Library/Guests
sudo dscl . -create /Users/Guest IsHidden 1

# Auto-configure a secure firewall
echo "Auto-configuring a secure firewall..."
sudo ufw allow OpenSSH
sudo ufw allow http
sudo ufw allow https
sudo ufw allow samba
sudo ufw allow nfs
sudo ufw allow mdns

# Disable IPv6 (optional)
echo "Disabling IPv6 (optional)..."
sudo sysctl -w net.inet6.ip6.disable_ipv6=1

# Disable telemetry and data collection (optional)
echo "Disabling telemetry and data collection (optional)..."
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.telemetry.agent.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.telemetry.daemon.plist
Enjoy your patched system!
echo "All patched up, fam!

# Disable unnecessary services and ports (Manual review and disable if not needed)

# Review and adjust sharing settings (Manual review and enable only necessary services)
echo "Please go to System Preferences > Sharing and enable only necessary services."

echo "Security hardening complete. Please review each change to ensure it aligns with your requirements."
