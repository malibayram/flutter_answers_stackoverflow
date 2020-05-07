
<?php
header("Content-type: application/json; charset=utf-8");
require_once('db.php');
$query = 'SELECT * FROM `flutter`';
$stm = $db->prepare($query);
$stm->execute();
$rows = $stm->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows);
