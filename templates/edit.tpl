{extends file="index.tpl"}

{block name="calendar"}{/block}

{block name="head"}
{include file="admin-css.tpl"}

{*<!--<link href="{$homepage}/css/trix.css" rel="stylesheet" />-->*}
<script src="{$homepage}/js/markdown-it.min.js"></script>

<style type="text/css">
stuff { display: flex; align-items: stretch; }
editor {
    margin-right: 1em;
    width: 40%;
    padding-right: 1em;
}
preview {
    margin-left: 1em;
    width: 60%;
    word-wrap: break-word;
}
stuff.top {
    padding-bottom:1em;
}
editor textarea { width: 100%; resize:vertical; }
textarea.content { min-height: 500px; font-family: Courier New; }

.table-edit-list td { width: 45% }
.table-edit-list td:last-child { width: 10% }
.table-edit-header td { width: 20% }
.table-edit-header td:last-child { width: 80% }
.table-edit-header td:last-child input { width: 100% }

.explain {
    background-color: #0074D9;
    color: white;
    padding:1em;
}

.divider {
    padding-top:1em;
    margin-top:1em;
    border-top:1em solid silver;
    padding-bottom:1em;
    margin-bottom:1em;
}
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

{if isset($overview)}
<h4>Pages</h4>
<table class="table table-bordered table-striped table-hover table-edit-list">
    <thead>
        <tr>
            <th>Title</th>
            <th>Slug</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
{foreach from=$copy->pages key=slug item=page}
{if $page->status != "draft"}
        <tr>
            <td>{$page->title}</td>
            <td>{$slug}</td>
            <td><a href="{$homepage}/admin/edit/{$slug|replace:'/':'_'}">Edit</a></td>
        </tr>
{/if}
{/foreach}
    </tbody>
</table>

<a href="{$homepage}/admin/edit/new">Add new page</a>

{else}

<prestuff>
    <form class="form-horizontal">
        <div class="form-group">
            <label for="page-title" class="col-sm-2 control-label">Title</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="page-title" name="page-title" autocomplete="off" value="{$edit_page->title|escape:htmlall}" />
            </div>
        </div>
        <div class="form-group">
            <label for="page-slug" class="col-sm-2 control-label">Slug</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="page-slug" name="page_slug" autocomplete="off" value="{$edit_slug}" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Status</label>
            <div class="row">
                <div class="col-sm-2">
                    <div class="radio">
                        <label>
                            <input type="radio" name="page-status" value="published" {if $edit_page->status == "published"}checked{/if} />
                            Published
                        </label>
                    </div>
                    <div class="radio">
                        <label>
                            <input type="radio" name="page-status" value="draft" {if $edit_page->status == "draft"}checked{/if} />
                            Draft
                        </label>
                    </div>
                </div>
                <div class="col-sm-4">

                    <label class="col-sm-2 control-label" style="margin-right:2em">Columns</label>

                    <div class="btn-group" role="group">
                        <button type="button" data-column="1" class="btn btn-default btn-column-selector {if $edit_page->columns == 1}active{/if}" data-show=".stuff_1"                     data-hide=".stuff_2, .stuff_3">1</button>
                        <button type="button" data-column="2" class="btn btn-default btn-column-selector {if $edit_page->columns == 2}active{/if}" data-show=".stuff_1, .stuff_2"           data-hide=".stuff_3">2</button>
                        <button type="button" data-column="3" class="btn btn-default btn-column-selector {if $edit_page->columns == 3}active{/if}" data-show=".stuff_1, .stuff_2, .stuff_3"  data-hide="">3</button>
                    </div>

                </div>
                <div class="col-sm-3">
                    <div class="pull-right">
                        <input id="b_s" type="button" class="btn btn-default" value="Save" />
                        <input id="b_p" type="button" class="btn btn-default" value="Preview Full Page" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</prestuff>

<stuff class="top">
    <editor>
        <h4 class="explain">Teaser</h4>
        <textarea id="t1" class="edit teaser" preview="p1">{$edit_page->teaser_markdown}</textarea>
    </editor>
    <preview>
        <h4 class="explain">Preview</h4>
        <div id="p1"></div>
    </preview>
</stuff>

{for $i = 0; $i < 3; $i++}
<stuff class="bottom stuff_{$i+1}">
    <editor>
        <h4 class="explain">Column {$i+1}</h4>
        <textarea id="c{$i+1}" class="edit content" preview="cp{$i+1}">{$edit_page->content[$i]->markdown}</textarea>
    </editor>
    <preview>
        <h4 class="explain">Preview</h4>
        <div id="cp{$i+1}"></div>
    </preview>
</stuff>
{/for}

<h4 class="explain">Notes</h4>

<conclusion>

<p>iframes (such as youtube embeds and maps) will not preview on this screen. To see those, use the "Preview Full Page" button up top.</p>
</conclusion>

{/if}

{/block}

{block name="footer"}
<script>
{if isset($overview)}
{else}
var md = window.markdownit();
var md2 = window.markdownit("commonmark");

$(".edit").on("change keyup keydown", function() {
    render();
});

function render() {
    $(".edit").each(function() {
        var val = $(this).val();
        var win = $(this).attr("preview");
        var res = md.render(val);
        $("#" + win).html(res);
    });
}

render();

function get_payload() {
    return({
        title: $("#page-title").val(),
        new_slug: $("#page-slug").val(),
        status: $("input[name=page-status]:checked").val(),
        columns: $(".btn-column-selector.active").attr("data-column"),
        teaser_html: md2.render($("#t1").val()),
        teaser_markdown: $("#t1").val(),
        content: [
            { markdown: $("#c1").val(), html: md2.render($("#c1").val() ) },
            { markdown: $("#c2").val(), html: md2.render($("#c2").val() ) },
            { markdown: $("#c3").val(), html: md2.render($("#c3").val() ) }
        ]
    });
}

$("#b_p").click(function() {
    $.ajax(
        "{$homepage}/admin/edit/_preview_",
        {
            method: "post",
            dataType: "json",
            data: get_payload(),
            success: function(e) {
                if( e.status === "ok") {
                    window.open( e.url, "_blank" );
                } else {
                    alert( "ERROR: ", e.message );
                }
            }
        }
    )
});

$("#b_s").click(function() {
    $.ajax(
        "{$homepage}/admin/edit/{$edit_slug|replace:'/':'_'}",
        {
            method: "post",
            dataType: "json",
            data: get_payload(),
            success: function(e) {
                if( e.status === "ok") {
                    window.location = '{$homepage}/admin/edit/';
                } else {
                    alert( "ERROR: " + e.message );
                }
            }
        }
    )
});

$(".btn-column-selector").click(function() {
    $(".btn-column-selector").removeClass("active");

    var s = $(this).attr("data-show");
    var h = $(this).attr("data-hide");
    $(s).show();
    $(h).hide();

    $(this).addClass("active");
});

$(".btn-column-selector.active").click();

{/if}
</script>

{/block}
