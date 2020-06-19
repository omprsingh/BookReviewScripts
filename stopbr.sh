#!/bin/bash
usage="\nUsage: . stopbr.sh
\nStops all services."

echo -e "\nStopping config service."
kill -9 $(cat $SCRIPT_DIR/pid/config)
>$SCRIPT_DIR/pid/config

echo -e "\nStopping discovery service."
kill -9 $(cat $SCRIPT_DIR/pid/discovery)
>$SCRIPT_DIR/pid/discovery
