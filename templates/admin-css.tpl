<style type="text/css">
td { width: 14.285% }
.nyet { background-color: #AAAAAA; }
.calendar-day {
    background-color: rgba(100, 100, 100, 0.5);
    color: white;
    font-weight: bold;
    padding: 0.5em;
}

.nyet .calendar-day { background-color: white }

.calendar-day-label {
    background-color: white;
    border: 1px solid white;
    border-radius: 2em;
    color: #666;
    display: block;
    float: left;
    text-align: center;
    width: 1.75em;
}
.tour_closed_notice { margin-left: 1em }


.visitor_count {
    background-color: black;
    border: 3px solid black;
    border-radius: 20px;
    color: white;
    font-size: 24px;
    text-align: center;
    width: 40px;
    height: 40px;
    float: left;
}
.visitor_count_breakdowns {
    float: right;
    padding-right: 1em;
}
.reservation-calendar td {
    border:1px solid white;
    /* border-bottom: 1em solid white !important; */
    /* border-right: 1em solid white !important; */
}
.reservation-calendar .last-right { border-right:0px !important; }
.reservation-calendar .last-bottom { border-bottom:0px !important; }

table.details { width: 40% }
.details td { padding:0.1em; text-align: center }
.details tbody { }
td.details_num {
    width: 3em;
    margin-top:3px;

}
.details_num span {
    color: white;
    border:1px solid #dddddd;
    display: block;
    width:1.5em;
    background-color: #dddddd;
    border-radius:10px;
    text-align: center;
}
.total_cl { background-color: #DDDDDD }

td { padding:0px !important }
.cell-liner {
    /*border:2px solid white;*/
    /*width: 100%;*/
}
.cell-liner p { margin:0; padding:0 }
.visitor_count_breakdowns li.total { border-top: 1px dotted silver; font-weight: bold;  }
.closed .visitor_count_breakdowns li.total { border-top: 1px dotted black; }
.visitor_count_breakdowns li { text-align: right; list-style: none }

.nyet .cell-liner { /*border: 2px solid silver*/ }
.jumbotron h2 a { color: white; font-size: 20px !important; }
.jumbotron-selected { text-decoration: underline }
.mout { /*background-color: wheat;*/ }
.mout .cell-liner { /*border: 2px solid black */ }

.empty { }
.full { }
.tdcell { background-color: #DDDDDD }
.closed { background-color: #6a6a6a; }
.nyet { background-color: white }
.closed.full { background-color: #FF851B !important }

.mousemenu {
    /* background-color: black; */
    /* position: absolute; */
    /*width:14.285%;*/
    /* height:1em; */
    padding: 0.5em;
    /*margin-top:5em;*/
    text-align: center;
}
.mousemenu a { text-decoration: underline; }
.closed .mousemenu a { color: #001f3f; }

.mousemenu { opacity:0 }
.mout .mousemenu { /*display: block*/; opacity: 1 }
.should_close a { font-weight: bold; }
.friendly_month { float: right; color: silver; }
.modal label { cursor: pointer }


@media print {
    .jumbotron { display: none }
    footer { display: none }
    .report { max-width: 100% !important }
    h1 { display: none }
    .repeated-header { display: none }
}

</style>