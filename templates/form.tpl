{extends file="template.tpl"}

{block name="head"}

<link rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="{$homepage}/css/jquery.datetimepicker.css" />

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



        {*<!-- inelegant attempt at a progress bar; aborted nearly to the point of the bootstrap version... remove this when #form-progress-bar is pushed to production
        <style type="text/css">

        .carousel-progress li {
            color: #fff;
            font-weight: bold;
            list-style: none;
            margin: 0 auto 3em auto;
            padding: .5em;
            text-align: center;
        }



        .carousel-progress li.progress-label { background: #A3CAFF; color: #333; font-weight: normal; }


        .carousel-progress li.active.progress-start { background: #8AB1EE; }
        .carousel-progress li.progress-calendar { background: #7097D4; }
        .carousel-progress li.progress-people { background: #577EBB; }
        .carousel-progress li.progress-notes { background: #3D64A1; }
        .carousel-progress li.progress-review { background: #244B88; }


        .carousel-progress li.active { background: #5CB85C; }
        </style>
        <div class="row">
        <ol class="carousel-progress col-xs-12 col-md-12">
            <li class="hidden-xs col-md-1"></li>
            <li data-target="#start" data-slide-to="0" class="col-xs-2 col-md-2 progress-start active">Part 1</li>
            <li data-target="#calendar" data-slide-to="1" class="col-xs-2 col-md-2 progress-calendar">Part 2</li>
            <li data-target="#people" data-slide-to="2" class="col-xs-2 col-md-2 progress-people">Part 3</li>
            <li data-target="#notes" data-slide-to="3" class="col-xs-2 col-md-2 progress-notes">Part 4</li>
            <li data-target="#review" data-slide-to="4" class="col-xs-4 col-md-2 progress-review">Review</li>
            <li class="hidden-xs col-md-1"></li>
        </ol>
        </div>
        --> *}



    <div class="row" id="form-progress-bar">
        <div class="col-xs-12">
            <div class="progress">
                <div data-target="#start" data-slide-to="0" class="progress-bar progress-bar-start progress-bar-current" style="width: 20%">Start</div>
                <div data-target="#calendar" data-slide-to="1" class="progress-bar progress-bar-calendar " style="width: 20%">Step 2</div>
                <div data-target="#people" data-slide-to="2" class="progress-bar progress-bar-people " style="width: 20%">Step 3</div>
                <div data-target="#notes" data-slide-to="3" class="progress-bar progress-bar-notes " style="width: 20%">Step 4</div>
                <div data-target="#review" data-slide-to="4" class="progress-bar progress-bar-review" style="width: 20%">Review</div>
            </div>
        </div>
    </div>



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
</div>

<nav class="">
  <ul class="pager">
    <li class="previous"><a href="#"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> Go Back</a></li>
    <li class="next"><a href="#">Next <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></a></li>
  </ul>
</nav>

{/block}

{block name="footer"}

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>

<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="{$homepage}/js/bootstrap.min.js"></script>
<script src="{$homepage}/js/moment.min.js"></script>
<script src="{$homepage}/js/jquery.datetimepicker.js"></script>

<script type="text/javascript">

function Form_Payload() {
    this.data = {
        "number_of_visitors": { label: "Number of visitors", value: 1 },
        "type_of_tour": { label: "Type of tour", value: "Daily" },
        "tour_date": { label: "Tour date", value: null },
        "organizer_name": { label: "Organizer's name", value: null },
        "organizer_phone": { label: "Organizer's phone number", value: null },
        "organizer_email": { label: "Organizer's email address", value: null },
        "guests": { label: "Guests", list: true, value: [] },
        "interests": { label: "How did you hear about VOA tour", value: null },
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
    if( id == 0 ) {
        $("li.previous").hide();
    }
    if( id == 4 ) {
        $("li.next").hide();
    }

    if( id >= 1 ) {
        $("li.previous").show();
    }

    if( id <= 3 ) {
        $("li.next").show();
    }

    $("#form-progress-bar .progress-bar").removeClass("progress-bar-complete progress-bar-current");
    $("#form-progress-bar .progress-bar").slice(0,id).addClass("progress-bar-complete");
    $("#form-progress-bar .progress-bar:eq(" + id + ")").addClass("progress-bar-current");
}

Form_Payload.prototype.Set = function( key, value, that ) {

    if(
        typeof this.data[key].list != "undefined" &&
        this.data[key].list != "undefined" === true
    ) {
        var array_key = $(that).attr("key");
        this.data[key].value[array_key] = value;
    } else {
        this.data[key].value = value;
    }

    this.Recap();
}

Form_Payload.prototype.resize_other_guests = function() {
    var requested = this.data["number_of_visitors"].value; // 1
    var count = $("#other_guests input").length; // 19

    $("#other_guests .input-group").hide();
    $("#other_guests .input-group").slice(0,requested-1).show();

    if( requested === 1 ) {
        $("#full_legal_names").hide();
    } else {
        $("#full_legal_names").show();
    }
}

Form_Payload.prototype.Recap = function() {
    var ul = [];
    for( var k in this.data )(function(k, v) {
        if( typeof v.value === "undefined" ) return(false);

        // single-value key
        if( v.value == null ) v.value = "n/a";
        ul.push( v.label + ": " + v.value);
    })(k, this.data[k]);

    this.resize_other_guests();

    $("#recap").html("<ul><li>" + ul.join("</li><li>") + "</li></ul>");
}

var VOA_form = new Form_Payload();
var reservation_range = {$reservation_range|json_encode};

jQuery(function($){

    var fragment = $("#other_guests").html();

    // variable guest size
    for( var i = 3; i <= 20; i++ )(function(count) {
        $("#other_guests").append( fragment );
        $("#other_guests span:last").html(count);
    })(i);

    // update key hints
    $("#other_guests input").each(function(k,v) {
        $(this).attr("key", k);
    });

    $("#groupSizeMobile").on("change", function() {
        var value = parseInt($(this).val());
        VOA_form.Set("number_of_visitors", value );

        jQuery('#datetimepicker3').datetimepicker(picker_options);
    });

    function update_date(cal, day, disable) {
        var d = day.split("-");

        var selector =
            ".xdsoft_date" +
            "[data-year='" + parseInt(d[0]) + "']" +
            "[data-month='" + (parseInt(d[1])-1) + "']" + // gah, month-1
            "[data-date='" + parseInt(d[2]) + "']";

        var x = $(cal).find(selector);

        if( disable === true ) {
            x.addClass("xdsoft_disabled");
            x.prop("title", "Day unavailable");
        } else {
            x.removeClass("xdsoft_disabled");
            x.removeProp("title");
        }
    }

    function datepicker_generate(that, ct) {
        // disable weekends
        $(that).find('.xdsoft_date.xdsoft_weekend').addClass('xdsoft_disabled').prop("title", "Day unavailable");

        var cal = that;

        if( VOA_form.data.type_of_tour.value === "Daily" ) {
            for( var k in reservation_range.days.reserved)(function(day, count) {
                update_date(cal, day, false);
                if( 20 - count - VOA_form.data.number_of_visitors.value < 0 ) {
                    update_date(cal, day, true);
                }
            })(k, reservation_range.days.reserved[k])
        }

        // blocked-off dates are non-negotiable
        for( var k in reservation_range.days.closed)(function(day, count) {
            update_date(cal, day, true);
        })(k, reservation_range.days.closed[k])
    }

    var picker_options = {
        onGenerate:function( ct ){
            datepicker_generate(this, ct);
        },
        formatDate:'Y-m-d',
        format:'YYYY-MM-DD',
        minDate:'{$reservation_range.start|date_format:"Y-m-d"}',
        maxDate:'{$reservation_range.end|date_format:"Y-m-d"}',
        timepicker:false,
        dayOfWeekStart: 0,
        inline:true,
        lang:'en',
        formatTimeScroller: 'g:i A',
        onSelectDate: function(ct, $input) {
            VOA_form.Set("tour_date", ct.dateFormat('Y-m-d') );
        }
    };

    jQuery('#datetimepicker3').datetimepicker(picker_options);

    $("#tourType1").click(function() {
        VOA_form.Set("type_of_tour", "Daily");

        // update calendar, because different rules apply
        jQuery('#datetimepicker3').datetimepicker(picker_options);

        $("#question_4_1").html("How did you hear about the VOA tour?");
    });

    $("#tourType2").click(function() {
        VOA_form.Set("type_of_tour", "Special");

        // update calendar, because different rules apply
        jQuery('#datetimepicker3').datetimepicker(picker_options);

        $("#question_4_1").html("Any particular interests?");
    });

    $(".carousel").on('slid.bs.carousel', function() {
        var id = parseInt( $("div.item.active").attr("data-id") );
        VOA_form.slideChanged( id );
    });

    // sm
    $(".previous a").click( function(event) {
        event.preventDefault();
        $(".carousel").carousel('prev');
    });

    $(".next a").click( function(event) {
        event.preventDefault();
        $(".carousel").carousel('next');
    });

    // multiples, keyed with data-id
    $(".organizer_info").on("change", function() {
        var k = $(this).attr("data-id");
        var v = $(this).val();

        VOA_form.Set(k, v, this);
    });

    function status_message(message, good) {
        if( good === true ) {
            $("#status_reply")
                .addClass("bg-success")
                .removeClass("bg-danger")
            ;
        } else {
            $("#status_reply")
                .removeClass("bg-success")
                .addClass("bg-danger")
            ;
        }
        $("#status_reply").html( message );
    }

    $("#send_request").click( function() {
        var that = this;

        status_message("", true);
        $("li.previous").hide();

        $(that).prop("disabled", true);
        $.ajax({
            url: "{$homepage}/visit/request",
            method: "post",
            dataType: "json",
            data: VOA_form.getJSON(),
            success: function(data) {
                status_message( data.message, (data.status === "good" ? true : false) );
                if( data.status !== "good" ) {
                    $(that).prop("disabled", false);
                    $("li.previous").show();
                } else {
                    $("li.previous").hide();
                }
            },
            error: function(err) {
                status_message("Error: unable to send a reservation request.<br/>Please call (202) 203-4990 to arrange a tour.", false);
                $(that).prop("disabled", false);
                $("li.previous").show();
            }
        });
    });

    // init state
    $("li.previous").hide();
    VOA_form.Set("number_of_visitors", 1 );

    // $("li.next").hide();


});

</script>

{/block}
