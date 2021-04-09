#!/usr/bin/env php
<?php

$pregReplaceStruct = array(
    '/ - /' => '.',
    '/[!=\'"\[\]\(\)],/' => '',
    '/ +/'   => '.',
    '/&/' => 'und',
    '/\.$/' => '',
    '/„/' => 'ä',
    '/則/' => 'ä',
    '/派/' => 'ö',
    '/�/' => 'ü'
);

$notest = isset($argv[1]) && $argv[1] == "-n" ? true : false;

$filenames = glob('*');

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
    $filename = ucwords($filename, " .,\t\r\n\f\v");
    $newfilename = empty($ext) ? $filename : $filename . '.' . $ext;
    if ($origfilename !== $newfilename) {
        if ($notest) {
            rename($origfilename, $newfilename);
        }
        echo "renamed to: {$newfilename}\n";
    }
}
