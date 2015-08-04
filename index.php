<?php
require( "config.php" );
require( "vendor/autoload.php" );
require( "class.calendar.php" );
require( "class.data.php" );
require( "class.auth.php" );

if( !defined( "HOMEPAGE") ) die( "Error, config file missing?" );

// ===========================================================================
// routing - works for /
// ===========================================================================
$klein = new \Klein\Klein();
$request = \Klein\Request::createFromGlobals();

//  or /tour/
if( DEVELOPMENT_MODE === true ) {
    $uri = $request->server()->get('REQUEST_URI');
    $request->server()->set('REQUEST_URI', substr($uri, strlen(APP_PATH)));
}

// lets see if sendmail has a neat queue mode
$mail = new PHPMailer();

// may want to selectively activate this as-needed
use Illuminate\Database\Capsule\Manager as Capsule;
$capsule = new Capsule;
$capsule->addConnection($DATABASE_CONNECTION);
$capsule->bootEloquent();

// ===========================================================================
// lazy service create
// ===========================================================================
$klein->respond(function($request, $response, $service, $app) {
    $app->register('smarty', function() {
        $smarty = new Smarty();
        $smarty->assign( "homepage", HOMEPAGE );
        $smarty->assign( "DEVELOPMENT_MODE", DEVELOPMENT_MODE );
        return( $smarty );
    });
});

// ===========================================================================
// simple pages
// ===========================================================================
$simple_pages = array(
    "/" =>                  "index",
    "/about/" =>            "about",
    "/directions/" =>       "directions",
    "/what-to-bring/" =>    "bring",
    "/visit/" =>            "form"
);

$reservation_range = array(
    "start" => time(),
    "end" => strtotime("+3 month")
);

// maintenance mode, set in config
if( DISABLE_SIGNUP === true ) {
    $simple_pages["/visit/"] = "form-disabled";
}

foreach( $simple_pages as $route => $template ) {
    $klein->respond($route, function($req, $resp, $svc, $app) use ($template, $reservation_range) {
        $app->smarty->assign("page", $template);
        $app->smarty->assign("reservation_range", $reservation_range);
        return( $app->smarty->fetch( "{$template}.tpl" ) );
    });
}

// ===========================================================================
// auth needed for admin panel
// ===========================================================================
function admin_panel_ym($year, $month = null) {

    // treated as a timestamp
    if( is_null($month) ) {
        $month = date("m", $year);
        $year = date("Y", $year);
    }

    $r = new stdClass();
    $r->year = $year;
    $r->month = $month;
    $r->stamp = "{$r->year}-{$r->month}-01";

    return( $r );
}

function admin_panel($req, $resp, $svc, $app, $template) {
    $auth = new VOA_Auth(); // die if not auth
    $app->smarty->assign("page", "admin");

    // implied parameters, but not optional
    if( is_null($req->year) ) $req->year = date("Y");
    if( is_null($req->month) ) $req->month = date("m");

    // compute navigation timestamps (year-month)
    $ts = strtotime("{$req->year}-{$req->month}-01");
    $prev = admin_panel_ym(strtotime("-1 month", $ts));
    $next = admin_panel_ym(strtotime("+1 month", $ts));
    $app->smarty->assign("current", admin_panel_ym($req->year, $req->month) );
    $app->smarty->assign("next", $next );
    $app->smarty->assign("prev", $prev );

    // data only contains month's shape
    $calendar_data = new VOA_calendar($req->year, $req->month);
    $calendar = $calendar_data->getMonth();
    $app->smarty->assign("calendar", $calendar);

    // data contains closed days
    $closed = Tours::
        where("closed", "Yes")
        ->where("visit_day", ">=", "{$req->year}-{$req->month}-01" )
        ->where("visit_day", "<", "{$next->year}-{$next->month}-01" )
        ->get();

    // complex data structure reduced to array keys, for easy template lookup
    $closed_simple = array();
    foreach( $closed as $day ) {
        $closed_simple[$day->visit_day] = 1;
    }
    $app->smarty->assign("closed", $closed_simple);

    return( $app->smarty->fetch( "admin.tpl") );
}

$klein->respond("POST", "/admin/update", function($req, $resp, $svc, $app) use ($template) {
    $r = array("id" => array(), "rand" => rand(), "visit_day" => $req->day );

    if( $req->closed === "yes" ) {
        $days = Tours::whereVisit_day($req->day)->whereClosed("yes");
        # foreach( $days as $day ) {
        #     $r["id"][] = $day->id;
        # }
        $days->delete();
    } else {
        $day = new Tours;
        $day->visit_day = $req->day;
        $day->closed = "Yes";
        $day->save();

        #$r["id"][] = $day->id;
    }

    // all we want to know is if the day is closed
    $updated_day = Tours::whereClosed("yes")->whereVisit_day($req->day)->first();
    if( is_null($updated_day) ) {
        $r["is_closed"] = "no";
    } else {
        $r["is_closed"] = "yes";
    }

    return(json_encode($r));
});

$klein->respond("/admin/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_panel($req, $resp, $svc, $app, $template));
});

// admin / 2015 / 08 /
$klein->respond("/admin/[i:year]/[i:month]/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_panel($req, $resp, $svc, $app, $template));
});

// ===========================================================================
// form processor
// ===========================================================================
$klein->respond("post", "/visit/request", function($req, $resp, $svc, $app) use ($template) {
    $svc->validateParam(
        "number_of_visitors",
        "Please select a number between 0 and 20")
        ->isLen(1,2)
        ->isChars('0-9')
    ;

    $p = $req->params();
    print_r( $p );
    die;
});

// ===========================================================================
// something's amiss
// ===========================================================================
$klein->onHttpError(function($code, $router) use (&$klein) {
    $router->app()->smarty->display("404.tpl");
});

$klein->dispatch($request);
