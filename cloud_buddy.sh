#!/bin/bash
# Get dependencies
rpk install yad xclip expect || exit 1
rm -rf ~/cloudbuddy || error "Failed to first remove cloudbuddy folder from $HOME!"
echo "Downloading cloudbuddy..."
git_clone https://github.com/Botspot/cloudbuddy || error "Failed to clone CloudBuddy repository!"

echo "Running CloudBuddy setup script..."
~/cloudbuddy/main.sh setup || error "CloudBuddy setup script failed!"