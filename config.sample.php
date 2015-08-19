<?php

// no trailing slash
define( "HOMEPAGE",         "http://localhost/tour" );
define( "APP_PATH",         "/" );

// rudimentary control, allows for number adjustments and calendar block-offs
define( "ADMIN_USERNAME",   "admin-username" );
define( "ADMIN_PASSWORD",   "enter-password-here" );
define( "ADMIN_EMAIL",      "email@example.com" );

// maintenance mode, direct visitors to call
define( "DISABLE_SIGNUP",   false );

// in case form is disabled, you can access a /testform/ URL to simulate it
define( "SECRET_SIGNUP_TEST_FORM",   false );

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
