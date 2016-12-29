<?php
require( "config.php" );
require( "vendor/autoload.php" );
require( "class.calendar.php" );
require( "class.data.php" );
require( "class.auth.php" );

date_default_timezone_set("America/New_York");

// for varnish
if( isset( $_SERVER['HTTP_X_FORWARDED_FOR']) ) {
    $_SERVER['REMOTE_ADDR'] = $_SERVER['HTTP_X_FORWARDED_FOR'];
}

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

        // make sure css files cache is reset on updates
        $master = realpath(".git/refs/heads/master");
        if( $master === false ) {
            $version = filemtime("index.php");
        } else {
            $version = trim(file_get_contents($master));
        }

        $smarty->assign( "version", $version );
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

// for debugging purposes
if( DISABLE_SIGNUP === true && SECRET_SIGNUP_TEST_FORM === true ) {
    $simple_pages["/testform/"] = "form";
}

// ===========================================================================
// used to lock down calendar selection
// ===========================================================================
function get_available_tours($reservation_range) {
    $closed = Tours::
        where("closed", "Yes")
        ->where("visit_day", ">=", $reservation_range["date_start"] )
        ->where("visit_day", "<=", $reservation_range["date_end"] )
        ->get();

    $r = array(
        "closed" => array(),
        "reserved" => array()
    );
    foreach( $closed as $close ) {
        $r["closed"][$close->visit_day] = 1;
    }

    $reserved = Tours::
        where("closed", "No")
        ->where("visit_day", ">=", $reservation_range["date_start"] )
        ->where("visit_day", "<=", $reservation_range["date_end"] )
        ->get();

    foreach( $reserved as $reserve ) {
        if( !isset($r["reserved"][$reserve->visit_day]) ) {
            $r["reserved"][$reserve->visit_day] = 0;
        }

        $r["reserved"][$reserve->visit_day] += $reserve->num_visitors;
    }

    return( $r );
}

$reservation_range = array(
    "start" => time(),
    "end" => strtotime("+3 month")
);

$reservation_range["date_start"] = date("Y-m-d", $reservation_range["start"] );
$reservation_range["date_end"] = date("Y-m-d", $reservation_range["end"] );
$reservation_range["days"] = get_available_tours($reservation_range);

// ===========================================================================
// maintenance mode, set in config
// ===========================================================================
if( DISABLE_SIGNUP === true ) {
    $simple_pages["/visit/"] = "form-disabled";
}

