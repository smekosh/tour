<?php

// no trailing slash
define( "HOMEPAGE",         "http://localhost/tour" );
define( "APP_PATH",         "/" );

// maintenance mode, direct visitors to call
define( "DISABLE_SIGNUP",   false );

// don't allow direct-access to files
define( "PROGRAM_RUNNING",  true );

define( "MYSQL_HOST",       "localhost" );
define( "MYSQL_USER",       "username" );
define( "MYSQL_PASS",       "password" );
define( "MYSQL_DATABASE",   "database" );

// added to bottom of each page
define( "FOOTER",             <<<EOF

<!-- metrics code here -->

<!-- end metrics -->

EOF
);
