#!/bin/bash

topic_dir="$(dirname -- "$0")"
bundle_dir="${topic_dir}/bundle"
bundles=$(awk '/^Plugin/{print $2}' "${topic_dir}/vimrc.symlink" | sed 's/^.\(.*\).$/\1/' | sort)

source "${topic_dir}/../shell_functions.sh"
for bundle in $bundles
do
  url="https://github.com/${bundle%%/*}/${bundle##*/}.git"
  repo_dir=$bundle_dir/${bundle##*/}

  if [ ! -d $repo_dir ]
  then
    if git clone --recursive "${url}" "${repo_dir}" >/dev/null 2>&1
    then
      success "Installing $bundle"
    else
      fail "Failed to install $bundle"
    fi
  else
    success "$bundle already installed. Skipping."
  fi
done

