<?php
if( !defined( "HOMEPAGE") ) die( "Error, config file missing?" );

// Create the Books model
class Tours extends Illuminate\Database\Eloquent\Model {
    public $timestamps = false;
    #protected $dateFormat = 'U';

    public function Visitors() {
        return( $this->hasMany("Visitors") );
    }

    public function Additionals() {
        return( $this->hasMany("Additionals") );
    }
}

class Additionals extends Illuminate\Database\Eloquent\Model {
    public $timestamps = false;

    public function Additional() {
        return( $this->belongsTo("Tours") );
    }
}

class Visitors extends Illuminate\Database\Eloquent\Model {
    public $timestamps = false;
    #protected $dateFormat = 'U';

    public function Visitor() {
        return( $this->belongsTo("Tours"));
    }

    public function Infos() {
        return( $this->hasMany("Infos") );
    }
}

Class Infos extends Illuminate\Database\Eloquent\Model {
    public function Info() {
        return( $this->belongsTo("Visitors") );
    }
}

// sample usages:

#echo "<PRE>";
/*
ok, inserts

$visit = new Tourists();
$visit->visit_day = "2015-07-07";
$visit->num_visitors = 17;
$visit->save();
*/

/*
ok, works!
*/

/*
$tour = Tours::whereVisit_day("2015-07-07")->first();

$bla = $tour->Additionals;
echo $bla;

foreach( $tour->Visitors as $visitor ) {
    echo $visitor->name . "\n";
    foreach( $visitor->Infos as $info ) {
        echo $info->phone . "\n";
        echo $info->email . "\n";
    }
    echo "<hr/>";
}

*/


#$info = $visitor->Infos->first();
#echo $info;

#echo $tour;
#echo $tour->visitors()->first();#->info();


######die;

/*
*/

/*
$tour = Tours::whereVisit_day("2015-07-07")->first();
foreach( $tour->visitors as $visitor ) {
    echo $visitor->name . "<hr/>";
}
echo $tour->num_visitors;
#echo $tour->id;
*/

# $tours = Tours::all();
# $bla = $tours->last();
# $bla->num_visitors = rand(0,255);
# $bla->save();
#
# echo $bla->num_visitors;
#echo $bla->id;
#die;
/*
foreach( $books as $book ) {
    echo $book->visit_day . " - " . $book->num_visitors . "<hr/>";
}*/
#print_r( $books );


/*
$books = Tourists::find(1);
foreach( $books as $book) {
    echo $book->All();
    #echo $book->visit_day . " - " . $book->num_visitors . "<hr/>";
}*/
###die;
