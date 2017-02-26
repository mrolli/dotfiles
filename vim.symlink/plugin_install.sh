#!/bin/bash

topic_dir=$(dirname "$0")
bundle_dir=$topic_dir/bundle
bundles=$(awk '/^Plugin/{print $2}' $topic_dir/vimrc.symlink | sed 's/^.\(.*\).$/\1/')

source $topic_dir/../shell_functions.sh
for bundle in $bundles
do
  user=$(echo $bundle | awk -F"/" '{print $1}')
  repo=$(echo $bundle | awk -F"/" '{print $2}')
  url="https://github.com/${user}/${repo}.git"
  repo_dir=$bundle_dir/$repo

  if [ ! -d $repo_dir ]
  then
    if git clone --recursive $url $repo_dir >/dev/null 2>&1
    then
      success "Installing $bundle"
    else
      fail "Failed to install $bundle"
    fi
  else
    success "Skipping $bundle"
  fi
done

