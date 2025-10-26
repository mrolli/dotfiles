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
lego_prod_url="https://www.lego.com/de-ch/product/${set_number}"
lego_inst_url="https://www.lego.com/de-ch/service/building-instructions/$set_number"

echo "$set_json" \
  | jq -r \
  --arg theme_name "$theme_name" \
  --arg inst_url "$lego_inst_url" \
  --arg lego_url "$lego_prod_url" \
  '
  "  Set Number: \(.set_num)
  Name: \(.name)
  Year: \(.year)
  Parts: \(.num_parts)
  Theme: \($theme_name)
  @LEGO Webpage: \($lego_url)
  @Rebrickable: \(.set_url)
  Instructions: \($inst_url)"
'

exit 0
