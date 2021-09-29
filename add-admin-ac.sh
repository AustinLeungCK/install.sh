#!/bin/zsh
# $1: Asset Number, $2: admin password, $3, %username%
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!" 
   exit 1
fi

sysadminctl -addUser "admin" -fullName $1 -password $2 -admin

dseditgroup -o edit -d $3 -t user admin

echo "reboot at 10 second......."
sleep 10

reboot