#!/bin/bash

# Name: drop-ip
# Description:
# Get public IP of system/NAT and stores in a file controlled
# by Dropbox.

DROPBOX_DIR=$HOME/Dropbox
DROPIP_DIR=$DROPBOX_DIR/drop-ip
IP_FILE=home-ip.txt
LOG_FILE=home-ip.log
IP_URL=http://icanhazip.com

# Exit on any errors
set -e

# Retrieve public IP from designated provider
curr_ip=$( curl -s $IP_URL )

# Create drop-ip if it doesn't already exist
[[ ! -d $DROPIP_DIR ]] && mkdir $DROPIP_DIR

# Retrieve stored IP
[[ -e $DROPIP_DIR/$IP_FILE ]] && old_ip=$( cat $DROPIP_DIR/$IP_FILE ) 

# Update to new IP only if changed
if [[ ${curr_ip// /} != ${old_ip// /} ]]
then
	echo $curr_ip > $DROPIP_DIR/$IP_FILE
	echo "$( date +%c ) - Old IP: $old_ip - New IP: $curr_ip" >> $DROPIP_DIR/$LOG_FILE
fi 
	
