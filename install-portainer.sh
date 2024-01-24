#!/bin/bash

wget -qO- https://raw.githubusercontent.com/pi-hosted/pi-hoste/master/install_portainer.sh | bash

## Login to Portainer at IP:9000 - Click Settings - add following json file into 'App Templates' box: 
## https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/template/portainer-v2-arm64.json
