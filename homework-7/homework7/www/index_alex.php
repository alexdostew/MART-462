<?php 
//The server returns JSON data 
$arr=array('name'=>'betty alex','name2'=>'john alex','name3'=>'frankie alex','name4'=>'mary alex','name5'=>'hilly alex'); 
$result=json_encode($arr); 

$callback=$_GET['callback']; 
echo $callback."($result)";
?>