#!/bin/bash
usage="\nUsage: . startbr.sh <profile>
\nBuilds all services and then run with given profile."

PROFILE=$1

echo -e "\nBuild config server"
pushd $SRC_DIR/config
    mvn clean package
popd

# Run all services
. $SCRIPT_DIR/runbr.sh $PROFILE
