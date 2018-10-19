#!/bin/bash

docker ps -q -f name=$APP > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINAPP

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		echo ""
		echo "Would you like to install $TASK stable (S) or beta (B)?"
		echo "Remember the two might not be backwards comptible..."
		echo ""
		read -n 1 -s -r -p " ---> "
		
		case "$REPLY" in
			b|B ) APPLOC=$APPLOC-beta; echo "Beta installation..." ;;
			r|R ) echo "Stable installation..." ;;
			* ) echo "No choice made, will use stable installation..." ;;
		esac

		cd $CONFIGS/Docker
		sudo rsync -a /opt/GooPlex/scripts/components/$APPLOC.yaml $CONFIGS/Docker/components
		/usr/local/bin/docker-compose down
		echo "Just a moment while $APP is being installed..."
		source /opt/GooPlex/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
		sudo chown -R $USER:$USER $CONFIGS/$TASK
		cd "${CURDIR}"

		APPINSTALLED

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

sudo rm /tmp/checkapp.txt
PAUSE