<?php
require( "config.php" );
require( "vendor/autoload.php" );
require( "class.db.php" );
require( "class.calendar.php" );
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

// ===========================================================================
// lazy service create
// ===========================================================================
$klein->respond(function($request, $response, $service, $app) {
    $app->register('smarty', function() {
        $smarty = new Smarty();
        $smarty->assign( "homepage", HOMEPAGE );
        $smarty->assign( "post_footer", FOOTER );
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
// form processor
// ===========================================================================
$klein->respond("post", "/visit/request", function($req, $resp, $svc, $app) use ($template) {
    #$svc->validateParam("number_of_visitors"
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