foreach( $simple_pages as $route => $template ) {
    $klein->respond($route, function($req, $resp, $svc, $app) use ($template, $reservation_range) {
        $app->smarty->assign("page", $template);
        $app->smarty->assign("reservation_range", $reservation_range);

        $data = admin_panel_data($req, $resp, $svc, $app, $template);

        // all assignments at once
        foreach( $data as $k => $v ) {
            $app->smarty->assign( $k, $v );
        }

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

// ===========================================================================
// data structure reused by both admin / report screens
// ===========================================================================
function admin_panel_data($req, $resp, $svc, $app, $template) {

    // implied parameters, but not optional
    if( is_null($req->year) ) $req->year = date("Y");
    if( is_null($req->month) ) $req->month = date("m");

    // compute navigation timestamps (year-month)
    $ts = strtotime("{$req->year}-{$req->month}-01");
    $prev = admin_panel_ym(strtotime("-1 month", $ts));
    $next = admin_panel_ym(strtotime("+1 month", $ts));
    $next2 = admin_panel_ym(strtotime("+2 month", $ts));
    $next3 = admin_panel_ym(strtotime("+3 month", $ts));

    // data only contains month's shape
    $calendar_data = new VOA_calendar($req->year, $req->month);
    $calendar = $calendar_data->getMonth();

    $calendar_data_next = new VOA_calendar($next->year, $next->month);
    $calendar_next = $calendar_data_next->getMonth();

    $calendar_data_next2 = new VOA_calendar($next2->year, $next2->month);
    $calendar_next2 = $calendar_data_next2->getMonth();

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

    // ----------------------------------

    $closed_next = Tours::
        where("closed", "Yes")
        ->where("visit_day", ">=", "{$next->year}-{$next->month}-01" )
        ->where("visit_day", "<", "{$next2->year}-{$next2->month}-01" )
        ->get();

    // complex data structure reduced to array keys, for easy template lookup
    $closed_next_simple = array();
    foreach( $closed_next as $day ) {
        $closed_next_simple[$day->visit_day] = 1;
    }

    $closed_next2 = Tours::
        where("closed", "Yes")
        ->where("visit_day", ">=", "{$next2->year}-{$next2->month}-01" )
        ->where("visit_day", "<", "{$next3->year}-{$next3->month}-01" )
        ->get();

    // complex data structure reduced to array keys, for easy template lookup
    $closed_next2_simple = array();
    foreach( $closed_next2 as $day ) {
        $closed_next2_simple[$day->visit_day] = 1;
    }

    // ----------------------------------

    // data contains day count_chars
    $reservations = Tours::
        where("closed", "No")
        ->where("visit_day", ">=", "{$req->year}-{$req->month}-01" )
        ->where("visit_day", "<", "{$next->year}-{$next->month}-01" )
        ->get();

    $reservation_count = array();
    foreach( $reservations as $reservation ) {
        if( !isset($reservation_count[$reservation->visit_day] ) ) {
            $reservation_count[$reservation->visit_day] = array(
                "Total" => 0,
                "Daily" => 0,
                "Daily_Groups" => 0,
                "Special" => 0,
                "Special_Groups" => 0,
                "Details" => []
            );
        }
        $reservation_count[$reservation->visit_day]["Total"] += $reservation->num_visitors;
        $reservation_count[$reservation->visit_day][$reservation->type_of_tour] += $reservation->num_visitors;

        $reservation_count[$reservation->visit_day]["Details"][] = array(
            "num_visitors" => $reservation->num_visitors,
            "type_of_tour" => $reservation->type_of_tour
        );

        if( $reservation->type_of_tour === "Daily" ) {
            $reservation_count[$reservation->visit_day]["Daily_Groups"]++;
        }
        if( $reservation->type_of_tour === "Special" ) {
            $reservation_count[$reservation->visit_day]["Special_Groups"]++;
        }
    }

    return( array(
        "current" => admin_panel_ym($req->year, $req->month),
        "next" => $next,
        "prev" => $prev,
        "calendar" => $calendar,
        "calendar_next" => $calendar_next,
        "calendar_next2" => $calendar_next2,
        "closed" => $closed_simple,
        "closed_next" => $closed_next_simple,
        "closed_next2" => $closed_next2_simple,
        "reservations" => $reservation_count
    ));
}

// generic page render
function webpage_render($req, $resp, $svc, $app, $doc) {

    $data = admin_panel_data($req, $resp, $svc, $app, "");

    // all assignments at once
    foreach( $data as $k => $v ) {
        $app->smarty->assign( $k, $v );
    }

    $app->smarty->assign("doc", $doc);
    return( $app->smarty->fetch("page-generic.tpl") );
}

// preview function
function admin_edit_panel_preview($req, $resp, $svc, $app, $template) {
    $auth = new VOA_Auth(); // die if not auth

    $copy = json_decode(file_get_contents("copy.json"));
    $page = "/preview/";

    #echo "<PRE>";echo htmlentities(print_r($copy->pages->{$page}, true)); die;
    return( webpage_render($req, $resp, $svc, $app, $copy->pages->{$page}) );
}

// update text
function admin_edit_panel_post($req, $resp, $svc, $app, $template, $excel = false) {
    $auth = new VOA_Auth(); // die if not auth
    $copy = json_decode(file_get_contents("copy.json"));
    $ret = array();

    $slug = str_replace("_", "/", $req->slug);

    // update requires all pages exist, can't create new
    if( !isset( $copy->pages->$slug ) ) {
        //$ret["status"] = "fail";
        //$ret["message"] = "slug {$slug} missing :/";
        //echo json_encode($ret);
        $copy->pages->$slug = new stdClass();
    }

    $copy->pages->$slug = new stdClass();

    $copy->pages->$slug->title = $req->title;

    if( $req->slug === "new" ) {
        $copy->pages->$slug->slug = $req->new_slug;
    } else {
        $copy->pages->$slug->slug = $req->slug;
    }

    $copy->pages->$slug->status = $req->status;
    $copy->pages->$slug->columns = $req->columns;
    $copy->pages->$slug->teaser_markdown = $req->teaser_markdown;
    $copy->pages->$slug->teaser_html = $req->teaser_html;
    $copy->pages->$slug->content = array( new stdClass(), new stdClass(), new stdClass() );

    for( $i = 0; $i < 3; $i++ ) {
        $copy->pages->$slug->content[$i]->markdown = $req->content[$i]["markdown"];
        $copy->pages->$slug->content[$i]->html = $req->content[$i]["html"];
    }

    if( $slug == "/preview/" ) {
        $ret["url"] = HOMEPAGE . "/preview/?ts=" . time();
        $copy->pages->$slug->status = "draft";
    }

    file_put_contents("copy.json", json_encode($copy));

    $ret["status"] = "ok";
    $ret["message"] = filesize("copy.json");

    $ret["status"] = "fail";
    $ret["message"] = "old  slug = " . $slug . ", new slug = " . $req->new_slug;

    echo json_encode($ret);
    die;
}

function get_new_page() {
    $temp = new stdClass();
    $temp->status = "draft";
    $temp->slug = "new";
    $temp->title = "Untitled";
    $temp->teaser_markdown = "";
    $temp->teaser_html = "";
    $temp->columns = 1;

    $blank = new stdClass();
    $blank->markdown = "";
    $blank->html = "";
    $temp->content = array(
        $blank, $blank, $blank
    );

    return( $temp );
}

function admin_edit_panel($req, $resp, $svc, $app, $template, $excel = false) {
    $auth = new VOA_Auth(); // die if not auth
    $app->smarty->assign("page", "edit");
    $copy = json_decode(file_get_contents("copy.json"));
    $app->smarty->assign("copy", $copy);
    if( is_null($req->slug) ) {
        $app->smarty->assign("overview", true);
    } else {
        $edit_slug = str_replace("_", "/", $req->slug);

        if( !isset( $copy->pages->$edit_slug) ) {
            #die( "Error: page <code>{$edit_slug}</code> does not exist" );
            $copy->pages->$edit_slug = get_new_page();
        }
        $app->smarty->assign("edit_slug", $edit_slug );
        $app->smarty->assign("edit_page", $copy->pages->$edit_slug );
    }
    return( $app->smarty->fetch( "edit.tpl") );
}

function admin_report_panel($req, $resp, $svc, $app, $template, $excel = false) {
    $auth = new VOA_Auth(); // die if not auth
    $app->smarty->assign("page", "report");

    $data = admin_panel_data($req, $resp, $svc, $app, $template);

    // all assignments at once
    foreach( $data as $k => $v ) {
        $app->smarty->assign( $k, $v );
    }

    // monthly total
    $all = array(
        "Total" => 0,
        "Daily" => 0,
        "Daily_Groups" => 0,
        "Special" => 0,
        "Special_Groups" => 0
    );

    foreach( $data["reservations"] as $day => $counts ) {

        // not needed here, also not a number
        unset( $counts["Details"] );

        foreach( $counts as $k => $v ) {
            $all[$k] += $v;
        }
    }

    $app->smarty->assign( "totals", $all );

    if( $excel === true ) {
        $filename = sprintf("tour-%s-%s.xls", $req->year, $req->month );

        header( "Content-type: application/excel" );
        header( "Content-Disposition: attachment; filename={$filename}");

        $app->smarty->assign("excel", "1");
        return( $app->smarty->fetch( "report-table.tpl") );
    } else {
        return( $app->smarty->fetch( "report.tpl") );
    }
}

function admin_panel($req, $resp, $svc, $app, $template) {
    $auth = new VOA_Auth(); // die if not auth
    $app->smarty->assign("page", "admin");

    $data = admin_panel_data($req, $resp, $svc, $app, $template);

    // all assignments at once
    foreach( $data as $k => $v ) {
        $app->smarty->assign( $k, $v );
    }

    return( $app->smarty->fetch( "admin.tpl") );
}

$klein->respond("POST", "/admin/update", function($req, $resp, $svc, $app) use ($template) {
    $auth = new VOA_Auth(); // die if not auth
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

// useful for prefetched pages, but not using this feature yet
/*
function cache_headers_for( $seconds_to_cache = 60 ) {
    $ts = gmdate("D, d M Y H:i:s", time() + $seconds_to_cache) . " GMT";
    header("Expires: $ts");
    header("Pragma: cache");
    header("Cache-Control: max-age=$seconds_to_cache");
}
*/
$klein->respond("/preview/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_edit_panel_preview($req, $resp, $svc, $app, $template));
});

$klein->respond("/admin/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_panel($req, $resp, $svc, $app, $template));
});

// admin / 2015 / 08 /
$klein->respond("/admin/[i:year]/[i:month]/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_panel($req, $resp, $svc, $app, $template));
});

// admin / report /
$klein->respond("/admin/report/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_report_panel($req, $resp, $svc, $app, $template));
});

// admin / edit /
$klein->respond("/admin/edit/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_edit_panel($req, $resp, $svc, $app, $template));
});

