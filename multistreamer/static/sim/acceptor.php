<?php
function getUserIP()
{
	$client  = @$_SERVER['HTTP_CLIENT_IP'];
	$forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
	$remote  = $_SERVER['REMOTE_ADDR'];
if(filter_var($client, FILTER_VALIDATE_IP))
     {
        $ip = $client;
     }
elseif(filter_var($forward, FILTER_VALIDATE_IP))
     {
        $ip = $forward;
     }
else
     {
	$ip = $remote;
     }
    return $ip;
}

$user_ip = getUserIP();

#echo $user_ip; 

$outputDir='/opt/multistreamer/static/sim/data';
if(!file_exists($outputDir))
    @mkdir($outputDir,0775);
if(file_exists($outputDir) && is_dir($outputDir) && is_writable($outputDir))
    $outputDir.='/';
else
    $outputDir.='_';
$outputFname=date('Y-m-d_H-i-s-').$user_ip;
if(isset($_POST['reqData']) && !empty($_POST['reqData'])) {
    $data=$_POST['reqData'];
    file_put_contents($outputDir.$outputFname,$data);
#   shell_exec("/usr/bin/simc $outputDir$outputFname json2=$outputDir$outputFname.json report_details=1 calculate_scale_factors=1 scale_only=mastery,versatility,haste,crit_rating,agility");
    shell_exec("/usr/bin/simc $outputDir$outputFname json2=$outputDir$outputFname.json scale_only=mastery,versatility,haste,crit_rating,agility");
    $json = file_get_contents("https://app.combatlog.eu/sim/data/$outputFname.json");
    $p = json_decode($json, true);
    $name = $p['sim']['players'][0]['name'];
    $race = $p['sim']['players'][0]['race'];
    $dps = number_format($p['sim']['players'][0]['collected_data']['dpse']['mean'] , 2, '.', ',');
    echo "name: $name <br>race: $race <br>dps: $dps";

}

#shell_exec("/usr/bin/simc $outputDir.$outputFname json2=$outputDir.$outputFname.json iterations=10000 report_details=1 calculate_scale_factors=1  scale_only=mastery,versatility,haste,crit_rating,agility");

?>

