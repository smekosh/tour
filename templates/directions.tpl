{extends file="index.tpl"}

{block name="jumbotron"}

<h1>Directions</h1>

<p><a href="{$homepage}/visit/" class="btn btn-primary btn-lg" role="button">Take the Tour &raquo;</a></p>

{/block}

{block name="body"}

<h4>Where We Are</h4>

<ul>
    <li>Address: 330 Independence Ave., S.W.</li>
    <li>Washington, D.C. 20237</li>
</ul>

{include file="map.tpl"}

<h4>Closest Metro Stations:</h4>

<ul>
    <li>
        <p><strong>Federal Center Southwest Metro</strong> (Blue, Orange & Silver lines)</p>
        <ul>
            <li>Exit onto 3rd Street, turn left and walk two blocks along 3rd Street to Independence Avenue.</li>
            <li>Turn left onto Independence.</li>
            <li>VOA&apos;s entrance is in the middle of the block, between 3rd and 4th Streets.</li>
        </ul>
    </li>
    <li>
        <p><strong>L'Enfant Plaza Metro</strong> (Yellow, Green, Blue, Orange & Silver lines)</p>
        <ul>
            <li>Take the 7th Street/Maryland Ave. exit and walk east to VOA's entrance on Independence </li>
            <li>Avenue, between 3rd and 4th Streets.</li>
        </ul>
    </li>
</ul>


<h4>Entrance</h4>

<p>Please make sure to enter through the <strong>Independence Avenue entrance</strong>. These doors are only open for the 12:00 p.m. daily public tour.</p>

<p>Private tour groups are asked to come in through the <strong>C Street entrance</strong>.</p>

<h4>Parking:</h4>

<p>Public lots are located nearby.</p>


{/block}
