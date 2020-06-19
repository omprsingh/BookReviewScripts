#!/bin/bash
usage="\nUsage: . stopbr.sh
\nStops all services."

# Stop config service
echo -e "\nStopping config service."
kill -9 $(cat $SCRIPT_DIR/pid/config)
>$SCRIPT_DIR/pid/config
