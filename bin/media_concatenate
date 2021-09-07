#!/usr/bin/env bash

if [ $# -lt 3 ]
then
  echo "Usage: ${0} targetfilename file1 file2 [file3..]"
  exit 1
fi

outfile="$1"
shift
files=$@

for file in $files
do
  echo "file '${file}'" >> .filelist.txt
done
ffmpeg -f concat -safe 0 -i .filelist.txt -c copy "${outfile}"
rm -f .filelist.txt
