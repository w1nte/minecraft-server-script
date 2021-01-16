#!/bin/bash

start="/home/minecraft/1.16.4/start.sh"

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;36m'
NC='\033[0m' # No Color

case "$1" in
start)
echo "Start Minecraft Server"
script /dev/null -qc "screen -AmdS minecraft ${start} && sleep 2"
;;
stop)
echo "Stop Minecraft Server"
screen -S minecraft -X stuff "stop^M"
;;
restart)
echo "Restart Minecraft Server"
screen -S minecraft -X stuff "stop^M"
sleep 5
script /dev/null -qc "screen -AmdS minecraft ${start} && sleep 2"
;;
open)
echo -e "${BLUE}Open Minecraft Shell. You can detach it with Strg + A + D${NC}"
sleep 1
screen -x "minecraft"
;;
status)
stat=$(screen -ls | grep -c -E '[0-9]+\.minecraft')
if [ "$2" == "count" ]
  then
    echo "$stat"
    exit 1
fi
if [ $stat -eq 1 ]
  then
    echo -e "${GREEN}Server is running${NC}"
fi
if [ $stat -gt 1 ]
  then
    (>&2 echo -e "${RED}Warning:${NC} There is more than one instances are running")
fi
if [ $stat -lt 1 ]
  then
    echo -e "${RED}Server is not running${NC}"
fi
;;
*)
    echo -e "${BLUE}available commands: ${NC}start/stop/restart/status/open"
;;
esac
