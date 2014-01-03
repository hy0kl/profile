#!/Users/hy0kl/php/bin/php
<?php
/**
    通过 curl 取目标网址的 http 头
*/
if (! ($argc > 1))
{
    echo "no input URL.\nusage: curl-head 'http://example.org'\n";
    exit;
}

$url = $argv[1];
$ch = curl_init();
if (!$ch)
{
   die("Couldn't initialize a cURL handle");
}
// set some cURL options
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_HEADER, 1);    // 设置显示返回的http头
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);    // 设置执行时将结果集放入缓冲区
curl_setopt($ch, CURLOPT_TIMEOUT, 30);  // 超时设置
curl_setopt($ch, CURLOPT_NOBODY, true);
curl_exec($ch);

$info = curl_getinfo($ch);  // 获取http头
curl_close($ch);    // close cURL handler

print_r($info);
