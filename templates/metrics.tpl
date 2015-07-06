
{if $DEVELOPMENT_MODE === false}

<script type="text/javascript">
var utag_data = {
    entity:"VOA",
    language:"English",
    language_service:"VOA Public Affairs",
    short_language_service:"PA",
    property_id:"195",
    platform:"Desktop",
    platform_short:"D",
    runs_js:"Yes",
    page_title:"{$title}",
    page_type:"Section",
    page_name:"{$title}",
    short_headline:"{$title}",
    long_headline:"{$title}",
    headline:"{$title}",
    content_type:"Section",
    pub_year:"2015",
    pub_month:"07",
    pub_day:"06",
    pub_weekday:"Monday",
    slug:"{$page}"
}
</script>


<script type="text/javascript">
(function(a,b,c,d){
a='//tags.tiqcdn.com/utag/bbg/voa-nonpangea/prod/utag.js';
b=document;c='script';d=b.createElement(c);d.src=a;d.type='text/java'+c;d.async=true;
a=b.getElementsByTagName(c)[0];a.parentNode.insertBefore(d,a);
})();
</script>

{else}

<!-- development mode -->

{/if}
