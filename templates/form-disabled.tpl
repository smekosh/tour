{extends file="template.tpl"}

{block name="head"}

<link rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="{$homepage}/css/jquery.datetimepicker.css" />
<link rel="stylesheet" type="text/css" href="{$homepage}/css/jquery-ui-slider-pips.css">

{/block}

{block name="jumbotron"}

<h1>VOA Tour Reservations</h1>
<p>Tours of the VOA radio and television studios in Washington are available to the public. It's a fascinating look at the largest U.S. international broadcast operation.</p>

{/block}

{block name="body"}

<p>Daily public tours are offered Monday through Friday at 12:00 p.m. (except Federal holidays).</p>
<p>Please call <strong>(202) 203-4990</strong> to arrange a tour.  Groups are limited to 20 visitors.</p>

{/block}


{block name="footer"}

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>

<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="{$homepage}/js/bootstrap.min.js"></script>
<script src="{$homepage}/js/moment.min.js"></script>
<script src="{$homepage}/js/jquery.datetimepicker.js"></script>
<script src="{$homepage}/js/jquery-ui-slider-pips.min.js"></script>

{/block}
