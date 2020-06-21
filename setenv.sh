#!/bin/bash
export SRC_DIR="/home/om/Documents/Codebase/BookReview"
export SCRIPT_DIR=$SRC_DIR/scripts

# Create PID files for all services
mkdir -p $SCRIPT_DIR/pid
touch $SCRIPT_DIR/pid/config
touch $SCRIPT_DIR/pid/discovery
touch $SCRIPT_DIR/pid/gateway
touch $SCRIPT_DIR/pid/CatalogueService
touch $SCRIPT_DIR/pid/RatingService
