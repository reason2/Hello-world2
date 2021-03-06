#!/bin/bash

if [ -z "$1" ]; then
	echo "PEBCAK - Enter an argument"
	exit 0;
fi

installed=$(yum list installed $1 | grep $1 | awk -F. '{print $1}')
input="$1"
status=$(systemctl status $1 | grep Active | awk '{print $2}')
inactive="inactive"

if [ $installed == $input ]; then
	echo "This package is installed"
	if [ $status == $inactive ]; then
		echo "Dang it, it's turned off"
		echo "Would you like to start $input? 1 for yes, 2 for no:"
		select yn in "Yes" "No"; do
			case $yn in
				Yes ) systemctl start $input; break;;
				No ) exit 0;;
			esac
		done
	else
		echo "My status is $status"
		echo "Do you wish to stop $input? 1 for yes, 2 for no:"
		select yn in "Yes" "No"; do
			case $yn in
				Yes ) systemctl stop $input; break;;
				No ) exit 0;;
			esac
		done
	fi

else
	echo "You have not installed this package"
	echo "Do you wish to install $input? 1 for yes, 2 for no:"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) yum install -y $input; systemctl start $input; break;;
			No ) exit 0;;
		esac
	done
fi
