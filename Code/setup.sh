#!/usr/bin/env bash

myIP="$(hostname -I)"

choice=$1
Output(){
  	case $choice in
  		i) Install_Config;;
      u) Update_Packages;;
  		s) Start_Config;;
      r) Restart_Config;;
			q) exit 0;;
	    c) Clear_Files;;
			*) Menu;;
		esac
}

Install_Config(){
  sudo apt  install xsltproc libffi-dev libatlas-base-dev lslibbz2-dev liblzma-dev libsqlite3-dev libncurses5-dev libgdbm-dev zlib1g-dev libreadline-dev libssl-dev tk-dev build-essential libncursesw5-dev libc6-dev openssl git python3 npm nmap netdiscover default-jdk -y
  python3 -m pip install pipenv
	pipenv install --skip-lock
  Start_Config
}

Update_Packages(){
  pipenv install --skip-lock
}

Start_Config(){
  export FLASK_APP=webInterface.py
  sudo python3 -m pipenv shell flask run --host=$myIP
}

Restart_Config(){
  flask run --host=$myIP
}

Clear_Files(){
> Output/Devices.txt
> Output/IPs.txt
}

Menu(){
  echo "i. to Install Requirements"
  echo "u. to Update Server packages"
  echo "s. to start server"
  echo "r. to refresh and update changes"
  echo "q to quit"
  echo "c to clear Output files"
  local choice
  read -p "Select > " choice
    Output
}

Output
