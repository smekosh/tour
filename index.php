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

// maintenance mode, set in config
if( DISABLE_SIGNUP === true ) {
    $simple_pages["/visit/"] = "form-disabled";
}

foreach( $simple_pages as $route => $template ) {
    $klein->respond($route, function($req, $resp, $svc, $app) use ($template) {
        $app->smarty->assign("page", $template);
        return( $app->smarty->fetch( "{$template}.tpl" ) );
    });
}

// ===========================================================================
// auth needed for admin panel
// ===========================================================================
function admin_panel($req, $resp, $svc, $app, $template) {
    $auth = new VOA_Auth(); // die if not auth
    $app->smarty->assign("page", "admin");
    echo "<PRE>"; print_r( $req ); echo "</PRE>";
    return( $app->smarty->fetch( "admin.tpl") );
}

$klein->respond("/admin/", function($req, $resp, $svc, $app) use ($template) {
    return(admin_panel($req, $resp, $svc, $app, $template));
});

// admin / 2015 / 08 /
$klein->respond("/admin/[i]/[i]/", function($req, $resp, $svc, $app) use ($template) {
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
