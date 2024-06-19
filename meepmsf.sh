#!/bin/bash
# Author: meepmaster
# Date: 06-05-2022
# Description: Nmap scan


# Color variables 

RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

# Time variable

RIGHT_NOW=$(date +"%x %r %z")
TIME_STAMP="Updated ${RED}RIGHT_NOW by $USER"

# User root check

function user() {
	if [ $(id -u) != "0" ];then
		echo -e "\n${RED}[!]${NOCOLOR} Please run this script with root user!"
		exit 1
	fi
}

# Internet connection check

function connect() {
	ping -c 1 -w 3 google.com > /dev/null 2>&1
	if [ "$?" != 0 ];then
		echo -e "\n${RED}[!]${NOCOLOR} This script needs an active internet connection!"
		exit 1
	fi
}

echo
echo -e "\n${GREEN}[!]${NOCOLOR} $TIME_STAMP"
echo
