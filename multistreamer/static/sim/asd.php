<?php

echo
"<form action='' method='post'>
<input type='submit' name='use_button' value='something' />
</form>";

if (isset($_POST['button']))
{
    shell_exec("echo $_POST['button'] > /tmp/simc.web");

}

?>
