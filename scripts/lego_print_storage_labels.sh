#!/usr/bin/env bash

api_key_entry="op://Private/Rebrickable API Key/password"

if [ $# -ne 2 ]; then
  >&2 echo "Usage: $(basename "$0") <SET_NUM> <BAG_COUNT>"
  exit 1
fi

if ! command -v op &> /dev/null; then
  >&2 echo "The 'op' command is required but not found. Please install the 1Password CLI."
  exit 1
fi

set_number=$1
bag_count=$2
if ! api_key=$(op read "$api_key_entry"); then
  >&2 echo "Failed to retrieve API key from 1Password."
  exit 1
fi

set_name=$(curl --silent --header "Authorization: key $api_key" https://rebrickable.com/api/v3/lego/sets/"${set_number}"-1/ | jq -r '.name')

if [ "$set_name" == null ]; then
  >&2 echo "Set number $set_number not found at Rebrickable."
  exit 2
fi

for ((i=1; i<=bag_count; i++)); do
  printf "%s-%02d  " "$set_number" "$i"
done

for((i=1; i<=3;i++)); do
  echo -n "${set_number} ${set_name}  "
done

exit 0
