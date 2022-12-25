#!/usr/bin/env bash

source ./common.sh

INFILE="$1"

age --decrypt -i "$PRIVKEY" "$INFILE"
