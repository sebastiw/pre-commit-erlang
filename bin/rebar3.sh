#!/bin/bash

## Make sure rebar3 exist
REBAR3=`which rebar3`
REBAR_CONFIG="rebar.config"
if [[ ! -f "$REBAR3" ]]
then
   echo "Rebar3 not found"
   exit 1
fi

REBAR_CMD="$1"
shift

## Loop upwards in directory-structure to find the rebar3 application
## (find rebar.config from src files)
PATHS=`dirname $@ | sort -u`
APPS=()
for p in $PATHS
do
    while [[ ! -f "$p/$REBAR_CONFIG" ]]
    do
        p=`dirname $p`
    done
    APPS=($p $APPS)
done
APPS=`echo "$APPS" | sort -u`

## Run the rebar3 command on each application found
PWD=`pwd`
for a in $APPS
do
    echo "Running $REBAR3 $REBAR_CMD in $PWD/$a"
    cd "$PWD/$a"
    $REBAR3 $REBAR_CMD
done
