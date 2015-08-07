
<div class="visible-xs-block">

	<div class="form-group">
		<label for="groupSizeMobile">How many visitors are in your group?</label>
		<select id="groupSizeMobile" class="form-control">
			{for $num=1 to 20}<option>{$num}</option>{/for}
		</select>
		<p class="help-block">Number includes yourself.</p>
	</div>


	<div class="form-group">
		<label>Are you taking a daily tour?</label>

		<div class="radio">
		  <label>
		    <input type="radio" name="tourType" id="tourType1" value="Daily" checked>
		    Daily tour at noon
		  </label>
		</div>
		<div class="radio">
		  <label>
		    <input type="radio" name="tourType" id="tourType2" value="Special">
		    Requesting a special tour outside of normal hours
		  </label>
		</div>
	</div>

</div><!-- end .visible-xs-block -->




<div class="hidden-xs">

	<h4>How many visitors are in your group?</h4>

	<p>Number includes yourself. Click and drag the slider below to adjust.</p>

	<div id="groupSize"></div>
	<p>&nbsp;</p>


	<h4>Are you taking a daily tour?</h4>

	<p>Daily tours are every weekday at <strong>noon</strong>, Monday through Friday except for Holidays.</p>

	<div class="btn-group" role="group">
	    <button type="button" data-type="Daily" class="btn btn-default tour_type">Daily tour at noon</button>
	    <button type="button" data-type="Special" class="btn btn-default tour_type">Requesting a special tour outside of normal hours</button>
	</div>

</div><!-- end .hidden-xs -->