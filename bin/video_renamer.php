#!/usr/bin/env php
<?php

$pregReplaceStruct = array(
    //    '/Do.*\.S02E/' => 'Doctor.Who.S02E',
    '/-/'    => '',
    '/,/'    => '',
    '/Sc\./'    => 'Scene.',
    '/\d+\.\s+/'    => '',
    '/ +/'   => '.',
    '/[()]/' => '',
);

$notest = isset($argv[1]) && $argv[1] == "-n" ? true : false;

$filenames = glob('*');

foreach ($filenames as $origfilename) {
    if ($origfilename == 'ranking.txt') {
        continue;
    }
    $newfilename = preg_replace(array_keys($pregReplaceStruct), array_values($pregReplaceStruct), $origfilename);
    $newfilename = ucwords($newfilename, " .,\t\r\n\f\v");
    if ($origfilename !== $newfilename) {
        if ($notest) {
            rename($origfilename, $newfilename);
        }
        echo "renamed to: {$newfilename}\n";
    }
}
