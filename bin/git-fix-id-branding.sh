#!/bin/bash

git filter-branch -f --commit-filter 'if [ "$GIT_AUTHOR_NAME" == "Michael Rolli" ]; then export GIT_AUTHOR_NAME="Rolli, Michael (ID)"; export GIT_AUTHOR_EMAIL="michael.rolli@id.unibe.ch"; export GIT_COMMITTER_NAME="Rolli, Michael (ID)"; export GIT_COMMITTER_EMAIL="michael.rolli@id.unibe.ch"; fi; git commit-tree "$@"'

