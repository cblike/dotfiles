#!/bin/bash

sudo apt update && sudo apt upgrade

#As Portainer is available as a Docker container on the official Docker hub, we can pull the latest version using the following command:
sudo docker pull portainer/portainer-ce:latest

#In the terminal on your Pi, run the following command to start up Portainer:
#A few of the big things we do here is first define the ports we want Portainer to have access to. In our case, this will be port 9000.
#We assign this docker container the name “portainer” so we can quickly identify it if we ever needed.
#Additionally, we also tell the Docker manager that we want it to restart this Docker if it is ever unintentionally offline.
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

#Access portainer via web:
# If you don’t know your Raspberry Pi’s local IP address, it is relatively straightforward to retrieve it.
#Run hostname -I
#Now, all you need to do to access Portainer is to go to the following in your browser.
#You can see that in this address, we have referenced the port “:9000” at the end. This is the port that Portainer makes itself available at.
#http://[PIIPADDRESS]:9000