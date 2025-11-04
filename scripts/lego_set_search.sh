#!/usr/bin/env bash

api_key_entry="op://Private/Rebrickable API Key/password"

if [ $# -ne 1 ]; then
  >&2 echo "Usage: $(basename "$0") <SEARCH_TERMS>"
  exit 1
fi

# Check for required dependencies
for cmd in op curl jq; do
  if ! command -v "$cmd" &>/dev/null; then
    >&2 echo "The '$cmd' command is required but not found. Please install it."
    exit 1
  fi
done

search_terms=$1

if ! api_key=$(op read "$api_key_entry"); then
  >&2 echo "Failed to retrieve API key from 1Password."
  exit 1
fi

curl --silent --header "Authorization: key $api_key" "https://rebrickable.com/api/v3/lego/sets/?search=${search_terms/ /%20}&ordering=year" |
  jq -r '.results[] | [.set_num, .name, (.num_parts | tostring) + " Pieces", .year, .set_url] | @tsv' |
  column -t -s $'\t'

exit 0
