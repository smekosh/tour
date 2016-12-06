{extends file="index.tpl"}

{block name="head"}
{include file="admin-css.tpl"}

{*<!--<link href="{$homepage}/css/trix.css" rel="stylesheet" />-->*}
<script src="{$homepage}/js/markdown-it.min.js"></script>

<style type="text/css">
stuff { display: flex; align-items: stretch; }
editor {
    margin-right: 1em;
    width: 40%;
    border-right: 3px dotted #c0c0c0;
    padding-right: 1em;
}
preview {
    margin-left: 1em;
    width: 60%;
}
stuff.top {
    border-bottom: 3px dotted #c0c0c0;
    padding-bottom:1em;
}
editor textarea { width: 100%; resize:vertical; }
textarea.content { min-height: 500px }

.table-edit-list td { width: 45% }
.table-edit-list td:last-child { width: 10% }
.table-edit-header td { width: 20% }
.table-edit-header td:last-child { width: 80% }
.table-edit-header td:last-child input { width: 100% }


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
        <tr>
            <td>{$page->title}</td>
            <td>{$slug}</td>
            <td><a href="{$homepage}/admin/edit/{$slug|replace:'/':'_'}">Edit</a></td>
        </tr>
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
                <input type="text" class="form-control" id="page-slug" name="page-slug" autocomplete="off" value="{$edit_slug}" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">Status</label>
            <div class="col-sm-10">
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
        </div>
    </form>
</prestuff>

<stuff class="top">
    <editor>
        <h4>Teaser</h4>
        <textarea id="t1" class="edit teaser" preview="p1">{$edit_page->teaser_markdown}</textarea>
    </editor>
    <preview>
        <h4>Preview</h4>
        <div id="p1"></div>
    </preview>
</stuff>

<stuff class="bottom">
    <editor>
        <h4>Content</h4>
        <textarea id="t2" class="edit content" preview="p2">{$edit_page->content_markdown}</textarea>
    </editor>
    <preview>
        <h4>Preview</h4>
        <div id="p2"></div>
    </preview>
</stuff>

<conclusion>
    <input id="b_s" type="button" class="btn btn-default btn-lg" value="Save" />
    <input id="b_p" type="button" class="btn btn-default btn-lg" value="Preview Full Page" />
</conclusion>

{/if}

{/block}

{block name="footer"}
<script>
var md = window.markdownit();
// var result = md.render('# markdown-it rulezz!');
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

$("#b_s").click(function() {
    $.ajax(
        "{$homepage}/admin/edit/{$edit_slug|replace:'/':'_'}",
        {
            method: "post",
            dataType: "json",
            // dataType: "html",
            data: {
                title: $("#page-title").val(),
                new_slug: $("#page-slug").val(),
                status: $("input[name=page-status]:checked").val(),
                teaser_html: md.render($("#t1").val()),
                teaser_markdown: $("#t1").val(),
                content_html: md.render($("#t2").val()),
                content_markdown: $("#t2").val()
            },
            success: function(e) {
                if( e.status === "ok") {
                    window.location = '{$homepage}/admin/edit/';
                } else {
                    alert( "ERROR: ", e.message );
                }
            }
        }
    )
});
</script>

{/block}
