<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico" >
</HEAD>
<?php require_once('Connections/mrdb.php'); ?>
<?php
$currentPage = $_SERVER["PHP_SELF"];

$maxRows_cegRecord = 3000;
$pageNum_cegRecord = 0;

mysql_select_db($database_ceg, $ceg);
$colname_cegRecord = (get_magic_quotes_gpc()) ? $_GET['st'] : addslashes($_GET['st']);
$colname1_cegRecord = (get_magic_quotes_gpc()) ? $_GET['ed'] : addslashes($_GET['ed']);
$query_cegRecord = sprintf("SELECT * FROM igem WHERE `start` LIKE '%%%s%%' and `end` LIKE '%%%s%%' ", $colname_cegRecord, $colname1_cegRecord);
$query_limit_cegRecord = sprintf("%s LIMIT %d, %d", $query_cegRecord, $startRow_cegRecord, $maxRows_cegRecord);
$cegRecord = mysql_query($query_limit_cegRecord, $ceg) or die(mysql_error());
$row_cegRecord = mysql_fetch_assoc($cegRecord);

$queryString_cegRecord = "";
if (!empty($_SERVER['QUERY_STRING'])) {
  $params = explode("&", $_SERVER['QUERY_STRING']);
  $newParams = array();
  foreach ($params as $param) {
    if (stristr($param, "pageNum_cegRecord") == false && 
        stristr($param, "totalRows_cegRecord") == false) {
      array_push($newParams, $param);
    }
  }
  if (count($newParams) != 0) {
    $queryString_cegRecord = "&" . htmlentities(implode("&", $newParams));
  }
}
$queryString_cegRecord = sprintf("&totalRows_cegRecord=%d%s", $totalRows_cegRecord, $queryString_cegRecord);

if (isset($_GET['totalRows_cegRecord'])) {
  $totalRows_cegRecord = $_GET['totalRows_cegRecord'];
} else {
  $all_cegRecord = mysql_query($query_cegRecord);
  $totalRows_cegRecord = mysql_num_rows($all_cegRecord);
}
$totalPages_cegRecord = ceil($totalRows_cegRecord/$maxRows_cegRecord)-1;

$queryString_cegRecord = "";
if (!empty($_SERVER['QUERY_STRING'])) {
  $params = explode("&", $_SERVER['QUERY_STRING']);
  $newParams = array();
  foreach ($params as $param) {
    if (stristr($param, "pageNum_cegRecord") == false && 
        stristr($param, "totalRows_cegRecord") == false) {
      array_push($newParams, $param);
    }
  }
  if (count($newParams) != 0) {
    $queryString_cegRecord = "&" . htmlentities(implode("&", $newParams));
  }
}
$queryString_cegRecord = sprintf("&totalRows_cegRecord=%d%s", $totalRows_cegRecord, $queryString_cegRecord);
?> 
<BODY>
<div class=main>
  
  <H1>Result of searching</H1>
<div class=section>
<table cellspacing=0 class="sort-table" id="table-1">
 <thead>
<tr align='center' bgColor=#7FDD97>
<td><STRONG>Organism</STRONG></td>
<td><STRONG>Accession</STRONG></td>
<td><STRONG>Data</STRONG></td>
<td><STRONG>Genus</STRONG></td>
</tr>
 </thead>
<?php do { ?>
<tr align='center'>

<td ><?php echo $row_cegRecord['start']; ?></td>
<td ><?php echo $row_cegRecord['p1']; ?></td>
<td ><?php echo $row_cegRecord['end']; ?></td>
</tr>
<?php } while ($row_cegRecord = mysql_fetch_assoc($cegRecord)); ?>
</table>

</div>
</div>
</body></html>
