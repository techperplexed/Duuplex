#!/bin/bash

clear
read -p "Are you sure you want to ${PERFORM} ${FUNCTION} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  # ----------
  # Open ports
  # ----------

  sudo ufw allow 32400

  # ------------
  # Dependencies
  # ------------

  sudo apt-get upgrade -y && sudo apt-get upgrade -y

  # -----------
  # Main script
  # -----------

    # Execution

  if [ -d "/var/lib/plexmediaserver" ];

  then

    echo -e "${FUNCTION} is already installed!"

  else

    cd /tmp
    clear
    echo -e "Please read the options carefully"
    echo ""
    bash -c "$(wget -qO - https://raw.githubusercontent.com/mrworf/plexupdate/master/extras/installer.sh)"
    cd ~

  fi

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${FUNCTION}"

fi

PAUSE
