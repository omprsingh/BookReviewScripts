#!/bin/bash
usage="\nUsage: . runbr.sh <profile>
\nStops all services and then start with given profile."

PROFILE=$1

echo -e "\nStopping all services."
. $SCRIPT_DIR/stopbr.sh

echo -e "\nStarting config service with profile $PROFILE"
nohup java -jar $SRC_DIR/config/target/config*.jar --spring.profiles.active=$PROFILE &
LASTPID=$!
echo $LASTPID > $SCRIPT_DIR/pid/config
echo -e "\nStarted config service with PID $LASTPID"
sleep 10

echo -e "\nStarting discovery service with profile $PROFILE"
nohup java -jar $SRC_DIR/discovery/target/discovery*.jar --spring.profiles.active=$PROFILE &
LASTPID=$!
echo $LASTPID > $SCRIPT_DIR/pid/discovery
echo -e "\nStarted discovery service with PID $LASTPID"
sleep 10

echo -e "\nStarting gateway service with profile $PROFILE"
nohup java -jar $SRC_DIR/gateway/target/gateway*.jar --spring.profiles.active=$PROFILE &
LASTPID=$!
echo $LASTPID > $SCRIPT_DIR/pid/gateway
echo -e "\nStarted gateway service with PID $LASTPID"
sleep 10

echo -e "\nStarting CatalogueService with profile $PROFILE"
nohup java -jar $SRC_DIR/CatalogueService/target/CatalogueService*.jar --spring.profiles.active=$PROFILE &
LASTPID=$!
echo $LASTPID > $SCRIPT_DIR/pid/CatalogueService
echo -e "\nStarted CatalogueService with PID $LASTPID"
sleep 10

echo -e "\nStarting RatingService with profile $PROFILE"
nohup java -jar $SRC_DIR/RatingService/target/RatingService*.jar --spring.profiles.active=$PROFILE &
LASTPID=$!
echo $LASTPID > $SCRIPT_DIR/pid/RatingService
echo -e "\nStarted RatingService with PID $LASTPID"
sleep 10
