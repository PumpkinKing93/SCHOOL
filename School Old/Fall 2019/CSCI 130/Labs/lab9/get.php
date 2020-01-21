<<<<<<< HEAD
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

=======
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

>>>>>>> 3c23027f6d2ee9146a630164e604e1edfb3d267b
?>