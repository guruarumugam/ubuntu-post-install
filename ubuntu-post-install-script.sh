#!/bin/bash

#----------------------------#
# UBUNTU POST-INSTALL SCRIPT #
#----------------------------#

echo ''
echo '#-------------------------------------------#'
echo '#     Ubuntu 13.04 Post-Install Script      #'
echo '#-------------------------------------------#'

# SYSTEM UPGRADE
function sysupgrade {
# Update Repository Information
echo 'Updating repository information...'
echo 'Requires root privileges:'
sudo apt-get update
# Dist-Upgrade
echo 'Performing system upgrade...'
sudo apt-get dist-upgrade -y
echo 'Done.'
main
}

# INSTALL FAVOURITE APPLICATIONS
function appinstall {
# Install Favourite Applications
echo 'Installing selected favourite applications...'
echo 'Requires root privileges:'
sudo apt-get install -y --no-install-recommends aptitude darktable dconf-tools easytag filezilla gedit-plugins gimp gimp-plugin-registry grsync inkscape mypaint nautilus-dropbox nautilus-open-terminal pyrenamer synaptic synergy xchat vlc
echo 'Done.'
main
}

# INSTALL FAVOURITE SYSTEM TOOLS
function toolinstall {
echo 'Installing system tools...'
echo 'Requires root privileges:'
sudo apt-get install -y --no-install-recommends openjdk-7-jdk openssh-blacklist openssh-server p7zip-full ppa-purge samba ssh ssh-import-id
echo 'Done.'
main
}


