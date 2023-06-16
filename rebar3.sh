#!/bin/bash

## Make sure either rebar3 or docker exist
REBAR3=`which rebar3`
DOCKER=`which docker`
if [[ ! -f "$REBAR3" ]] && [[ ! -f "$DOCKER" ]]
then
    echo "Neither rebar3 nor docker found."
    exit 1
fi

REBAR_CMD="$1"
shift

## Loop upwards in directory-structure to find the rebar3 application
## (find rebar.config from src files)
REBAR_CONFIG="rebar.config"
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

echo "APPS: $APPS"

## Run the rebar3 command on each application found
PWD=`pwd`
for a in $APPS
do
    if [[ -f "$REBAR3" ]]
    then
        echo "Running $REBAR3 $REBAR_CMD in $PWD/$a"
        cd "$PWD/$a"
        $REBAR3 $REBAR_CMD
    elif [[ -f "$DOCKER" ]]
    then
        echo "INFO: For quicker workflow, download http://rebar3.org/ and add it to \$PATH"
        echo "Running rebar3 $REBAR_CMD in $PWD/$a inside $DOCKER"

        DIR=`dirname "${BASH_SOURCE[0]}"`
        HASH=`git --git-dir=$DIR/.git rev-parse --short HEAD`
        NAME="pre-commit-erlang"
        $DOCKER build \
                $DIR --tag $NAME:$HASH
        $DOCKER run --rm \
                -v "$PWD/$a":/src:rw,Z \
                --workdir /src \
                $NAME:$HASH "rebar3" "$REBAR_CMD"
    fi
done
