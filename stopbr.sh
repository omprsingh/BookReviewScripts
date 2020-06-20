#!/bin/bash
usage="\nUsage: . stopbr.sh
\nStops all services."

echo -e "\nStopping gateway service."
kill -9 $(cat $SCRIPT_DIR/pid/gateway)
>$SCRIPT_DIR/pid/gateway

echo -e "\nStopping discovery service."
kill -9 $(cat $SCRIPT_DIR/pid/discovery)
>$SCRIPT_DIR/pid/discovery

echo -e "\nStopping config service."
kill -9 $(cat $SCRIPT_DIR/pid/config)
>$SCRIPT_DIR/pid/config