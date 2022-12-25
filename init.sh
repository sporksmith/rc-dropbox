#!/usr/bin/env bash

source ./common.sh

if [ -f "$PUBKEY" ]; then
  echo "$PUBKEY already exists"
  exit 1
fi

if [ -f "$PRIVKEY" ]; then
  echo "$PRIVKEY already exists"
  exit 1
fi

# Generate a keypair. Public key is encrypted with a passphrase.
# Public key is stored in a tmp file, and then converted to a 
# recipient file by stripping off the prefix.
TMP=$(mktemp key.age.pub.tmp.XXX)
age-keygen 2> "$TMP" | age -p -a > "$PRIVKEY"
cut -d ' ' -f 3 < "$TMP" > "$PUBKEY"
rm "$TMP"

chmod -w "$PRIVKEY"
chmod -w "$PUBKEY"
