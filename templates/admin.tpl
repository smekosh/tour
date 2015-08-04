{extends file="index.tpl"}

{block name="footer"}
<script>
function edit(that) {
    // if clicked outside, remove previous hints
    $("td.should_close .confirm").not("self").remove();
    $("td").not(".nyet").not(that).removeClass("should_close");


    if( $(that).hasClass("should_close") ) {
        // confirm action
        $(".confirm", $(that)).remove();
        $(that).removeClass("should_close");

        var day = $(that).attr("date");
        var closed = $(that).hasClass("closed");

        $.ajax({
            type: "POST",
            url: "{$homepage}/admin/update",
            data: {
                day: day,
                closed: (closed ? "yes" : "no")
            },
            dataType: "json",
            success: function(data) {
                // make sure to update the correct day
                var parent = $("td[date='" + data.visit_day + "']");

                if( data.is_closed == "yes") {
                    parent.addClass("closed");
                    $(parent).append('<div class="tour_closed_notice">Tour closed</div>');
                } else {
                    parent.removeClass("closed");
                    $(".tour_closed_notice", parent).remove();
                }
                console.dir(data);
            },
            error: function(e) {
                $(that).html("ERROR updating day; please reload this page");
            }
        })

    } else {
        // offer to confirm action
        $(that).addClass("should_close");

        if( $(that).hasClass("closed") ) {
            $(that).append("<div class='confirm btn-info'>Click again to confirm opening day</div>");
        } else {
            $(that).append("<div class='confirm btn-info'>Click again to confirm closing day</div>");
        }
    }
}

$("td").not(".nyet").mouseover(function() {
    $(this).addClass("mout");
}).mouseout(function() {
    $(this).removeClass("mout");
}).click(function() {
    edit(this);
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
    height: 40px;
    text-align: center;
    width: 40px;
}
.jumbotron h1 a { color: black; }
.closed { background-color: crimson; }
.mout { background-color: wheat; cursor: pointer; }
.should_close { font-weight: bold; }
.friendly_month { float: right; color: silver; }
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
        <td date="{$day}" class="{if $day|date_format:"D" == "Sun" || $day|date_format:"D" == "Sat" || $day == ""}nyet{/if} {if isset($closed[$day])}closed{/if}">
            <p>{$day|date_format:"%#d"}</p>
{if isset($reserved[$day])}
<div class="visitor_count">{$reserved[$day].count}</div>
{/if}

{if isset($closed[$day])}
    <div class="tour_closed_notice">Tour closed</div>
{/if}

        </td>
    {/foreach}
</tr>
{/foreach}
</tbody>
</table>

</div>

{/block}
