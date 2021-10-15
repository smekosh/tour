{strip}{capture}
{$title = "Page not found"}
{if !isset($page)}{$page = "404"}{/if}
{if $page == "index"}
    {$title = "Voice of America Studio Tour"}
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
{elseif $page == "admin"}
    {$title = "Admin {$current->year}/{$current->month} | VOA Studio Tour"}
{elseif $page == "report"}
    {$title = "Report {$current->year}/{$current->month} | VOA Studio Tour"}}
{elseif $page == "edit"}
    {$title = "Edit Text | VOA Studio Tour"}}
{/if}
{/capture}
{capture assign="canonical"}
    //{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}
{/capture}
{/strip}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="image/x-icon" rel="icon" href="{$homepage}/favicon.ico">

    <title>{$title}</title>

    <link rel="canonical" href="{$canonical}">
    <link rel="image_src" href="{$homepage}/img/voa-tour-share-1200x650.jpg">

    <meta name="title" content="{$title}">
    <meta itemprop="description" name="description" content="The Voice of America Studio Tour is a behind-the-scenes look at live radio, TV, and digital broadcasting in the 43 languages we support.">
    <meta name="keywords" content="voice of america, voa, voa studio tour, tours in dc">

    <meta property="og:type" content="article" />
    <meta property="og:site_name" content="Inside VOA" />
    <meta property="og:title" content="{$title}" />
    <meta property="og:description" content="The Voice of America Studio Tour is a behind-the-scenes look at live radio, TV, and digital broadcasting in the 43 languages we support." />
    <meta property="og:url" content="{$canonical}" />
    <meta property="og:image" content="{$homepage}/img/voa-tour-share-1200x650.jpg" />

    <meta name="twitter:card" value="summary_large_image">
    <meta name="twitter:site" value="@VOABuzz">
    <meta name="twitter:creator" content="@VOABuzz">
    <meta name="twitter:title" content="{$title}">
    <meta name="twitter:description" content="The Voice of America Studio Tour is a behind-the-scenes look at live radio, TV, and digital broadcasting in the 43 languages we support.">
    <meta name="twitter:url" content="{$canonical}">
    <meta name="twitter:image" content="{$homepage}/img/voa-tour-share-1200x650.jpg">

    <meta name="DISPLAYDATE" content="January 1, 2017">
    <meta itemprop="dateModified" content="2017-01-01">
    <meta itemprop="datePublished" content="2017-01-01">


    <!-- Bootstrap core CSS -->
    <link href="{$homepage}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="{$homepage}/css/voa-tour.css?v=e{$version}" rel="stylesheet">
{block name="head"}
{/block}

    {*
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <!--<script src="{$homepage}../../assets/js/ie-emulation-modes-warning.js"></script>-->
    *}

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
                <a class="navbar-brand" href="{$homepage}/"><img src="{$homepage}/img/2015-08_voa-tour-logo_2x.png" width="100" height="20" alt="VOA Tour" /></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="{if $page == "index"}active{/if}"><a href="{$homepage}/">Home</a></li>
                    <li class="{if $page == "about"}active{/if}"><a href="{$homepage}/about/">About the Tour</a></li>
                    <li class="{if $page == "directions"}active{/if}"><a href="{$homepage}/directions/">Address &amp; Directions</a></li>
                    <li class="{if $page == "bring"}active{/if}"><a href="{$homepage}/what-to-bring/">What to Bring</a></li>
                </ul>
            </div><!--/.navbar-collapse -->
        </div>
    </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-md-8">

                    <p style="color:crimson; background-color:rgba(0,0,0,0.8);padding: 0.5em;">The Voice of America is canceling VOA Studio Tours until further notice due to concerns related to the Coronavirus/COVID-19.  We will be continuously reevaluating the situation, as more information on the Coronavirus/COVID-19 becomes available through official national public health channels.  We apologize in advance for any inconvenience this might cause. Please check back with us regularly for any updates.</p> 

                    {block name="jumbotron"}{/block}
                </div>
                <div class="col-sm-6 col-md-4">
                    {block name="calendar"}{*{include file="calendar.tpl"}*}{/block}
                </div>
            </div>
        </div>
    </div>

    <div class="container">
{block name="body"}{/block}

        <footer>
            <p><a href="{$homepage}/">Home</a> <gnarly-spacer>|</gnarly-spacer> Return to the <a href="https://www.insidevoa.com/?source=voatour">Inside VOA</a> homepage.</p>
        </footer>
    </div> <!-- /container -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="{$homepage}/js/bootstrap.min.js"></script>

<script>
// user calendar nav
$("a.navigate-user-calendar").click(function() {

    var eq = $(this).attr("data-eq");
    var go = $(this).attr("data-go");

    $(".reservation-calendar-reader-container").hide();
    $(".reservation-calendar-reader-container:eq(" + go + ")").show();

/*    function reactivate(hide,show) {
        $(".reservation-calendar-reader-container:eq(" + hide + ")").hide();
        $(".reservation-calendar-reader-container:eq(" + show + ")").show();
    }

    if( $(this).hasClass("glyphicon-circle-arrow-left") ) {
        reactivate(1,0);
    } else {
        reactivate(0,1);
    }
*/
    return(false);
});
</script>

{block name="footer"}{/block}

</body>
</html>
