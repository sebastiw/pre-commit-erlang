#!/bin/bash

REBAR3=`which rebar3`
REBAR_CONFIG="rebar.config"
if [[ ! -f "$REBAR3" ]]
then
   echo "Rebar3 not found"
   exit 1
fi

CMD="$1"
shift

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

case "$CMD" in
     fmt)
         `dirname $0`/rebar3-fmt.sh $REBAR3 $REBAR_CONFIG $APPS
         ;;
    *)
        echo "CMD not understood"
        exit 1
esac
