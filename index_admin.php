<?php
if( !defined( "HOMEPAGE") ) die( "Error, config file missing?" );

//TODO: need authentication

$db = new VOA_DB(
    MYSQL_HOST, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASS
);

$t = $db->Query("select * from `tourists` where `visit_day`>date(now())");

$smarty->assign( "data", $t );

$now = new DateTime();
$calendar_data = new VOA_calendar($now->format("Y"), $now->format("m"));
$calendar = $calendar_data->getMonth();
$smarty->assign( "calendar", $calendar );
