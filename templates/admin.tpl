{extends file="index.tpl"}

{block name="head"}
<style type="text/css">
td { height: 8em}
.nyet { background-color: silver }
.visitor_count { border-radius:3em; border:3px solid silver}
</style>
{/block}

{block name="jumbotron"}

<h1>Admin Panel</h1>

{/block}

{block name="body"}

<h1>
    <a href="?month=may">&lt;</a></span>
    June 2015
    <a href="?month=july">&gt;</a></h1>

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
        <td class="{if $day|date_format:"D" == "Sun" || $day|date_format:"D" == "Sat" || $day == ""}nyet{/if}">
            <p>{$day|date_format:"%#d"}</p>
{if isset($reserved[$day])}
<div class="visitor_count">{$reserved[$day].count}</div>
{/if}
        </td>
    {/foreach}
</tr>
{/foreach}
</tbody>
</table>

</div>

{/block}
