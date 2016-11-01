
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
		    Yes, daily tour at <strong>noon</strong> (12 PM).
		  </label>
		</div>
		<div class="radio">
		  <label>
		    <input type="radio" name="tourType" id="tourType2" value="Special">
		    Requesting a special tour outside of normal hours
		  </label>
		</div>

		<p id="why-disabled" style="display:none">
			To arrange special group tours, please email us at <a href="mailto:PublicRelations@voanews.com">PublicRelations@voanews.com</a>.
		</p>
	</div>

</div><!-- end .visible-xs-block -->
