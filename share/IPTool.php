<?php
/**
 * @describe:
 * @author: Jerry Yang(hy0kle@gmail.com)
 * */
class IPTool
{
    public static function checkIPAvailable($ip)
    {
        $available = 1;

        $exp_sub = explode('.', $ip);
        if (4 == count($exp_sub)) {
            for ($i = 1; $i < 4; $i++) {
                if ($exp_sub[$i] > 255 || $exp_sub[$i] < 0) {
                    $available = 0;
                    break;
                }
            }
            if ($exp_sub[0] > 255 || $exp_sub[0] <= 0) {
                $available = 0;
            }
        }

        return $available;
    }

    public static function getIPRange($ip)
    {
        $range = false;

        $exp_ip = explode('/', $ip);
        do {
            // ip 段配置
            if (2 == count($exp_ip)) {
                if (! self::checkIPAvailable($exp_ip[0])) {
                    break;
                }

                $mask    = $exp_ip[1];
                if ($mask <= 2 || $mask > 32) {
                    break;
                }

                $ip_mask = str_repeat('1', $mask);
                $ip_mask = str_pad($ip_mask, 32, '0');
                //var_dump($ip_mask);

                $exp_sub = explode('.', $exp_ip[0]);
                $ip_container = array();
                foreach ($exp_sub as $k => $v) {
                    echo substr($ip_mask, $k * 8, 8), PHP_EOL;
                    $ip_container[$k] = $v & bindec(substr($ip_mask, $k * 8, 8));
                }
                var_dump($ip_container);
                if ($exp_sub[0] != $ip_container[0]) {
                    //echo 'IP 首段不相同', PHP_EOL;
                    break;
                }

            } else {
                // 单 ip
                $exp_sub = explode('.', $ip);
                if (self::checkIPAvailable($ip)) {
                    $range[] = $ip;
                }
            }
        } while(0);

        return $range;
    }
}

$range = IPTool::getIPRange('123.45.6.0/8');
//$range = IPTool::getIPRange('123.45.6.0');
var_dump($range);
/* vim:set ts=4 sw=4 et fdm=marker: */

