{*
    due to akamai caching, this navigation calendar is now generate through a POST
*}
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