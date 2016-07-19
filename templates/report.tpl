{extends file="index.tpl"}

{block name="footer"}
{/block}

{block name="head"}
{include file="admin-css.tpl"}

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
    <a class="spreadsheet" href="{$homepage}/admin/report/{$current->year}/{$current->month}/excel/">Export to Excel</a>
    <span class="friendly_month">{$current->stamp|date_format:"F Y"}</span>
</h1>

<div class="table">
{include file="report-table.tpl"}
</div>

{/block}
