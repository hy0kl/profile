<?php
if ($argc < 2)
{
    echo "Need more argument...\n";
    echo "Usage: {$argv[0]} method[decode|encode] url\n";
    exit();
}

$method = $argv[1];
$url    = isset($argv[2]) ? $argv[2] : '';
$result = 'Wrong input...';

switch ($method)
{
    case 'encode':
        $result = urlencode($url);
        break;

    case 'decode':
        $result = urldecode($url);
        break;
}

echo $result;
echo "\n";

