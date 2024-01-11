#!/bin/bash

sudo mkdir package_lists && cd package_lists && touch apt_packages && touch flatpaks && touch pacstall_packages
sudo apt list --installed | awk -F '/' '{print $1}' >> apt_packages
flatpak list | awk -F '/' '{print $1}' >> flatpaks
pacstall -L | awk -F '/' '{print $1}' >> pacstall packages