<?php
if( !defined( "HOMEPAGE") ) die( "Error, config file missing?" );

//TODO: need authentication

$db = new VOA_DB(
    MYSQL_HOST, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASS
);

$t = $db->Query("select * from `tourists` where `when`>date(now())");

$smarty->assign( "data", $t );
