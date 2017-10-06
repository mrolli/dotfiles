#!/bin/bash

tmpdir=temp
for file in *.cb[rz];
do
  rm -rf $tmpdir
  mkdir $tmpdir
  name=${file%.cb?}
  unrar e -y -- "$file" $tmpdir
  if [[ $? -ne 0 ]]
  then
    unzip -j "$file" -d $tmpdir
  fi
  convert "$tmpdir/*.{jpg,JPG,jpeg,JPEG,png,PNG,gif,GIF,tif,TIF,tiff,TIFF,bmp,BMP}" "$name.pdf"
  rm -rf $tmpdir
done

