{extends file="index.tpl"}

{block name="jumbotron"}

<h1>Admin Panel</h1>

{/block}

{block name="body"}

{foreach from=$data item=day}
<pre>{$day|print_r}</pre>
{/foreach}

{/block}
