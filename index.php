<?php
require( "config.php" );
require( "vendor/autoload.php" );
require( "class.db.php" );
require( "class.calendar.php" );
if( !defined( "HOMEPAGE") ) die( "Error, config file missing?" );

// ===========================================================================
// routing - works for / or /tour/
// ===========================================================================
$klein = new \Klein\Klein();
$request = \Klein\Request::createFromGlobals();
$uri = $request->server()->get('REQUEST_URI');
$request->server()->set('REQUEST_URI', substr($uri, strlen(APP_PATH)));

// ===========================================================================
// lazy service create
// ===========================================================================
$klein->respond(function($request, $response, $service, $app) {
    $app->register('smarty', function() {
        $smarty = new Smarty();
        $smarty->assign( "homepage", HOMEPAGE );
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

foreach( $simple_pages as $route => $template ) {
    $klein->respond($route, function($req, $resp, $svc, $app) use ($template) {
        $app->smarty->assign("page", $template);
        return( $app->smarty->fetch( "{$template}.tpl" ) );
    });
}

// ===========================================================================
// something's amiss
// ===========================================================================
$klein->onHttpError(function($code, $router) use (&$klein) {
    $router->app()->smarty->display("404.tpl");
});

$klein->dispatch($request);
