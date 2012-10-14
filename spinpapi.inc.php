<?php
/*
SpinPapi Client Library
by Tom Worster, Spinitron is licensed under a Creative Commons 
Attribution 3.0 United States License.

spin_papi_query() sends a signed query to the spinitron public api 
service, receives the response, decodes and returns it.

(array) $param -- assoc array of query parameters, see api spec
(str) $apiuserid -- user id issued by spinitron for use of this api
(str) $secret -- secret code issued by spinitron for request signing
(bool) $array -- true: return an assoc array rather than obj

returns:
(obj) or (array) see api spec for details. 
(bool) false indicates service failure
*/

function spin_papi_query($params, $userid, $secret, $array = false) {
    // service specs
    $host = 'spinitron.com';
    $url = '/public/spinpapi.php';

    // parameters added to every API query
    $params['papiversion'] = '1'; // SpinPapi version string
    $params['papiuser'] = $userid; // user id
    $params['timestamp'] = gmdate('Y-m-d\TH:i:s\Z'); // timestamp GMT

    // create the query's GET parameter string
    ksort($params);
    $query = array();
    foreach ( $params as $param => $value )
        $query[] = rawurlencode($param) . '=' . rawurlencode($value);
    $query = implode('&', $query);

    // calculate signature
    $signature = rawurlencode(base64_encode(hash_hmac("sha256", 
        "$host\n$url\n$query", $secret, true)));

    // compose request
    $request = "http://$host$url?$query&signature=$signature";

    // do request
    $data = @file_get_contents($request);

    return $data === false ? false : json_decode($data, $array);
}
?>
