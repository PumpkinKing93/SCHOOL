<?php
include_once("functions.php");
$data = [];
if (isset($_GET['ar'])) {
    $ar = json_decode($_GET['ar']);
    $data['averge'] = avg($ar);
    $data['median'] = median($ar);
    
    $data['standard_deviation'] = stddev($ar);
    
    $data['min'] = min($ar);
    $data['max'] = max($ar);
}
echo json_encode($data);

?>