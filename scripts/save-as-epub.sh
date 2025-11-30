#!/usr/bin/env zsh

if [ $# -ne 2 ]; then
  echo "Usage: $0 <URL to book> <nr of pages"
  exit 1
fi

baseurl=$1
pages=$2
output_prefix=${url##*/}.epub
output_txt=${output_prefix}.txt
output_epub=${output_prefix}.epub

echo $output_txt
exit
for i in {1..$pages}; do
  if [ i -eq 1 ]; then
    targeturl=$baseurl
  else
    targeturl=$baseurl/lesen/$i
  fi
  curl -s $targeturl -e '<div class="txt-cnt">{inner-html()}</div>' >>$output_txt
done

# rm $output_txt
