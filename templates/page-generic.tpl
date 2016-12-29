{extends file="index.tpl"}

{block name="jumbotron"}
<h1>{$doc->title}</h1>
{$doc->teaser_html}
{/block}

{block name="body"}

{if $doc->columns == 3}
<div class="row">
    <div class="col-md-4">
        {$doc->content[0]->html}
    </div>
    <div class="col-md-4">
        {$doc->content[1]->html}
    </div>
    <div class="col-md-4">
        {$doc->content[2]->html}
    </div>
</div>
{/if}

{if $doc->columns == 2}
<div class="row">
	<div class="col-md-4">
        {$doc->content[0]->html}
	</div>
	<div class="col-md-8">
        {$doc->content[1]->html}
	</div>
</div>
{/if}

{if $doc->columns == 1}
<div class="row">
    <div class="col-md-8">
        {$doc->content[0]->html}
    </div>
</div>
{/if}

{*<!--
<pre>{capture assign=bla}{$doc|print_r}{/capture}{$bla|escape:"htmlall"}</pre>
-->*}


{/block}
