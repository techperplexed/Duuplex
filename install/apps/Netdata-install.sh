#!/bin/bash

which netdata > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Open ports

		sudo ufw allow 19999

		# Dependencies

		sudo apt-get upgrade -y && sudo apt-get upgrade -y
		
		sudo -s apt-get -y install \
			unzip \
			curl \
		denyhosts at sudo software-properties-common

		# Main script

		clear
		bash <(curl -Ss https://my-netdata.io/kickstart.sh)

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
