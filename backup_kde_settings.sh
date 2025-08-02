#!/bin/bash

# Backup essential KDE configuration files
cp -r ~/.config/kdeglobals .
cp -r ~/.config/plasmarc .
cp -r ~/.config/kwinrc .
cp -r ~/.config/plasma-org.kde.plasma.desktop-appletsrc .
cp -r ~/.config/systemsettingsrc .

echo "KDE settings backup completed!"
