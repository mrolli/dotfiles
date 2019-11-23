#!/usr/bin/env bash

cd $HOME/Developer/rollisch/mrolli.github.io
mkdocs gh-deploy --config-file ../personal_pages/mkdocs.yml --remote-branch master
