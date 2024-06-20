#!/bin/bash
# Author: meepmaster
# Date: 06-05-2022
# Description: Nmap scan and Metasploit installation options

# Color variables
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

# Time variable
RIGHT_NOW=$(date +"%x %r %z")
TIME_STAMP="Updated ${RED}${RIGHT_NOW}${NOCOLOR} by $USER"

# User root check
function user() {
    if [ $(id -u) != "0" ]; then
        echo -e "\n${RED}[!]${NOCOLOR} Please run this script with root user!"
        exit 1
    fi
}

# Internet connection check
function connect() {
    ping -c 1 -w 3 google.com > /dev/null 2>&1
    if [ "$?" != 0 ]; then
        echo -e "\n${RED}[!]${NOCOLOR} This script needs an active internet connection!"
        exit 1
    fi
}

# Function to check and install Metasploit components
function install_metasploit() {
    # Check if msfconsole is installed
    if ! command -v msfconsole &> /dev/null; then
        echo -e "\n${GREEN}[!]${NOCOLOR} Installing msfconsole..."
        apt-get install -y metasploit-framework
    else
        echo -e "\n${GREEN}[!]${NOCOLOR} msfconsole is already installed."
    fi

    echo -e "\n${GREEN}[!]${NOCOLOR} Running msfupdate..."
    msfupdate

    # Check if postgresql is installed
    if ! command -v psql &> /dev/null; then
        echo -e "\n${GREEN}[!]${NOCOLOR} Installing postgresql..."
        apt-get install -y postgresql postgresql-contrib
    else
        echo -e "\n${GREEN}[!]${NOCOLOR} postgresql is already installed."
    fi

    echo -e "\n${GREEN}[!]${NOCOLOR} Starting postgresql..."
    systemctl start postgresql

    echo -e "\n${GREEN}[!]${NOCOLOR} Initializing msfdb..."
    msfdb init

    echo -e "\n${GREEN}[!]${NOCOLOR} Starting msfconsole..."
    msfconsole
}

# Call the functions
user
connect

echo
echo -e "\n${GREEN}[!]${NOCOLOR} $TIME_STAMP"
echo

# Call the Metasploit installation function
install_metasploit
