{extends file="template.tpl"}

{block name="head"}

<link rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-ui-slider-pips.css">

{/block}

{block name="jumbotron"}

<h1>VOA Tour Reservations</h1>
<p>Tours of the VOA radio and television studios in Washington are available to the public. It's a fascinating look at the largest U.S. international broadcast operation.</p>

{/block}

{block name="body"}

{*<!--
<form role="form">
<div class="form-group">
<label for="exampleInputEmail1">Email address</label>
<input type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter email">
</div>
<div class="form-group">
<label for="exampleInputPassword1">Password</label>
<input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
</div>
<div class="form-group">
<label for="exampleInputFile">File input</label>
<input type="file" id="exampleInputFile">
<p class="help-block">Example block-level help text here.</p>
</div>
<div class="checkbox">
<label><input type="checkbox"> Check me out</label>
</div>
<button type="submit" class="btn btn-default">Submit</button>
</form>
-->*}

<form class="form" role="form">

    <div class="form-group clearfix">
        <label>How many people are in your group?</label>

        <div class="col-sm-12">
            <div id="groupSize"></div>
        </div>
    </div>

    <div class="form-group clearfix">
        <label>What day would you like to tour VOA?</label>

        <div class="row">
            <div class="col-sm-4">
                <div><input id="datetimepicker3" type="text" ></div>
            </div>

            <div class="col-sm-8">
                <div class="form-group form-group-lg">
                    <div class="col-sm-offset-2 col-sm-8">
                        <table class="table table-striped">
                            <tr>
                                <th>Date</th>
                                <th colspan="2">Tour 1</th>
                                <th colspan="2">Tour 2</th>
                            </tr>

                            <tr>
                                <td>Wednesday, August 20</td>
                                <td><label class="btn btn-success"><input type="radio" name="tour_id" value="20140820_1200_01"> 12 pm</label></td>
                                <td>12 spots left</td>
                                <td><label class="btn btn-success"><input type="radio" name="tour_id" value="20140820_1430_01"> 2:30 pm</label></td>
                                <td>18 spots left</td>
                            </tr>

                            <tr>
                                <td>Thursday, August 21</td>
                                <td><label class="btn btn-success"><input type="radio" name="tour_id" value="20140821_1200_01"> 12 pm</label></td>
                                <td>19 spots left</td>
                                <td><label class="btn btn-success"><input type="radio" name="tour_id" value="20140821_1430_01"> 2:30 pm</label></td>
                                <td>6 spots left</td>
                            </tr>

                            <tr>
                                <td>Friday, August 22</td>
                                <td><label class="btn btn-success"><input type="radio" name="tour_id" value="20140822_1200_01"> 12 pm</label></td>
                                <td>20 spots left</td>
                                <td><label class="btn btn-success"><input type="radio" name="tour_id" value="20140822_1430_01"> 2:30 pm</label></td>
                                <td>9 spots left</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {*<!--
    <div class="form-group form-group-lg">
    <label class="col-sm-2 control-label" for="first_name">Your first name:</label>
    <div class="col-sm-8">
    <input class="form-control" type="text" name="first_name" id="first_name" placeholder="Barack">
</div>
</div>

<div class="form-group form-group-lg">
<label class="col-sm-2 control-label" for="last_name">Your last name:</label>
<div class="col-sm-8">
<input class="form-control" type="text" name="last_name" id="last_name" placeholder="Obama">
</div>
</div>

<div class="form-group form-group-lg">
<label class="col-sm-2 control-label" for="email_address">Your email address:</label>
<div class="col-sm-8">
<input class="form-control" type="email" name="email_address" id="email_address" placeholder="you@example.com">
</div>
</div>

<div class="form-group form-group-lg">
<label class="col-sm-2 control-label" for="visitor_count">Group size:</label>
<div class="col-sm-8">
<select class="form-control">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
<option value="group">More than 20</option>
</select>
</div>
</div>
-->*}

</form>

{/block}
