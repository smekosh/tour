{extends file="index.tpl"}

{block name="calendar"}{/block}

{block name="footer"}
<script>

var days = {$reservations|json_encode};

function refresh_mout(node, override) {
    if( typeof override === "string" ) {
        $(".mousemenu a", node).text(override);
        return( false );
    }

    if( $(node).hasClass("error-updating") ) return( false );

    var new_text = "Close Day?";
    if( $(node).hasClass("closed") ) new_text = "Open Day?";

    $(".mousemenu a", node).text(new_text);
}

$("td").not(".nyet").mouseover(function() {
    $(this).addClass("mout");
    refresh_mout(this);
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

            refresh_mout(parent);
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

$(".modal-trigger-details").click( function(e) {
    e.preventDefault();

    var day = $(this).attr("day");
    var data = days[day];

    var html = "<table class='details' border='1'>";
    html += "<thead><tr><th>Reservation #</th><th>Daily</th><th>Special</th></tr></thead><tbody>";

    for( var i = 0; i < data.Details.length; i++ )(function(row, i) {
        html += "<tr><td class='details_num'><span>" + (i + 1) + "</span></td>";
        if( row.type_of_tour === "Daily" ) {
            html += "<td class='details_daily'>" + row.num_visitors + "</td><td></td>";
        } else {
            html += "<td></td><td class='details_special'>" + row.num_visitors + "</td>";
        }
        html += "</tr>";
    })(data.Details[i], i);
    html += "<tr><td class='total_cl'>Total:</td>";
    html += "<td class='total_cl'>" + data.Daily + "</td>";
    html += "<td class='total_cl'>" + data.Special + "</td>";
    html += "</tbody></table>";

    html += "<h4>Total Individuals: " + data.Total + "<h4>";
    $("#modal_details_body").html(html);
    $("#modal_details_day").html(day);
    $("#modal_details").modal("show");
});

// 2020-12-09 shortcuts for mass edits

function get_hovered_target() {
    var res = $("td.mout");
    if( res.length !== 1 ) return( false );
    return( res.attr("date") );
}

function close_day_save_fast( intended_date, should_be_opened ) {
    $.ajax({
        type: "POST",
        url: "{$homepage}/admin/update",
        data: {
            day: intended_date,
            closed: (should_be_opened ? "yes" : "no")
        },
        dataType: "json",
        success: function(data) {
            // make sure to update the correct day
            var parent = $("td[date='" + data.visit_day + "']");

            // reset visual
            $(".tour_closed_notice", parent).remove();
            parent.removeClass("closed");

            if( data.is_closed == "yes") {
                parent.addClass("closed");
                $(".calendar-day-label", parent).after('<span class="tour_closed_notice">Tour closed</span>');
            }

            // console.info(parent);
            refresh_mout(parent);
        },
        error: function(e) {
            var parent = $("td[date='" + intended_date + "']");
            parent.addClass("error-updating");
            refresh_mout(parent, "Error updating");
        }
    });
}

document.addEventListener("keydown", event => {

    if( event.key === "Escape" ) {
        $("#modal_open_close").modal("hide");
        event.preventDefault();
    }

    if( event.key === "1" ) {
        var payload = get_hovered_target();
        if( payload === false ) return( false );

        close_day_save_fast( payload, true );
        event.preventDefault();
    }
        
    if( event.key === "2" ) {
        var payload = get_hovered_target();
        if( payload === false ) return( false );

        close_day_save_fast( payload, false );
        event.preventDefault();
    }
});


</script>
{/block}

{block name="head"}
{include file="admin-css.tpl"}
{*<!--
<link rel="prefetch" href="{$homepage}/admin/{$prev->year}/{$prev->month}/" />
<link rel="prefetch" href="{$homepage}/admin/{$next->year}/{$next->month}/" />
-->*}
{/block}

{block name="jumbotron"}
{include file="admin-menu.tpl"}
{/block}

{block name="body"}

<h1>
    <a href="{$homepage}/admin/{$prev->year}/{$prev->month}/">&lt;</a></span>
    {$current->year}/{$current->month}
    <a href="{$homepage}/admin/{$next->year}/{$next->month}/">&gt;</a>
    <span class="friendly_month">{$current->stamp|date_format:"F Y"}</span>
</h1>

<div class="table">
<table class="table table-bordered reservation-calendar admin-table">
    <thead>
        <tr>
            <th>Sun</th>
            <th>Mon</th>
            <th>Tue</th>
            <th>Wed</th>
            <th>Thu</th>
            <th>Fri</th>
            <th>Sat</th>
        </tr>
    </thead>

    <tbody>
{foreach from=$calendar item=week}
        <tr>
    {foreach from=$week item=day}
            <td id="id_{$day|md5}" date="{$day}" class="tdcell {if $day|date_format:"D" == "Sun" || $day|date_format:"D" == "Sat" || $day == ""}nyet{/if} {if isset($closed[$day])}closed{/if} {if $day@last}last-right{/if}  {if $week@last}last-bottom{/if} {if !isset($reservations[$day])}empty{else}full{/if}">
                <div class="cell-liner">
{if $day}
                    <div class="calendar-day">
                        <span class="calendar-day-label">{$day|date_format:"%#d"}</span>
{if isset($closed[$day])}
                        <span class="tour_closed_notice">Tour closed</span>
{/if}
                        <div class="clearfix"></div>
                    </div>
{/if}

{if isset($reservations[$day])}
                    <ul class="visitor_count_breakdowns" >
                        <li>Daily: {$reservations[$day].Daily}</li>
                        <li>Special: {$reservations[$day].Special}</li>
                        <li class="total">Total: {$reservations[$day].Total}</li>
                    </ul>
{/if}
                    <div class="clearfix"></div>

                    <div class="mousemenu">
{if isset($reservations[$day])}
    <a class="modal-trigger-details" day="{$day}" href="#">Details</a>
{/if}
{if isset($closed[$day])}
    <a class="modal-trigger-openclose" cell-id="id_{$day|md5}" href="#">Open Day?</a>
{else}
    <a class="modal-trigger-openclose" cell-id="id_{$day|md5}" href="#">Close Day?</a>
{/if}
                    </div>
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

<div class="modal fade" id="modal_details">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Details for <span id="modal_details_day"></span></h4>
            </div>
            <div class="modal-body" id="modal_details_body">
            </div>
            <div class="modal-footer">
                <button id="modal_details_close" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<p>Advanced user shortcuts - hover mouse over a calendar day and press keys 1 or 2 on keyboard to quickly open / close.</p>
<p>1 - Opens the day.</p>
<p>2 - Closes the day.</p>

{/block}
