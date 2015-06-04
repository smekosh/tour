<?php

require( "vendor/autoload.php" );
require( "config.php" );

$smarty = new Smarty();
$smarty->display( "index.tpl" );
