<?php
if( !defined( "HOMEPAGE") ) die( "Error, config file missing?" );

//TODO: need authentication

// ===========================================================================
// calendar navigation is done by year-month, ignore the day
// ===========================================================================
$now = new DateTime();
if( isset($_GET['date']) ) $now->modify( $_GET['date'] );
$year = $now->format("Y");
$month = $now->format("m");
$ymd = "{$year}-{$month}-01";

// ===========================================================================
// blank calendar
// ===========================================================================
$now = new DateTime();
$calendar_data = new VOA_calendar($year, $month);
$calendar = $calendar_data->getMonth();

// ===========================================================================
// get stored reservations
// ===========================================================================
$db = new VOA_DB(
    MYSQL_HOST, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASS
);

$reserved = $db->Index("visit_day")->Query(
<<<EOF
    select
        `visit_day`, sum(`num_visitors`) as `count`
    from
        `tourists`
    where
        `visit_day` between ? and ?
    group by
        `visit_day`
    order by
        `visit_day` asc
EOF
,
    array(
        $calendar_data->start->format("Y-m-d"),
        $calendar_data->end->format("Y-m-d")
    )
);

// ===========================================================================
// templating needs this
// ===========================================================================
$smarty->assign( "calendar", $calendar );
$smarty->assign( "reserved", $reserved );
