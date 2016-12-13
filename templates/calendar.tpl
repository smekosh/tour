<style>
td.nyet { background-color: crimson }
td.closed { background-color: crimson }
td.today { font-weight: bold}
table.reservation-calendar td { padding: 4px !important }
</style>

<div style="float:right">

    <div class="table">
    <table class="table table-bordered reservation-calendar">
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
                <td {if isset($closed[$day]) || $day|date_format:"D" == "Sun" || $day|date_format:"D" == "Sat" || $day == ""}title="Unavailable"{/if} id="id_{$day|md5}" date="{$day}" class="tdcell {if $smarty.now|date_format:'Y-m-d' == $day|date_format:'Y-m-d'}today {/if} {if $day|date_format:"D" == "Sun" || $day|date_format:"D" == "Sat" || $day == ""}nyet{/if} {if isset($closed[$day])}closed{/if} {if $day@last}last-right{/if}  {if $week@last}last-bottom{/if} {if !isset($reservations[$day])}empty{else}full{/if}">
                    <div class="cell-liner">
    {if $day}
                        <div class="calendar-day">
                            <span class="calendar-day-label">{$day|date_format:"%#d"}</span>
                            <div class="clearfix"></div>
                        </div>
    {/if}

                        <div class="clearfix"></div>
                </div>
                </td>
        {/foreach}
            </tr>
    {/foreach}
        </tbody>
    </table>


    </div>
</div>
