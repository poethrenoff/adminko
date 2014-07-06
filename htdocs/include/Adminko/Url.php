<?php
namespace Adminko;

class Url
{
    public static function prepareQuery($include = array(), $exclude = array())
    {
        foreach ($include as $var_name => $var_value) {
            if (in_array($var_name, $exclude) || is_empty($var_value)) {
                unset($include[$var_name]);
            }
        }

        return $include;
    }
    
    public static function selfUrl($include = array(), $exclude = array())
    {
        $self_url = preg_replace('/\?.*$/', '', filter_input(INPUT_SERVER, 'REQUEST_URI'));

        $query_string = http_build_query(self::prepareQuery($include, $exclude));

        return $self_url . ($query_string ? '?' . $query_string : '');
    }

    public static function requestUrl($include = array(), $exclude = array())
    {
        return self::selfUrl(array_merge($_GET, $include), $exclude);
    }
    
    public static function redirectTo($url_array = array())
    {
        if (!is_array($url_array)) {
            $location = $url_array;
        } else {
            $location = System::urlFor($url_array);
        }

        header('Location: ' . $location);

        exit;
    }
    
    public static function redirectBack()
    {
        $back_url = '/';
        
        $http_host = filter_input(INPUT_SERVER, 'HTTP_REFERER');
        $http_refferer = filter_input(INPUT_SERVER, 'HTTP_REFERER');

        if (!is_null($http_refferer) && strstr($http_refferer, $http_host)) {
            $back_url = $http_refferer;
        }

        self::redirectTo($back_url);
    }
}
