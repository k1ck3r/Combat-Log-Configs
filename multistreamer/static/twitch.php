/* Auth example taken from 
   https://discuss.dev.twitch.tv/t/authorization-code-flow/5148/6
   BarryCarlyon - This dirty script may help: */

<?php

$client_id = 'ooa4t9808i72fvcs65jkt4i4nk8gi9';
$client_secret = 'jedlf6tfpg0q67sxsu6frkhmzczxia';
$redirect_uri = 'https://app.combatlog.eu/auth/twitch';

if ($_GET['code']) {
    $token_url = 'https://api.twitch.tv/kraken/oauth2/token';
    $data = array(
        'client_id' => $client_id,
        'client_secret' => $client_secret,
        'grant_type' => 'authorization_code',
        'redirect_uri' => $redirect_uri,
        'code' => $_GET['code']
    );

    $curl = curl_init($token_url);
    curl_setopt($curl, CURLOPT_POST, true);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

    $result = curl_exec($curl);
    $i = curl_getinfo($curl);
    curl_close($curl);

    if ($i['http_code'] == 200) {
        $result = json_decode($result, true);

        // get
        $curl = curl_init('https://api.twitch.tv/kraken/user');
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array(
            'Accept: application/vnd.twitchtv.v3+json',
            'Client-ID: ' . $client_id,
            'Authorization: OAuth ' . $result['access_token']
        ));
        $user = curl_exec($curl);
        $i = curl_getinfo($curl);
        curl_close($curl);

        if ($i['http_code'] == 200) {
            $user = json_decode($user);

            echo '<p>Thanks ' . $user->display_name . ' <3</p>';

            // THE USER IS LOGGED IN
        } else {
            echo '<p>An error occured, please <a href="/">click here and try again</a></p>';
        }
    } else {
        echo '<p>An error occured, please <a href="/">click here and try again</a></p>';
    }
} else {
    $scopes = array(
        'user_read' => 1,
    );

    $req_scope = '';
    foreach ($scopes as $scope => $allow) {
        if ($allow) {
            $req_scope .= $scope . '+';
        }
    }
    $req_scope = substr($req_scope, 0, -1);

    $auth_url = 'https://api.twitch.tv/kraken/oauth2/authorize?response_type=code';
    $auth_url .= '&client_id=' . $client_id;
    $auth_url .= '&redirect_uri=' . $redirect_uri;
    $auth_url .= '&scope=' . $req_scope;
    $auth_url .= '&force_verify=true';

    echo '<a href="' . $auth_url . '">Please Click this Link to Authenticate with Twitch</a>';
}
