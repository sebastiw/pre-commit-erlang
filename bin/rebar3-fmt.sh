#!/bin/bash

REBAR3=`which rebar3`
REBAR_CONFIG="rebar.config"
FORMAT_PLUGIN="erlfmt"
FORMAT_COMMAND="fmt"

if [[ ! -f "$REBAR3" ]]
then
   echo "Rebar3 not found"
   exit 1
fi

PATHS=`dirname $@ | sort -u`
PWD=`pwd`

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
for a in $APPS
do
    cd "$PWD/$a"
    if grep -q "$FORMAT_PLUGIN" "$REBAR_CONFIG"
    then
        $REBAR3 $FORMAT_COMMAND
    fi
done
