{extends file="index.tpl"}

{block name="jumbotron"}

<h1>Directions</h1>

<p><a href="{$homepage}/visit/" class="btn btn-primary btn-lg" role="button">Take the Tour &raquo;</a></p>

{/block}

{block name="body"}

<div class="row">

	<div class="col-md-4">

		<h3>Where We Are</h3>

		<p>330 Independence Ave., S.W.<br />Washington, D.C. 20237</p>


		<h3>Entrance</h3>

		<p>Please make sure to enter through the <strong>Independence Avenue entrance</strong>. These doors are only open for the 12:00 p.m. daily public tour.</p>

		<p>Private tour groups are asked to come in through the <strong>C Street entrance</strong>.</p>


		<h3>Parking</h3>

		<p>Public lots are located nearby.</p>


		<h3>Closest Metro Stations</h3>

		<h4>Federal Center Southwest Metro<br /><small>(<span style="color:#0a94d6; font-weight:bold;">Blue</span>, <span style="color:#de8703; font-weight:bold;">Orange</span> &amp; <span style="color:#a1a3a1; font-weight:bold;">Silver</span> lines)</small></h4>
        <ul>
            <li>Exit onto 3rd Street, turn left and walk two blocks along 3rd Street to Independence Avenue.</li>
            <li>Turn left onto Independence.</li>
            <li>VOA&apos;s entrance is in the middle of the block, between 3rd and 4th Streets.</li>
        </ul>
		
		<h4>L'Enfant Plaza Metro<br /><small>(<span style="color:#f7d417; font-weight:bold;">Yellow</span>, <span style="color:#00b052; font-weight:bold;">Green</span>, <span style="color:#0a94d6; font-weight:bold;">Blue</span>, <span style="color:#de8703; font-weight:bold;">Orange</span> &amp; <span style="color:#a1a3a1; font-weight:bold;">Silver</span> lines)</small></h4>
        <ul>
            <li>Take the 7th Street/Maryland Ave. exit and walk east to VOA's entrance on Independence </li>
            <li>Avenue, between 3rd and 4th Streets.</li>
        </ul>

	</div>

	<div class="col-md-8">

		{include file="map.tpl"}

	</div>

</div>


{/block}
