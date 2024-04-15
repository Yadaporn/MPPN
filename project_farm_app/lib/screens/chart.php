<?php
    define("DB:HOST","localhost");
    define("DB:USER",'root');
    define("DB:PASSWORD",'');
    define("DB:NAME",'charts');

$connect=mysqli_connect(DB_HOST,DB_USER,DB_PASSWORD,DB_NAME);

if($cnnect){
  $sql='SELECT * FROM sales';

  $query=mysqli_query($connect,$sql);
  $results=array;

  while($row=mysqli_fetch_assoc($query)){
    $results[]  = $row;
}
echo json_encode($results);
}
?>