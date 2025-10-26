#!/usr/bin/env bash

api_key_entry="op://Private/Rebrickable API Key/password"

if [ $# -ne 1 ]; then
  >&2 echo "Usage: $(basename "$0") <SET_NUM>"
  exit 1
fi

# Check for required dependencies
for cmd in op curl jq; do
  if ! command -v "$cmd" &> /dev/null; then
    >&2 echo "The '$cmd' command is required but not found. Please install it."
    exit 1
  fi
done

set_number=$1
bag_count=$2
if ! api_key=$(op read "$api_key_entry"); then
  >&2 echo "Failed to retrieve API key from 1Password."
  exit 1
fi

set_json=$(curl --silent --header "Authorization: key $api_key" "https://rebrickable.com/api/v3/lego/sets/${set_number}-1/")
theme_id=$(echo "$set_json" | jq '.theme_id')
theme_name=$(curl --silent --header "Authorization: key $api_key" "https://rebrickable.com/api/v3/lego/themes/$theme_id/" | jq -r '.name')

echo "$set_json" | jq -r --arg theme_name "$theme_name" '
  "  Set Number: \(.set_num)
  Name: \(.name)
  Year: \(.year)
  Parts: \(.num_parts)
  Theme: \($theme_name)
  URL: \(.set_url)"
'

exit 0
