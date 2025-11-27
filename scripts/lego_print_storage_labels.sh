#!/usr/bin/env bash

num_set_labels=4
api_key_entry="op://Private/Rebrickable API Key/password"

if [ $# -ne 2 ]; then
  >&2 echo "Usage: $(basename "$0") <SET_NUM> <BAG_COUNT>"
  exit 1
fi

for cmd in curl jq op; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    >&2 echo "Error: Required command '$cmd' is not installed."
    exit 1
  fi
done

set_number=$1
bag_count=$2

# Check set_number is alphanumeric
if ! [[ "$set_number" =~ ^[1-9][0-9]*$ ]]; then
  echo "Error: set_number must be a positive integer." >&2
  exit 2
fi

# Check bag_count is a positive integer
if ! [[ "$bag_count" =~ ^[0-9]*$ ]]; then
  echo "Error: bag_count must be a positive integer or zero." >&2
  exit 3
fi

# Get API key from 1password
if ! api_key=$(op read "$api_key_entry"); then
  >&2 echo "Failed to retrieve API key from 1Password."
  exit 1
fi

set_name=$(curl --silent --header "Authorization: key $api_key" https://rebrickable.com/api/v3/lego/sets/"${set_number}"-1/ | jq -r '.name')

if [ "$set_name" == null ]; then
  >&2 echo "Set number $set_number not found at Rebrickable."
  exit 2
fi

for ((i = 1; i <= bag_count; i++)); do
  printf "%s-%02d  " "$set_number" "$i"
done

for ((i = 1; i <= num_set_labels; i++)); do
  echo -n "${set_number} ${set_name}  "
done

exit 0
