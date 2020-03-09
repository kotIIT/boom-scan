#!/bin/bash

gitStats()
{
	git ls-tree -r HEAD | sed -Ee 's/^.{53}//' | \
	while read filename; do file "$filename"; done | \
	grep -E ': .*text' | sed -E -e 's/: .*//' | \
	while read filename; do git blame --line-porcelain "$filename"; done | \
	sed -n 's/^author //p' | \
	sort | uniq -c | sort -rn
}

#cd ..


#Display the options User can Choose from
function showMenu()
{	
	echo "Please select the option by pressing the number"
	echo ------------------------
	echo "Press 1 to view overall contribution " 
	echo "Press 2 to view contribution in project code"
	echo "Press 3 to view contribution in the Web Interface "
	echo "------------------------"
	
}

function Menu()
{	
	local choice
	read -n1 -p "> " choice
	clear 
  	case $choice in
  		1) Overall_Stats;;
  		2) First_Folder;;
  		3) Second_Folder;; 		
	esac
 }


 #Function to view  overall stats
function Overall_Stats()
{
	echo "Overall contriubtion" 
	gitStats	
}

#Function to view project code stats
function First_Folder()
{
	echo "Code Contribution"
	local getdir
	getdir="$(ls -d */ | sed -n 1p)"
	echo $getdir
	cd $getdir
	gitStats
	cd ..
}

function Second_Folder()
{
	echo "Code Contribution"
	local getdir
	getdir="$(ls -d */ | sed -n 4p)"
	echo $getdir
	cd $getdir
	gitStats
	cd ..
}

#Creates a pause within the loop
#User must press Enter to Continue
function Pause()
{
	echo
	echo "Press enter to check another category"
	read 
	clear
}

while true
do
 showMenu
 Menu
 Pause
done	
exit 0