#!/bin/bash

DURATION=$(</dev/stdin)
if (($DURATION <= 5000)); then
    exit 60
else
    if ! curl --silent --fail lastpaywins.embassy:3000 &>/dev/null; then
        echo "Last Pay Wins interface is unreachable" >&2
        exit 1
    fi
fi
