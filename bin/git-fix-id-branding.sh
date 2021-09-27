#!/bin/bash

git filter-branch -f --commit-filter 'if [ "$GIT_AUTHOR_EMAIL" == "michael.rolli@id.unibe.ch" ]; then export GIT_AUTHOR_NAME="Michael Rolli"; export GIT_AUTHOR_EMAIL="michael.rolli@unibe.ch"; export GIT_COMMITTER_NAME="Michael Rolli"; export GIT_COMMITTER_EMAIL="michael.rolli@unibe.ch"; fi; git commit-tree "$@"'

