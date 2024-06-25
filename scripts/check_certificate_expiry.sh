#!/usr/bin/env bash

expriylimit=2592000 # 30 days in seconds
reset=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
underline=$(tput smul)
nounderline=$(tput rmul)

if [ -z "$1" ]; then
  >&2 echo "Usage: $(basename "$0") ${underline}FQDN${nounderline} [PORT]"
  exit 1
fi

domain=$1
port=${2:-443}
cert=$(openssl s_client -showcerts -connect "$domain":"$port" </dev/null 2>/dev/null)

if [ -z "$cert" ]; then
  >&2 echo "Certificate not found"
  exit 2
fi

if echo "$cert" | openssl x509 -checkend $expriylimit -noout &>/dev/null; then
  color=$green
else
  color=$red
fi
enddate=$(echo "$cert" | openssl x509 -enddate -noout 2>/dev/null | cut -d= -f 2)
echo "${color}Certificate for $domain will expire on $enddate${reset}"

exit 0
