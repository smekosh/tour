{extends file="template.tpl"}

{block name="jumbotron"}

<h1>Visit VOA!</h1>
<p>Tours of the VOA radio and television studios in Washington are available to the public. It's a fascinating look at the largest U.S. international broadcast operation.</p>

{/block}

{block name="body"}

<div class="row">
    <div class="col-md-4">
        <h2><a href="{$homepage}/about/">About the Tour</a></h2>
        <p><a href="{$homepage}/about/" class="teaser-img about-teaser"></a></p>
        <p>The Voice of America Studio Tour is a behind-the-scenes look at live broadcasting in radio, television, and the Internet in several of our more than 40 languages. Daily tours begin at noon and last 30-45 minutes.</p>
        <p><a class="btn btn-default" href="{$homepage}/about/" role="button">View details &raquo;</a></p>
    </div>
    <div class="col-md-4">
        <h2><a href="{$homepage}/what-to-bring/">What You Need to Bring</a></h2>
        <p><a href="{$homepage}/what-to-bring/" class="teaser-img whattobring-teaser"></a></p>
        <p>You will need to present a valid US federal or state-issued picture ID, such as a driver's license, passport or <span class="special-highlight">REAL ID compliant</span> state-issued ID. A non-US citizen is required to provide a passport. The building security guards cannot accept other documents nor waive these requirements. <span class="special-highlight">Starting May 3, 2023, any state-issued picture ID presented by a visitor to a federal facility (such as VOA) MUST be <a href="https://www.dhs.gov/real-id">REAL ID</a> compliant.</span></p>
        <p><a class="btn btn-default" href="{$homepage}/what-to-bring/" role="button">View details &raquo;</a></p>
    </div>
    <div class="col-md-4">
        <h2><a href="{$homepage}/directions/">Address &amp; Directions</a></h2>
        <p><a href="{$homepage}/directions/" class="teaser-img directions-teaser"></a></p>
        <p>VOA is located at 330 Independence Avenue, S.W., Washington, D.C. 20237. It is easily accessible by car, bus or subway.</p>
        <p><a class="btn btn-default" href="{$homepage}/directions/" role="button">View details &raquo;</a></p>
    </div>
</div>

{/block}
