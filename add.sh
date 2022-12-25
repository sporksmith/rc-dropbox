#!/usr/bin/env bash

source ./common.sh

OUTFILE="$1.age"

if [ -f "$OUTFILE" ]; then
  echo "$OUTFILE already exists"
  exit 1
fi

age -e -R "$PUBKEY" -o "$OUTFILE"
chmod -w "$OUTFILE"
