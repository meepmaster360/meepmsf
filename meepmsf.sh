#!/bin/bash
# Author: meepmaster
# Date: 20-06-2024
# Description: Metasploit installation and running with postgresql and msfdatabase

# Color variables
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

# Time variable
RIGHT_NOW=$(date +"%x %r %z")
TIME_STAMP="MeepMSF start ${RED}${RIGHT_NOW}${NOCOLOR} by $USER"

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

    # Check if postgresql is installed
    
    if ! command -v psql &> /dev/null; then
        echo -e "\n${GREEN}[!]${NOCOLOR} Installing postgresql..."
        apt-get install -y postgresql postgresql-contrib
    else
        echo -e "\n${GREEN}[!]${NOCOLOR} postgresql is already installed."
    fi

    # Start postgresql

    echo -e "\n${GREEN}[!]${NOCOLOR} Starting postgresql..."
    systemctl start postgresql

    # Start msfdatabase

    echo -e "\n${GREEN}[!]${NOCOLOR} Initializing msfdb..."
    msfdb init

    # Start msfconsole
    
    echo -e "\n${GREEN}[!]${NOCOLOR} Starting msfconsole..."
    msfconsole
}

# Call the functions
user
connect

# Call the Metasploit installation function
install_metasploit