# INSTALL GNOME SHELL
function gnomeextra {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo '1. Add GNOME3 PPA?'
echo '2. Add GNOME3 Staging PPA?'
echo '3. Install GNOME Shell.'
echo '4. Return.'
echo ''
read INPUT
# Add GNOME3 PPA
if [ $INPUT -eq 1 ]; then
    echo 'Adding GNOME3 PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:gnome3-team/gnome3
    echo 'Updating repository information...'
    sudo apt-get update
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    gnomeextra
# Add GNOME3 Staging PPA
elif [ $INPUT -eq 2 ]; then
    echo 'Adding GNOME3 Staging PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:gnome3-team/gnome3-staging
    echo 'Updating repository information...'
    sudo apt-get update
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    gnomeextra
# Install GNOME Shell
elif [ $INPUT -eq 3 ]; then
    echo 'Installing GNOME Shell...'
    echo 'Requires root privileges:'
    sudo apt-get install -y fonts-cantarell gnome-documents gnome-icon-theme-full gnome-shell gnome-tweak-tool
    echo 'Done.'
    gnomeextra
# Return
elif [ $INPUT -eq 4 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid choice. '
    gnomeextra
fi
done
}
# INSTALL MULTIMEDIA CODECS
function codecinstall {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo '1. Install Ubuntu Restricted Extras?'
echo '2. Install DVD playback tool'
echo '3. Return.'
echo ''
read INPUT
# Install Ubuntu Restricted Extras Applications
if [ $INPUT -eq 1 ]; then
    echo 'Installing Ubuntu Restricted Extras...'
    echo 'Requires root privileges:'
    sudo apt-get install -y ubuntu-restricted-extras
    echo 'Done.'
    codecinstall
# Medibuntu
elif [ $INPUT -eq 2 ]; then
    echo 'Adding Medibuntu repository to sources...'
    echo 'Requires root privileges:'
    sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get update -q && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get update -q
    echo 'Done.'
    echo 'Installing libdvdcss2...'
    echo 'Requires root privileges:'
    sudo apt-get install -y libdvdcss2
    echo 'Done.'
    codecinstall
# Return
elif [ $INPUT -eq 3 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid choice. '
    codecinstall
fi
done
}

# INSTALL DEV TOOLS
function devinstall {
# Install Development Tools
echo 'Installing development tools...'
echo 'Requires root privileges:'
sudo apt-get install -y bzr git glade
echo 'Done.'
main
}

# EXTRA INSTALLATION
function thirdparty {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo '1. Install Google Chrome?'
echo '2. Install Google Talk Plugin?'
echo '3. Return'
echo ''
read INPUT
# Google Chrome
if [ $INPUT -eq 1 ]; then
    echo 'Downloading Google Chrome...'
    # Make tmp directory
    if [ -e $HOME/tmp ]; then
        mkdir -p $HOME/tmp
    else
        continue
    fi
    cd $HOME/tmp
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    fi
    # Install the package
    echo 'Requires root privileges:'
    sudo dpkg -i google*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm *.deb
    cd
    echo 'Done.'
    thirdparty
# Google Talk Plugin
elif [ $INPUT -eq 2 ]; then
    echo 'Downloading Google Talk Plugin...'
    # Make tmp directory
    if [ -e $HOME/tmp ]; then
        mkdir -p $HOME/tmp
    else
        continue
    fi
    cd $HOME/tmp
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
    fi
    # Install the package
    echo 'Requires root privileges:'
    sudo dpkg -i google*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm *.deb
    cd
    echo 'Done.'
    thirdparty
# Return
elif [ $INPUT -eq 3 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid choice. '
    thirdparty
fi
done
}

# CONFIG
function config {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo '1. Set preferred application-specific settings?'
echo '2. Show all startup applications?'
echo '3. Return'
echo ''
read INPUT
# GSettings
if [ $INPUT -eq 1 ]; then
    # Font Sizes
    echo 'Setting font preferences...'
    gsettings set org.gnome.desktop.interface text-scaling-factor '1.0'
    gsettings set org.gnome.desktop.interface document-font-name 'Ubuntu 9'
    gsettings set org.gnome.desktop.interface font-name 'Ubuntu 9'
    gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 11'
    gsettings set org.gnome.nautilus.desktop font 'Ubuntu 9'
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Bold 9'
    gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'
    gsettings set org.gnome.settings-daemon.plugins.xsettings hinting 'slight'
    # Unity Settings
    echo 'Setting Unity preferences...'
    gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false
    gsettings set com.canonical.unity-greeter draw-user-backgrounds true 
    gsettings set com.canonical.indicator.power icon-policy 'charge'
    gsettings set com.canonical.Unity.Lenses remote-content-search 'none'
    # GNOME Shell Settings
    echo 'Setting GNOME Shell preferences...'
    gsettings set org.gnome.shell.overrides button-layout 'close:'
    # Nautilus Preferences
    echo 'Setting Nautilus preferences...'
    gsettings set org.gnome.nautilus.preferences sort-directories-first true
    # Gedit Preferences
    echo 'Setting Gedit preferences...'
    gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
    gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
    gsettings set org.gnome.gedit.preferences.editor auto-save true
    gsettings set org.gnome.gedit.preferences.editor insert-spaces true
    gsettings set org.gnome.gedit.preferences.editor tabs-size 4
    # Rhythmbox Preferences
    echo 'Setting Rhythmbox preferences...'
    gsettings set org.gnome.rhythmbox.rhythmdb monitor-library true
    gsettings set org.gnome.rhythmbox.sources browser-views 'artists-albums'
    gsettings set org.gnome.rhythmbox.sources visible-columns '['post-time', 'artist', 'duration', 'genre', 'album']'
    # Totem Preferences
    echo 'Setting Totem preferences...'
    gsettings set org.gnome.totem active-plugins '['save-file', 'media_player_keys', 'screenshot', 'chapters', 'ontop', 'screensaver', 'movie-properties', 'skipto']'
    # Gwibber Preferences
    echo 'Setting Gwibber preferences...'
    gsettings set org.gwibber.preferences autostart true
    gsettings set org.gwibber.preferences interval '5'
    gsettings set org.gwibber.preferences notify-mentions-only false
    gsettings set org.gwibber.preferences show-notifications true
    echo 'Done.'
    config
# Startup Applications
elif [ $INPUT -eq 2 ]; then
    echo 'Changing display of startup applications.'
    cd /etc/xdg/autostart/
    echo 'Requires root privileges:'
    sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop
    cd
    echo 'Done.'
    config
# Return
elif [ $INPUT -eq 3 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid choice.'
    config
fi
done
}

# CLEANUP SYSTEM
function cleanup {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo ''
echo '1. Remove unused pre-installed packages?'
echo '2. Remove old kernel(s)?'
echo '3. Remove orphaned packages?'
echo '4. Remove residual config files?'
echo '5. Clean package cache?'
echo '6. Return?'
echo ''
read INPUT
# Remove Unused Pre-installed Packages
if [ $INPUT -eq 1 ]; then
    echo 'Removing selected pre-installed applications...'
    echo 'Requires root privileges:'
    sudo apt-get purge onboard remmina
    echo 'Done.'
    cleanup
# Remove Old Kernel
elif [ $INPUT -eq 2 ]; then
    echo 'Removing old Kernel(s)...'
    echo 'Requires root privileges:'
    sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
    echo 'Done.'
    cleanup
# Remove Orphaned Packages
elif [ $INPUT -eq 3 ]; then
    echo 'Removing orphaned packages...'
    echo 'Requires root privileges:'
    sudo apt-get autoremove -y
    echo 'Done.'
    cleanup
# Remove residual config files?
elif [ $INPUT -eq 4 ]; then
    echo 'Removing residual config files...'
    echo 'Requires root privileges:'
    sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep '^rc' | tr -s ' ' | cut -d ' ' -f 2)
    echo 'Done.'
# Clean Package Cache
elif [ $INPUT -eq 5 ]; then
    echo 'Cleaning package cache...'
    echo 'Requires root privileges:'
    sudo apt-get clean
    echo 'Done.'
    cleanup
# Return
elif [ $INPUT -eq 6 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid choice. '
    cleanup
fi
done
}

# END
function end {
echo ''
read -p 'Are you sure you want to quit? (Y/n) '
if [ '$REPLY' == 'n' ]; then
    clear && main
else
    exit
fi
}

# MAIN FUNCTION
function main {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo '1. Perform system update & upgrade?'
echo '2. Install favourite applications?'
echo '3. Install favourite system tools?'
echo '4. Install extra GNOME components?'
echo '5. Install development tools?'
echo '6. Install restricted extras?'
echo '7. Install third-party applications?'
echo '8. Configure system?'
echo '9. Cleanup the system?'
echo '10. Quit?'
echo ''
read INPUT
# System Upgrade
if [ $INPUT -eq 1 ]; then
    clear && sysupgrade
# Install Favourite Applications
elif [ $INPUT -eq 2 ]; then
    clear && appinstall
# Install Favourite Tools
elif [ $INPUT -eq 3 ]; then
    clear && toolinstall
# Install GNOME components
elif [ $INPUT -eq 4 ]; then
    clear && gnomeextra
# Install Dev Tools
elif [ $INPUT -eq 5 ]; then
    clear && devinstall
# Install Ubuntu Restricted Extras
elif [ $INPUT -eq 6 ]; then
    clear && codecinstall
# Install Third-Party Applications
elif [ $INPUT -eq 7 ]; then
    clear && thirdparty
# Configure System
elif [ $INPUT -eq 8 ]; then
    clear && config
# Cleanup System
elif [ $INPUT -eq 9 ]; then
    clear && cleanup
# End
elif [ $INPUT -eq 10 ]; then
    end
else
# Invalid Choice
    echo 'Invalid choice.'
    main
fi
done
}

# CALL MAIN FUNCTION
main

#-----------------------------------#
# END OF UBUNTU POST-INSTALL SCRIPT #
#-----------------------------------#