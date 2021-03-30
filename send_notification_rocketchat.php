#!/usr/bin/php

<?php
$host    = "localhost";
$user    = "root";
$pass    = "zGBQhE2HUe";
$db_name = "otrs";
$conn = new mysqli($host, $user, $pass, $db_name);
if (!$conn) { die ("error: " . mysqli_error() . PHP_EOL); }
mysqli_set_charset($conn, "utf8");
$result = $conn->query("SELECT * FROM `temp`");
while($arr[] = mysqli_fetch_assoc($result));
//foreach(current($arr) as $key => $value){}
while ($curr_row = current($arr)) {
    exec ('curl -X POST -H \'Content-Type: application/json\' --data \'{"text":"'.$curr_row['tn'].'","attachments":[{"title":"'.$curr_row['create_time'].'","text":"'.$curr_row['title'].'","color":"#764FA5"}]}\' http://10.100.1.59:3000/hooks/9AXaRz5uTDkoz32oW/NFCcuGNyv8pLWcqDDiWbopDAgBHB3f7W33Ws7uQaQXkJtoXt > /dev/null 2>&1');
//      echo 'curl -X POST -H \'Content-Type: application/json\' --data \'{"text":"'.$curr_row['tn'].'","attachments":[{"title":"'.$curr_row['create_time'].'","text":"'.$curr_row['title'].'","color":"#764FA5"}]}\' http://10.100.1.59:3000/hooks/9AXaRz5uTDkoz32oW/NFCcuGNyv8pLWcqDDiWbopDAgBHB3f7W33Ws7uQaQXkJtoXt'.'\n';
    $result =$conn->query("DELETE FROM  `temp` where tn = '".$curr_row['tn']."'");
    if (!$result) {  die("error: " . mysqli_error() . PHP_EOL);}
    /*
            while (false !== ($curr_field = current($curr_row))) {
            //echo $curr_field."\n";
            next($curr_row);
            }
    */
    //echo "!";
    next($arr);
}
$conn->close();
?>
