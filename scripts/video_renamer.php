#!/usr/bin/env php
<?php

$pregReplaceStruct = array(
  '/🦄/' => '',
  '/🎄/' => '',
  '/ Deutsch /' => '.S01E.',
  '/ \｜ Freundschaft.*/' => '',
    '/ - /'              => '.',
    '/, /'               => '.',
    '/,/'                => '.',
    '/ +/'               => '.',
    '/\.$/'              => '',
    '/ä/'                => 'ae',
    '/ö/'                => 'oe',
    '/ü/'                => 'ue',
    '/&/'                => 'and',
    '/„/'                => 'ä', # KPT
    '/則/'               => 'ä', # KPT
    '/派/'               => 'ö', # KPT
    '/�/'                => 'ü', # KPT
    // '/[!=\'"’\[\]\(\)]/' => '',
    '/\.\./'             => '.'
);

$notest  = false;
$ucfirst = false;
$tolower = false;
$filter  = '*';

for ($i=1; $i<count($argv); $i++) {
    switch ($argv[$i]) {
      case '-n':
        $notest = true;
        break;
      case '-u':
        $ucfirst = true;
        break;
      case '-l':
        $tolower = true;
        break;
      default:
        $filter = $argv[$i];
    }
}

$filenames = glob($filter);

foreach ($filenames as $origfilename) {
    if ($origfilename == 'ranking.txt') {
        continue;
    }

    if (is_dir($origfilename)) {
        $ext = '';
        $filename = $origfilename;
    } else {
        $ext = strtolower(pathinfo($origfilename, PATHINFO_EXTENSION));
        $filename = pathinfo($origfilename, PATHINFO_FILENAME);
    }
    $filename = preg_replace(array_keys($pregReplaceStruct), array_values($pregReplaceStruct), $filename);
    # DO NOT add strtolower here as it would break acronyms
    $filename = $tolower ? strtolower($filename) : $filename;
    $filename = $ucfirst ? ucwords($filename, " .,\t\r\n\f\v") : $filename;
    $newfilename = empty($ext) ? $filename : $filename . '.' . $ext;
    if ($origfilename !== $newfilename) {
        if ($notest) {
            rename($origfilename, $newfilename);
            echo "renamed to: {$newfilename}\n";
        } else {
            echo "{$origfilename} => {$newfilename}\n";
        }
    }
}
