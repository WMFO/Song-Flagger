<?php
require_once('credentials.php'); #defines $papiuser and $papisecret
require_once('spinpapi.inc.php');

array_shift($argv);
$p['station'] = "wmfo";
$p['method']  = "getSong";

$data = spin_papi_query($p, $papiuser, $papisecret);

if ($data -> success == 1){
    $cmd = "sh songFlagger.sh \"" . $data -> results -> SongName . "\" \"" . $data -> results -> ArtistName . "\" \"" . $data -> results -> SongNote . "\"";
    system(escapeshellcmd($cmd));
}
?>

