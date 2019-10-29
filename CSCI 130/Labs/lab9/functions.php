<?php
$foo = 10;

function avg($ar) {
    $a = 0;

    $a = array_sum($ar)/count($ar);
    return ($a);
}


function stddev($arr) 
    { 
        $num_of_elements = count($arr); 
          
        $variance = 0.0; 
          
                // calculating mean using array_sum() method 
        $average = array_sum($arr)/$num_of_elements; 
          
        foreach($arr as $i) 
        { 
            // sum of squares of differences between  
                        // all numbers and means. 
            $variance += pow(($i - $average), 2); 
        } 
          
        return (float)sqrt($variance/$num_of_elements); 
    } 
      

function maxandmin($ar) {
    $a = 0;
    $max= 0;
    $min=10000;
    for($i= 0; count($ar); $i++){
        if( $ar[$i] > $max){
        $max = $ar[$i];
        }
        if($ar[$i] < $min){
            $min = $ar[$i];
        }
    }
    
    return [$min,$max];
}


function median($ar) {
    $count = count($ar); //total numbers in array
    $middleval = floor(($count-1)/2); // find the middle value, or the lowest middle value

if($count % 2) { // odd number, middle is the median
    $median = $ar[$middleval];
} else { // even number, calculate avg of 2 medians
    $low = $ar[$middleval];
    $high = $ar[$middleval+1];
    $median = (($low+$high)/2);
}
return $median;
}


?>