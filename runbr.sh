#!/bin/bash
usage="\nUsage: . runbr.sh <profile>
\nStops all services and then start with given profile."

PROFILE=$1
mkdir -p pid

# Start config service
echo -e "\nStopping config service."
touch $SCRIPT_DIR/pid/config
kill -9 $(cat $SCRIPT_DIR/pid/config)
>$SCRIPT_DIR/pid/config

echo -e "\nStarting config service with profile $PROFILE"
nohup java -jar $SRC_DIR/config/target/config*.jar --spring.profiles.active=$PROFILE &
LASTPID=$!
echo $LASTPID >> $SCRIPT_DIR/pid/config
echo -e "\nStarted config service with PID $LASTPID"
sleep 10
