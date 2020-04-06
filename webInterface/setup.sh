#!/usr/bin/env bash


Output(){
echo "1. to Install Requirements"
echo "2. to start server"
echo "3. to exit"
local choice
	read -n1 -p "> " choice
	clear
  	case $choice in
  		1) Install_Config;;
  		2) Start_Config;;
			3) exit 0
		esac
}

Install_Config(){
	sudo apt install python3 npm -y
	sudo pip3 install -U pipenv requests
	pipenv install
  Start_Config
}

Start_Config(){
  export FLASK_APP=webInterface.py
  python3 -m pipenv shell flask run --host='0.0.0.0'

}



Output
