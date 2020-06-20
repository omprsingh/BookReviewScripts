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

# Start discovery service
echo -e "\nStopping discovery service."
touch $SCRIPT_DIR/pid/discovery
kill -9 $(cat $SCRIPT_DIR/pid/discovery)
>$SCRIPT_DIR/pid/discovery

echo -e "\nStarting discovery service with profile $PROFILE"
nohup java -jar $SRC_DIR/discovery/target/discovery*.jar --spring.profiles.active=$PROFILE &
LASTPID=$!
echo $LASTPID >> $SCRIPT_DIR/pid/discovery
echo -e "\nStarted discovery service with PID $LASTPID"
sleep 10

# Start gateway service
echo -e "\nStopping gateway service."
touch $SCRIPT_DIR/pid/gateway
kill -9 $(cat $SCRIPT_DIR/pid/gateway)
>$SCRIPT_DIR/pid/gateway

echo -e "\nStarting gateway service with profile $PROFILE"
nohup java -jar $SRC_DIR/gateway/target/gateway*.jar --spring.profiles.active=$PROFILE &
LASTPID=$!
echo $LASTPID >> $SCRIPT_DIR/pid/gateway
echo -e "\nStarted gateway service with PID $LASTPID"
sleep 10