// admin / edit / _about_ /
$klein->respond("/admin/edit/[:slug]", function($req, $resp, $svc, $app) use ($template) {
    return(admin_edit_panel($req, $resp, $svc, $app, $template));
});

// POST admin / edit / _about_ /
$klein->respond("post", "/admin/edit/[:slug]", function($req, $resp, $svc, $app) use ($template) {
    return(admin_edit_panel_post($req, $resp, $svc, $app, $template));
});

// admin / report / 2015 / 08 /
$klein->respond("/admin/report/[i:year]/[i:month]/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_report_panel($req, $resp, $svc, $app, $template));
});

// admin / report / 2015 / 08 / excel /
$klein->respond("/admin/report/[i:year]/[i:month]/excel/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_report_panel($req, $resp, $svc, $app, $template, true));
});

// ===========================================================================
// form validator errors
// ===========================================================================
$klein->onError(function($klein, $err_msg) {
    $retarr = array("status" => "bad", "message" => $err_msg);
    echo json_encode($retarr);
    die;
});

// ===========================================================================
// form processor
// ===========================================================================
$klein->respond("post", "/visit/request", function($req, $resp, $svc, $app) use ($template, $mail) {
    /*
    $svc->validateParam(
        "number_of_visitors",
        "Please select a number between 0 and 20")
        ->isLen(1,2)
        ->isChars('0-9')
    ;
    */

    $svc->addValidator('dateappropriate', function($str) {
        $ts = strtotime($str);
        $limit = strtotime("2017-01-01");

        if( $ts > $limit ) return( false );
        return( true );
    });

    $svc->validateParam(
        "tour_date",
        "Error: Date is <strong>unavailable</strong>."
    )->isDateappropriate();

    $svc->validateParam(
        "organizer_name",
        "Error: Please enter the organizer's <strong>full name</strong>."
    )->isLen(5, 100);

    $svc->validateParam(
        "organizer_phone",
        "Error: Please enter the organizer's full <strong>phone number</strong> with an area code." .
        "<br/>VOA studio tour staff may need to contact you about the scheduled tour."
    )->isLen(10, 100);

    $svc->validateParam(
        "organizer_email",
        "Error: Please enter the organizer's valid <strong>Email address</strong>." .
        "<br/>VOA studio tour staff may need to contact you about the scheduled tour."
    )->isEmail();

    $app->smarty->assign("reservation", $req->params() );
    $app->smarty->assign("remote_ip", $_SERVER["REMOTE_ADDR"]);

    // saving only the rudimentary data
    $day = new Tours;
    $day->visit_day = $req->tour_date;
    $day->closed = "No";
    $day->type_of_tour = $req->type_of_tour;
    $day->num_visitors = $req->number_of_visitors;
    $day->save();

    // at this point, the data is db-sanitized
    $day_db = Tours::where("id", $day->id)->get()->first();

    $mail->From = "noreply@voanews.com";
    $mail->FromName = "VOA Tour Calendar";
    $mail->addAddress(ADMIN_EMAIL);
    $mail->isHTML(true);

    // sending 3 emails now
    $fail_counter = 0;

    // email confirmation 1
    if( $req->type_of_tour === "Daily" ) {
        $mail->Subject = "Daily Reservation {$day_db->visit_day}, {$req->number_of_visitors} visitors ({$_SERVER["REMOTE_ADDR"]})";
    } else {
        $mail->Subject = "Special Reservation {$day_db->visit_day}, {$req->number_of_visitors} visitors ({$_SERVER["REMOTE_ADDR"]})";
    }
    $mail->Body = $app->smarty->fetch( "email.tpl" );

    if( !$mail->send() ) $fail_counter++;

    // email confirmation 2
    $mail->Subject = "YOUR RESERVATION FOR THE VOA STUDIO TOUR IS CONFIRMED";
    $mail->Body = $app->smarty->fetch( "email2.tpl" );
    $mail->addAttachment("img/voa-logo.jpg", "voa-logo.jpg");
    if( !$mail->send() ) $fail_counter++;

    // email confirmation 3
    if( $req->type_of_tour === "Daily" ) {
        $mail->Subject = "Daily Reservation roster {$day_db->visit_day}, {$req->number_of_visitors} visitors";
    } else {
        $mail->Subject = "Special Reservation roster {$day_db->visit_day}, {$req->number_of_visitors} visitors";
    }
    $mail->Body = $app->smarty->fetch( "email3.tpl" );
    if( !$mail->send() ) $fail_counter++;

    $retarr = array();
    $retarr["status"] = "good"; // until not

    if( $fail_counter > 0 ) {
        $retarr["message"] = "ERROR: message could not be sent . Please contact the VOA tour office.";
    } else {
        $retarr["message"] = "Thank you, your reservation has been sent.";
    }

    echo json_encode($retarr);
    die;
});

// ===========================================================================
// something's amiss
// ===========================================================================
$klein->onHttpError(function($code, $router) use (&$klein) {
    $router->app()->smarty->display("404.tpl");
});

$klein->dispatch($request);
