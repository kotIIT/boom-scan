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
			*) Menu;;
		esac
}

Install_Config(){
  sudo apt install python3 npm -y
  python3 -m pip install pipenv
	pipenv install
  Start_Config
}

Update_Packages(){
  pipenv install
}

Start_Config(){
  export FLASK_APP=webInterface.py
  sudo python3 -m pipenv shell flask run --host=$myIP
}

Restart_Config(){
  flask run --host=$myIP
}

Menu(){
  echo "i. to Install Requirements"
  echo "u. to Update Server packages"
  echo "s. to start server"
  echo "r. to refresh and update changes"
  echo "q to quit"
  local choice
  read -p "Select > " choice
    Output
}

Output
