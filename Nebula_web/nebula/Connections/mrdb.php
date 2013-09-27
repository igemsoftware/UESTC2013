<?php
# FileName="Connection_php_mysql.htm"
# Type="MYSQL"
# HTTP="true"
$hostname_ceg = "127.0.0.1";
$database_ceg = "igem";
$username_ceg = "root";
$password_ceg = "qWRPLperXKDS";
$ceg = mysql_pconnect($hostname_ceg, $username_ceg, $password_ceg) or trigger_error(mysql_error(),E_USER_ERROR); 
?>