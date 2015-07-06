{extends file="template.tpl"}

{block name="title"}
    <title>Visit | VOA Studio Tour</title>
{/block}

{block name="head"}

<link rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="{$homepage}/css/jquery.datetimepicker.css" />
<link rel="stylesheet" type="text/css" href="{$homepage}/css/jquery-ui-slider-pips.css">

{/block}

{block name="jumbotron"}

<h1>VOA Tour Reservations</h1>
<p>Tours of the VOA radio and television studios in Washington are available to the public. It's a fascinating look at the largest U.S. international broadcast operation.</p>

{/block}

{block name="body"}

<div id="carousel-example-generic" class="carousel slide" data-interval="false" data-wrap="false" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        <li data-target="#carousel-example-generic" data-slide-to="3"></li>
        <li data-target="#carousel-example-generic" data-slide-to="4"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <div class="item active" data-id="0">
            {include file="form_slide1.tpl"}
        </div>
        <div class="item" data-id="1">
            {include file="form_slide2.tpl"}
        </div>
        <div class="item" data-id="2">
            {include file="form_slide3.tpl"}
        </div>
        <div class="item" data-id="3">
            {include file="form_slide4.tpl"}
        </div>
        <div class="item" data-id="4">
            {include file="form_slide5.tpl"}
        </div>
    </div>

    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

{/block}


{block name="footer"}

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>

<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="{$homepage}/js/bootstrap.min.js"></script>
<script src="{$homepage}/js/moment.min.js"></script>
<script src="{$homepage}/js/jquery.datetimepicker.js"></script>
<script src="{$homepage}/js/jquery-ui-slider-pips.min.js"></script>

<script type="text/javascript">

function Form_Payload() {
    this.data = {
        "number_of_visitors": { label: "Number of visitors", value: 1 },
        "type_of_tour": { label: "Type of tour", value: null },
        "tour_date": { label: "Tour date", value: null },
        "organizer_name": { label: "Organizer's name", value: null },
        "organizer_phone": { label: "Organizer's phone number", value: null },
        "organizer_email": { label: "Organizer's email address", value: null },
        "interests": { label: "Interests", value: null },
        "notes": { label: "Notes", value: null }
    };
}

Form_Payload.prototype.getJSON = function() {
    var r = {};
    for( var k in this.data )(function(k, v) {
        if( v.value == null) v.value = "n/a";
        r[k] = v.value;
    })(k, this.data[k]);
    return( r );
}

Form_Payload.prototype.slideChanged = function(id) {
    if( id == 0 ) $(".left.carousel-control").hide();
    if( id == 4 ) $(".right.carousel-control").hide();

    if( id >= 1 ) $(".left.carousel-control").show();
    if( id <= 3 ) $(".right.carousel-control").show();
}

Form_Payload.prototype.Set = function( key, value ) {
    this.data[key].value = value;
    this.Recap();
}

Form_Payload.prototype.Recap = function() {
    var ul = [];
    for( var k in this.data )(function(k, v) {
        if( v.value == null ) v.value = "n/a";
        ul.push( v.label + ": " + v.value);
    })(k, this.data[k]);

    $("#recap").html("<ul><li>" + ul.join("</li><li>") + "</li></ul>");
}

var VOA_form = new Form_Payload();

jQuery(function($){

    $("#groupSize").slider({ min: 1, max: 20, range: false });
    $("#groupSize").slider("pips" , {
        rest: "label"
    }).on( "slide", function( event, ui ) {
        VOA_form.Set("number_of_visitors", ui.value);
    });

    jQuery('#datetimepicker3').datetimepicker({
        onGenerate:function( ct ){
          $(this).find('.xdsoft_date.xdsoft_weekend').addClass('xdsoft_disabled');
        },
        format:'DD.MM.YYYY',
        timepicker:false,
        dayOfWeekStart: 0,
        inline:true,
        lang:'en',
        formatTimeScroller: 'g:i A',
        onSelectDate: function(ct, $input) {
            VOA_form.Set("tour_date", ct.dateFormat('Y-m-d') );
        }
    });

    // step 1
    $(".left.carousel-control").hide();
    $(".right.carousel-control").hide();
    $("button.tour_type").click(function() {
        $("button.tour_type").removeClass("btn-success");
        $(this).addClass("btn-success");

        VOA_form.Set("type_of_tour", $(this).attr("data-type"));
        $(".right.carousel-control").show();
    });

    $(".carousel").on('slid.bs.carousel', function() {
        var id = parseInt( $("div.item.active").attr("data-id") );
        VOA_form.slideChanged( id );
    });

    $(".organizer_info").on("change", function() {
        var k = $(this).attr("data-id");
        var v = $(this).val();

        VOA_form.Set(k, v);
    });

    $("#send_request").click( function() {
        //$(this).prop("disabled", true);
        $.ajax({
            url: "{$homepage}/visit/request",
            method: "post",
            dataType: "json",
            data: VOA_form.getJSON(),
            success: function() {
                alert( "done" );
            }
        });
    });

});


// Date.parseDate = function( input, format ){
// 	return moment(input,format).toDate();
// };

// Date.prototype.dateFormat = function( format ){
// 	return moment(this).format(format);
// };

</script>

{/block}
