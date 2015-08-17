
<div class="">

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
