#!/bin/bash
usage="\nUsage: . startbr.sh <profile>
\nBuilds all services and then run with given profile."

PROFILE=$1

echo -e "\nStopping all services."
. $SCRIPT_DIR/stopbr.sh

echo -e "\nBuild config service"
pushd $SRC_DIR/config
    mvn clean package
popd

echo -e "\nBuild discovery service"
pushd $SRC_DIR/discovery
    mvn clean package
popd

echo -e "\nBuild gateway service"
pushd $SRC_DIR/gateway
    mvn clean package
popd

echo -e "\nBuild CatalogueService"
pushd $SRC_DIR/CatalogueService
    mvn clean package
popd

echo -e "\nBuild RatingService"
pushd $SRC_DIR/RatingService
    mvn clean package
popd

# Run all services
. $SCRIPT_DIR/runbr.sh $PROFILE
