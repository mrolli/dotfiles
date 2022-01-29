#!/usr/bin/env bash

topic_dir="$(dirname -- "${0}")"
source "${topic_dir}/../shell_functions.sh"

# Deploy git-achievements repository
target=~/.config/git-achieve
[ ! -d $target ] \
  && info "Cloning git-achievements.git" \
  && (
    git clone https://github.com/mrolli/git-achievements.git $target &>/dev/null \
    && success 'Successfully deployed git-achievements repository' \
    || fail "Unable to clone repo" \
  )

exit 0

