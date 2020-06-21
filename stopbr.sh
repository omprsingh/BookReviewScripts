#!/bin/bash
usage="\nUsage: . stopbr.sh
\nStops all services."

echo -e "\nStopping RatingService."
PID=$(cat $SCRIPT_DIR/pid/RatingService)
kill -9 $PID
>$SCRIPT_DIR/pid/RatingService

echo -e "\nStopping CatalogueService."
PID=$(cat $SCRIPT_DIR/pid/CatalogueService)
kill -9 $PID
>$SCRIPT_DIR/pid/CatalogueService

echo -e "\nStopping gateway service."
PID=$(cat $SCRIPT_DIR/pid/gateway)
kill -9 $PID
>$SCRIPT_DIR/pid/gateway

echo -e "\nStopping discovery service."
PID=$(cat $SCRIPT_DIR/pid/discovery)
kill -9 $PID
>$SCRIPT_DIR/pid/discovery

echo -e "\nStopping config service."
PID=$(cat $SCRIPT_DIR/pid/config)
kill -9 $PID
>$SCRIPT_DIR/pid/config

sleep 10