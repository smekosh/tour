{function name=dayinfo}{strip}
{$allclasses = ["tdcell"]}
{$alltitles = "Available"}

{if $smarty.now|date_format:'Y-m-d' == $day|date_format:'Y-m-d'}
    {$allclasses[] = "today"}
    {$alltitles = "Today"}
{/if}

{if
    $day|date_format:"D" == "Sun" ||
    $day|date_format:"D" == "Sat" ||
    $day|date_format:"D" == "" ||
    $smarty.now > $day|strtotime
}
    {$allclasses[] = "nyet"}
    {$alltitles = "Unavailable"}
{else}
    {if isset($closed[$day])}
        {$allclasses[] = "full"}
        {$alltitles = "Unavailable"}
    {/if}
{/if}

{/strip}{if $want == "title"}{$alltitles}{else}{$allclasses|implode:" "}{/if}{/function}

{function name=render_calendar}
<div class="table reservation-calendar-reader-container" {if isset($month2)}style="display:none"{/if}>
    <table class="table table-bordered reservation-calendar-reader">
        <thead>
            <tr>
                <th class="tour-table-title">
{if isset($month1)}
    {$month1}
{else}
    <a href="#" title="See {$current->stamp|date_format:'F Y'}" class="navigate-user-calendar glyphicon glyphicon-circle-arrow-left"></a>
{/if}

                </th>
                <th colspan="5" class="tour-table-title">Noon Tour Availability</th>
                <th class="tour-table-title">
{if isset($month2)}
    {$month2}
{else}
    <a href="#" title="See {$next->stamp|date_format:'F Y'}" class="navigate-user-calendar glyphicon glyphicon-circle-arrow-right"></a>
{/if}

                </th>
            </tr>
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
                <td title="{dayinfo want='title' day=$day}" id="id_{$day|md5}" date="{$day}" class="{dayinfo want='classes' day=$day}{if $day@last} last-right{/if}{if $week@last} last-bottom{/if}">
                    <div class="cell-liner">
{if $day}
                        <div class="calendar-day">
                            <span class="calendar-day-label">{$day|date_format:"%#d"}</span>
                            {*<!-- <span class="calendar-day-label">{$day|date_format:"j"}</span> -->*}
                            <div class="clearfix"></div>
                        </div>
{/if}
                        <div class="clearfix"></div>
                </div>
                </td>
{/foreach}
            </tr>
{/foreach}
            <tr><th colspan="7" class="tour-table-title">Green indicates tour is open</th></tr>
        </tbody>
    </table>
</div>
{/function}

{render_calendar
    calendar=$calendar
    closed=$closed
    month1="Dec"
}
{render_calendar
    calendar=$calendar_next
    closed=$closed_next
    month2="Jan"
}
