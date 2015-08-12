
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
    pub_month:"08",
    pub_day:"10",
    pub_weekday:"Monday",
    slug:"{$page}"
}
</script>

{literal}

<script type="text/javascript">
(function(a,b,c,d){
a='//tags.tiqcdn.com/utag/bbg/voa-nonpangea/prod/utag.js';
b=document;c='script';d=b.createElement(c);d.src=a;d.type='text/java'+c;d.async=true;
a=b.getElementsByTagName(c)[0];a.parentNode.insertBefore(d,a);
})();
</script>


<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-W72N2D"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-W72N2D');</script>
<!-- End Google Tag Manager -->

{/literal}

{else}

<!-- development mode -->

{/if}
