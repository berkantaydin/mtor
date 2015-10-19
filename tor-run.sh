#!/bin/sh
 
# Allows to run multiple tor instances on different ports
# Make sure that torrc is in same directory as this script
 
CUSTOM_PORT=9050
CUSTOM_CONTROL_PORT=9051
 
if [ ! -z "$1" ]
    then
        CUSTOM_PORT=$1
	CUSTOM_CONTROL_PORT=$(($1+1))
        echo "Using custom port: $CUSTOM_PORT / $CUSTOM_CONTROL_PORT"
fi
 
DATA_DIRECTORY="data.$CUSTOM_PORT"
CONFIG_FILE="$DATA_DIRECTORY/torrc"
 
mkdir $DATA_DIRECTORY
 
sed -E "s/SocksPort [0-9]+/SocksPort ${CUSTOM_PORT}/g" torrc | \
sed -E "s/DataDirectory .+/DataDirectory ${DATA_DIRECTORY}/g" | \
sed -E "s/ControlPort [0-9]+/ControlPort ${CUSTOM_CONTROL_PORT}/g" > $CONFIG_FILE

/Applications/TorBrowser.app/TorBrowser/Tor/tor -f $(pwd)/$CONFIG_FILE
