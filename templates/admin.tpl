{extends file="index.tpl"}

{block name="jumbotron"}

<h1>Admin Panel</h1>

{/block}

{block name="body"}

<div class="panel">
<table border="1">
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
        <td>{$day}</td>
    {/foreach}
</tr>
{/foreach}
</tbody>
</table>

{foreach from=$data item=day}
<pre>{$day|print_r}</pre>
{/foreach}
</div>

{/block}
