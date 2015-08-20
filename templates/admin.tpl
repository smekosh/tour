{extends file="index.tpl"}

{block name="footer"}
<script>

$("td").not(".nyet").mouseover(function() {
    $(this).addClass("mout");
}).mouseout(function() {
    $("td.should_close a").text("Close Day?");
    $("td.should_close").removeClass("should_close");
    $(this).removeClass("mout");
});

function buttons_disabled(state) {
    $("#modal_open_close_day_opened_closed_cancel_button").attr("disabled", state);
    $("#modal_open_close_day_opened_closed_save_button").attr("disabled", state);

    $("#modal_open_close_day_opened").attr("disabled", state);
    $("#modal_open_close_day_closed").attr("disabled", state);
}

function getCell(cell_id) {
    var parent_cell = $("td#" + cell_id);

    return({
        cell: parent_cell,
        date: parent_cell.attr("date"),
        closed: parent_cell.hasClass("closed")
    });
}

// activate modal
$("a.modal-trigger-openclose").click(function(e) {
    e.preventDefault();
    var cell_id = $(this).attr("cell-id");
    var cell = getCell( cell_id );

    $("#modal_open_close_day").html(cell.date);

    if( cell.closed ) {
        $("#modal_open_close_day_closed").prop("checked", true);
        $("#modal_open_close_status").html("Closed");
    } else {
        $("#modal_open_close_day_opened").prop("checked", true);
        $("#modal_open_close_status").html("Opened");
    }

    $("#status_message").removeClass("bg-danger");
    $("#status_message").html("");

    $("#modal_open_close_day_opened_closed_save_button").attr("cell-id", cell_id);

    buttons_disabled(false);
    $("#modal_open_close").modal("show");
});

// save changes to modal options
$("#modal_open_close_day_opened_closed_save_button").click(function(e) {
    e.preventDefault();

    buttons_disabled(true);

    var cell_id = $(this).attr("cell-id");
    var cell = getCell(cell_id);
    var should_be_opened = $("#modal_open_close_day_opened").prop("checked");

    $.ajax({
        type: "POST",
        url: "{$homepage}/admin/update",
        data: {
            day: cell.date,
            closed: (should_be_opened ? "yes" : "no")
        },
        dataType: "json",
        success: function(data) {

            // make sure to update the correct day
            var parent = $("td[date='" + data.visit_day + "']");

            if( data.is_closed == "yes") {
                parent.addClass("closed");
                $(".cell-liner", parent).append('<div class="tour_closed_notice">Tour closed</div>');
            } else {
                parent.removeClass("closed");
                $(".tour_closed_notice", parent).remove();
            }

            $("#modal_open_close").modal("hide");
        },
        error: function(e) {
            $("#status_message").addClass("bg-danger");
            $("#status_message").html(
                "ERROR updating day; please reload this page. If this problem persists, contact administrators for support."
            );
            buttons_disabled(false);
        }
    })

});

</script>
{/block}

{block name="head"}
<style type="text/css">
td { height: 7em; width: 14.285% }
.nyet { background-color: silver; }
.visitor_count {
    background-color: black;
    border: 3px solid black;
    border-radius: 20px;
    color: white;
    font-size: 24px;
    text-align: center;
    width: 40px;
    height: 40px;
    float: left;
}
td { padding:0px !important }
.cell-liner {
    border:2px solid white;
    width: 100%;
    height:7em;
}
.nyet .cell-liner { border: 2px solid silver }
.jumbotron h1 a { color: black; }
.mout { background-color: wheat; }
.mout .cell-liner { border: 2px solid black }
.closed { background-color: crimson; }
.mousemenu {
    position: absolute;
    width:14.285%;
    height:1em;
    margin-top:5em;
}
.mousemenu { display: none }
.mout .mousemenu { display: block }
.should_close a { font-weight: bold; }
.friendly_month { float: right; color: silver; }
.modal label { cursor: pointer }
</style>
{/block}

{block name="jumbotron"}

<h1><a href="{$homepage}/admin/" title="Go to this month">Admin Panel</a></h1>

{/block}

{block name="body"}

<h1>
    <a href="{$homepage}/admin/{$prev->year}/{$prev->month}/">&lt;</a></span>
    {$current->year}/{$current->month}
    <a href="{$homepage}/admin/{$next->year}/{$next->month}/">&gt;</a>
    <span class="friendly_month">{$current->stamp|date_format:"F Y"}</span>
</h1>

<div class="table">
<table class="table table-bordered">
    <thead>
        <th>Sun</th>
        <th>Mon</th>
        <th>Tue</th>
        <th>Wed</th>
        <th>Thu</th>
        <th>Fri</th>
        <th>Sat</th>
    </thead>

    <tbody>
{foreach from=$calendar item=week}
<tr>
    {foreach from=$week item=day}
        <td id="id_{$day|md5}" date="{$day}" class="tdcell {if $day|date_format:"D" == "Sun" || $day|date_format:"D" == "Sat" || $day == ""}nyet{/if} {if isset($closed[$day])}closed{/if}">
            <div class="cell-liner">
                <div class="mousemenu">
{if isset($closed[$day])}
                    <a class="modal-trigger-openclose" cell-id="id_{$day|md5}" href="#">Open Day?</a>
{else}
                    <a class="modal-trigger-openclose" cell-id="id_{$day|md5}" href="#">Close Day?</a>
{/if}
                </div>

                <p>{$day|date_format:"%#d"}</p>
{if isset($reservations[$day])}
                <div class="visitor_count">{$reservations[$day]}</div>
{/if}

{if isset($closed[$day])}
                <div class="tour_closed_notice">Tour closed</div>
{/if}
            </div>
        </td>
    {/foreach}
</tr>
{/foreach}
</tbody>
</table>

</div>

<div class="modal fade" id="modal_open_close">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Change Day</h4>
            </div>
            <div class="modal-body">
                <p>Day <span id="modal_open_close_day"></span> is currently set to <span id="modal_open_close_status"></span>.</p>
                <p>Please choose one of the two options:</p>
                <div>
                    <input id="modal_open_close_day_opened" type="radio" name="modal_open_close_day_opened_closed_radio" />
                    <label for="modal_open_close_day_opened">Opened (allows form scheduling)</label>
                </div>

                <div>
                    <input id="modal_open_close_day_closed" type="radio" name="modal_open_close_day_opened_closed_radio" />
                    <label for="modal_open_close_day_closed">Closed (disables form scheduling for the day)</label>
                </div>

                <div id="status_message"></div>
            </div>
            <div class="modal-footer">
                <button id="modal_open_close_day_opened_closed_cancel_button" type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button id="modal_open_close_day_opened_closed_save_button" type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

{/block}
