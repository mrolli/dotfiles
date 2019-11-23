#!/usr/bin/env bash

cd $HOME/Developer/ubelix/hpc-unibe-ch.github.io
mkdocs gh-deploy --config-file ../hpc-docs/mkdocs.yml --remote-branch master
