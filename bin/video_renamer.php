#!/usr/bin/env php
<?php

$pregReplaceStruct = array(
//    '/Do.*\.S02E/' => 'Doctor.Who.S02E',
    '/ /'   => '.',
    '/[()]/' => '',
);

$notest = isset($argv[1]) && $argv[1] == "-n" ? true : false;

$filenames = glob('*');

foreach ($filenames as $origfilename) {
    $newfilename = preg_replace(array_keys($pregReplaceStruct), array_values($pregReplaceStruct), $origfilename);
    if ($origfilename !== $newfilename) {
        if ($notest) {
            rename($origfilename, $newfilename);
        }
        echo "renamed to: {$newfilename}\n";
    }
}
