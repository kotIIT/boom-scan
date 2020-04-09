#!/usr/bin/env bash

myIP="$(hostname -I)"

choice=$1
Output(){
  	case $choice in
  		i) Install_Config;;
  		s) Start_Config;;
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

Start_Config(){
  export FLASK_APP=webInterface.py
  python3 -m pipenv shell flask run --host=$myIP

}

Menu(){
  echo "i. to Install Requirements"
  echo "s. to start server"
  echo "q to quit"
  local choice
  read -p "Seclect > " choice
    Output
}

Output
