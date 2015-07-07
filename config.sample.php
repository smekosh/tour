<?php

// no trailing slash
define( "HOMEPAGE",         "http://localhost/tour" );
define( "APP_PATH",         "/" );

// maintenance mode, direct visitors to call
define( "DISABLE_SIGNUP",   false );

// development mode, route altered for /subfolder/
define( "DEVELOPMENT_MODE", false );

// don't allow direct-access to files
define( "PROGRAM_RUNNING",  true );

// settings for eloquent
$DATABASE_CONNECTION = array(
    "driver" => "mysql",
    "host" => "localhost",
    "database" => "database",
    "username" => "username",
    "password" => "password",
    "charset" => "utf8",
    "collation" => "utf8_unicode_ci",
    "prefix" => ""
);
