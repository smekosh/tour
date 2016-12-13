{extends file="index.tpl"}

{block name="jumbotron"}

<h1>Directions</h1>

{/block}

{block name="body"}

<div class="row">

	<div class="col-md-4">

		<h3>Where We Are</h3>

		<p>330 Independence Ave., S.W.<br />Washington, D.C. 20237</p>


		<h3>Where to Enter</h3>

		<p>Please enter the building through the entrance on C Street.  C Street is on the opposite side of the building from Independence Avenue between 3rd and 4th Streets.  Tours begin in the lobby of the C Street entrance.</p>

		<h3>Where to Park</h3>

		<p>Public lots are located nearby.</p>


		<h3>Closest Metro Stations</h3>

		<h4>Federal Center Southwest Metrorail<br />
			<small>(<span style="color:#0a94d6; font-weight:bold;">Blue</span>, <span style="color:#de8703; font-weight:bold;">Orange</span> &amp; <span style="color:#a1a3a1; font-weight:bold;">Silver</span> lines)</small>
		</h4>
        <ul>
            <li>Exit onto 3rd Street, turn left and walk one block along 3rd Street to the corner of 3rd and C Streets.</li>
            <li>Cross C Street to the building with the parking lot in front; turn left.</li>
            <li>VOA's entrance is in the middle of the block, between 3rd and 4th Streets.</li>
        </ul>

		<h4>L'Enfant Plaza Metrorail<br />
			<small>(<span style="color:#f7d417; font-weight:bold;">Yellow</span>, <span style="color:#00b052; font-weight:bold;">Green</span>, <span style="color:#0a94d6; font-weight:bold;">Blue</span>, <span style="color:#de8703; font-weight:bold;">Orange</span> &amp; <span style="color:#a1a3a1; font-weight:bold;">Silver</span> lines)</small></h4>
        <ul>
			<li>Take the 7th Street/Maryland Ave. exit and walk east to the corner of 4th Street and Independence Avenue. </li>
			<li>Cross 4th Street and turn right and walk one block to the corner of 4th and C Streets.</li>
			<li>Turn left and walk down C Street toward 3rd Street.</li>
			<li>VOA’s entrance is in the middle of the block between 3rd and 4th Streets.</li>
    	</ul>

	</div>

	<div class="col-md-8">

		{include file="map.tpl"}

	</div>

</div>


{/block}
