#!/usr/bin/env bash

if [ $# -ne 2 ]
then
  echo "Usage: ${0} fileext targetfilename"
  exit 1
fi

type=$1
outfile="$2"

for f in ./*$type; do echo "file '$f'" >> .filelist.txt; done
ffmpeg -f concat -safe 0 -i .filelist.txt -c copy "${outfile}"
rm -f .filelist.txt
