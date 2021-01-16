#!/bin/bash

startscript="/home/minecraft/control.sh start"
stopscript="/home/minecraft/control.sh stop"
BLUE='\033[0;36m'
NC='\033[0m' # no color

watch () {
	local stat=$(screen -ls | grep -c -E '[0-9]+\.minecraft')
        if [ $stat -lt 1 ]
	then
		>&2 echo "Server isn't running. Restart!"
		eval $startscript
	fi
        if [ $stat -gt 1 ]
	then
		>&2 echo "More than one Server instance. Stop!"
		eval $stopscript
	fi
}

watch
