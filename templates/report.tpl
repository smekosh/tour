{extends file="index.tpl"}

{block name="footer"}
{/block}

{block name="head"}
{include file="admin-css.tpl"}
<style type="text/css">
.report { /*max-width: 900px*/ }
.report td { padding: 0.5em !important; height:inherit !important }
td.date {  }
td.num { text-align: right }
.ctr { text-align: center }
.subr { text-align: right }
tr.even { background-color: rgba(100,100,100,0.1); }
.odd .tot { font-weight: bold !important; background-color: rgba(100,100,100,0.1) !important; }
.even .tot { font-weight: bold !important; background-color: rgba(100,100,100,0.1) !important; }
</style>

{*<!--
<link rel="prefetch" href="{$homepage}/report/{$prev->year}/{$prev->month}/" />
<link rel="prefetch" href="{$homepage}/report/{$next->year}/{$next->month}/" />
-->*}
{/block}

{block name="jumbotron"}
{include file="admin-menu.tpl"}
{/block}

{block name="body"}

<h1>
    <a href="{$homepage}/admin/report/{$prev->year}/{$prev->month}/">&lt;</a></span>
    {$current->year}/{$current->month}
    <a href="{$homepage}/admin/report/{$next->year}/{$next->month}/">&gt;</a>
    <span class="friendly_month">{$current->stamp|date_format:"F Y"}</span>
</h1>

<div class="table">
<table class="table table-bordered report">
    <thead>
        <tr>
            <th rowspan="2">Date</th>
            <th rowspan="2">Day</th>
            <th colspan="2" class="ctr">Daily</th>
            <th colspan="2" class="ctr">Special</th>
            <th rowspan="2" class="subr">Total Count</th>
            <th rowspan="2">Closed?</th>
        </tr>
        <tr>
            <th class="subr">Groups</th>
            <th class="subr">Individuals</th>
            <th class="subr">Groups</th>
            <th class="subr">Individuals</th>
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
            <th rowspan="2"></th>
            <th rowspan="2"></th>
            <th colspan="2" class="ctr">Daily</th>
            <th colspan="2" class="ctr">Special</th>
            <th rowspan="2" class="subr">Total Count</th>
            <th rowspan="2"></th>
        </tr>
        <tr class="repeated-header">
            <th class="subr">Groups</th>
            <th class="subr">Individuals</th>
            <th class="subr">Groups</th>
            <th class="subr">Individuals</th>
        </tr>
        <tr>
            <td colspan="2">Totals</td>
            <td class="num">{$totals.Daily_Groups}</td>
            <td class="num">{$totals.Daily}</td>
            <td class="num">{$totals.Special_Groups}</td>
            <td class="num">{$totals.Special}</td>
            <td class="num">{$totals.Total}</td>
        </tr>
    </tbody>
</table>

</div>

{/block}
