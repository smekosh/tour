
{function name=es1}
{if isset($excel)}style="background-color:silver"{/if}
{/function}

<table class="table table-bordered report admin-table">
    <thead>
        <tr>
            <th {es1} rowspan="2">Date</th>
            <th {es1} rowspan="2">Day</th>
            <th {es1} colspan="2" class="ctr">Daily</th>
            <th {es1} colspan="2" class="ctr">Special</th>
            <th {es1} rowspan="2" class="subr">Total Count</th>
            <th {es1} rowspan="2">Closed?</th>
        </tr>
        <tr>
            <th {es1} class="subr">Groups</th>
            <th {es1} class="subr">Individuals</th>
            <th {es1} class="subr">Groups</th>
            <th {es1} class="subr">Individuals</th>
        </tr>
    </thead>

    <tbody>
{foreach from=$calendar item=week}
{foreach from=$week key=key item=day}
{if $day}
        <tr class="{cycle values='odd,even'}">
            <td class="date">{$day}</td>
            <td class="day">{$day|date_format:"l"}</td>
{if isset($reservations[$day])}
            <td class="num">{$reservations[$day].Daily_Groups}</td>
            <td class="num">{$reservations[$day].Daily}</td>
            <td class="num">{$reservations[$day].Special_Groups}</td>
            <td class="num">{$reservations[$day].Special}</td>
            <td class="num tot">{$reservations[$day].Total}</td>
{else}
            <td class="num"></td>
            <td class="num"></td>
            <td class="num"></td>
            <td class="num"></td>
            <td class="num tot"></td>
{/if}

            <td>{if isset($closed[$day])}Closed{/if}</td>
        </tr>
{/if}
{/foreach}
{/foreach}
        <tr class="repeated-header">
            <th {es1} rowspan="2"></th>
            <th {es1} rowspan="2"></th>
            <th {es1} colspan="2" class="ctr">Daily</th>
            <th {es1} colspan="2" class="ctr">Special</th>
            <th {es1} rowspan="2" class="subr">Total Count</th>
            <th {es1} rowspan="2"></th>
        </tr>
        <tr class="repeated-header">
            <th {es1} class="subr">Groups</th>
            <th {es1} class="subr">Individuals</th>
            <th {es1} class="subr">Groups</th>
            <th {es1} class="subr">Individuals</th>
        </tr>
        <tr>
            <td {es1} colspan="2">Totals</td>
            <td {es1} class="num">{$totals.Daily_Groups}</td>
            <td {es1} class="num">{$totals.Daily}</td>
            <td {es1} class="num">{$totals.Special_Groups}</td>
            <td {es1} class="num">{$totals.Special}</td>
            <td {es1} class="num">{$totals.Total}</td>
            <td {es1} class="num"></td>
        </tr>
    </tbody>
</table>
