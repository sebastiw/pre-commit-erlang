#!/bin/bash

REBAR3="$1"
REBAR_CONFIG="$2"
FORMAT_PLUGIN="erlfmt"
FORMAT_COMMAND="fmt"
PWD=`pwd`

shift 2
APPS=$@

for a in $APPS
do
    cd "$PWD/$a"
    if grep -q "$FORMAT_PLUGIN" "$REBAR_CONFIG"
    then
        $REBAR3 $FORMAT_COMMAND
    fi
done
