{capture}
{$title = "Page not found"}
{$page = "404"}
{if $page == "index"}
    {$title = "VOA Studio Tour"}
{elseif $page == "about"}
    {$title = "About | VOA Studio Tour"}
{elseif $page == "directions"}
    {$title = "Directions | VOA Studio Tour"}
{elseif $page == "bring"}
    {$title = "What to Bring | VOA Studio Tour"}
{elseif $page == "form"}
    {$title = "Visit | VOA Studio Tour"}
{elseif $page == "form-disabled"}
    {$title = "Visit | VOA Studio Tour"}
{/if}
{/capture}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="{$homepage}/favicon.ico">
    <title>{$title}</title>

    <!-- Bootstrap core CSS -->
    <link href="{$homepage}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="{$homepage}/css/voa-tour.css" rel="stylesheet">
{block name="head"}
{/block}

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="{$homepage}../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="{$homepage}/js/ie10-viewport-bug-workaround.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

{include file="metrics.tpl"}

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="{$homepage}/">VOA Tour</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="{if $page == "index"}active{/if}"><a href="{$homepage}/">Home</a></li>
                    <li class="{if $page == "about"}active{/if}"><a href="{$homepage}/about/">About the Tour</a></li>
                    <li class="{if $page == "form"}active{/if}"><a href="{$homepage}/visit/">Take the Tour</a></li>
                    <li class="{if $page == "directions"}active{/if}"><a href="{$homepage}/directions/">Address &amp; Directions</a></li>
                    <li class="{if $page == "bring"}active{/if}"><a href="{$homepage}/what-to-bring/">What to Bring</a></li>
                </ul>
            </div><!--/.navbar-collapse -->
        </div>
    </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
        <div class="container">
{block name="jumbotron"}{/block}
        </div>
    </div>

    <div class="container">
{block name="body"}{/block}

        <footer>
            <p>Return to the <a href="http://www.voanews.com/?source=voatour">Voice of America</a> homepage.</p>
        </footer>
    </div> <!-- /container -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="{$homepage}/js/bootstrap.min.js"></script>

{block name="footer"}{/block}

</body>
</html>
