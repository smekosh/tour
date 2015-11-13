{extends file="template.tpl"}

{block name="jumbotron"}

<h1>Visit VOA!</h1>
<p>Tours of the VOA radio and television studios in Washington are available to the public. It's a fascinating look at the largest U.S. international broadcast operation.</p>
<p><a href="{$homepage}/visit/" class="btn btn-primary btn-lg" role="button">Take the Tour &raquo;</a></p>

{/block}

{block name="body"}

<div class="row">
    <div class="col-md-4">
        <h2><a href="{$homepage}/about/">About the Tour</a></h2>
        <p><a href="{$homepage}/about/" class="teaser-img about-teaser"></a></p>
        <p>The Voice of America Studio Tour is a behind-the-scenes look at live broadcasting in radio, television, and the Internet in several of our 45 languages. Tours last 45 minutes. </p>
        <p><a class="btn btn-default" href="{$homepage}/about/" role="button">View details &raquo;</a></p>
    </div>
    <div class="col-md-4">
        <h2><a href="{$homepage}/what-to-bring/">What You Need to Bring</a></h2>
        <p><a href="{$homepage}/what-to-bring/" class="teaser-img whattobring-teaser"></a></p>
        <p>You will need to present a valid US federal or state-issued picture ID, such as a driver's license, passport or state-issued ID. A non-US citizen is required to provide their passport. The building guards cannot accept other documents or waive these requirements. </p>
        <p><a class="btn btn-default" href="{$homepage}/what-to-bring/" role="button">View details &raquo;</a></p>
    </div>
    <div class="col-md-4">
        <h2><a href="{$homepage}/directions/">Address &amp; Directions</a></h2>
        <p><a href="{$homepage}/directions/" class="teaser-img directions-teaser"></a></p>
        <p>VOA is located at 330 Independence Avenue, S.W., Washington, D.C. 20237. It is easily accessible by car, bus, and metro.</p>
        <p><a class="btn btn-default" href="{$homepage}/directions/" role="button">View details &raquo;</a></p>
    </div>
</div>

{/block}
