<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<link rel="shortcut icon" type="image/x-icon" href="favicon.ico" >
</head>

<?php require_once('Connections/mrdb.php'); ?>
<body>
<?php
$st=$_GET['st'];
$ed=$_GET['ed'];
echo "</br>";
$input = sprintf("SELECT * FROM `igem` LEFT JOIN (`input`,`output`) ON (`start` = `Iname` and `end` = `Oname`)where (`Iid` LIKE '%s' and `Oid` LIKE '%s')", $st, $ed);
mysql_query("set names utf8");
$result=mysql_db_query($database_ceg, $input, $ceg); 
$count=mysql_num_rows($result);
//echo $count;
if($count!=0){
?> 
<?php echo "<table border='1'><tr><td>Pathway</td><td>Score</td><td>Select Terminator</td></tr>";?>
<?php while ($row = mysql_fetch_assoc($result)): ?>
<?php echo "<tr><td>";?>
<?php echo $row['start']; 
echo "------>";?>
<?php 
if ($row['p1']=="NULL")
{echo "";}
else { echo $row['p1'];
echo "------>";}?>
<?php 
if ($row['p2']=="NULL")
{echo "";}
else { echo $row['p2'];
echo "------>";}?>
<?php 
if ($row['p3']=="NULL")
{echo "";}
else { echo $row['p3'];
echo "------>";}?>
<?php echo $row['end']; ?>
<?php echo "</td><td>";?>

<?php 

$score=passthru("python score.py $row[start] $row[p1] $row[p2] $row[p3] $row[end]"); 
echo $score;

?>
<?php echo "</td><td>";?>
<?php 
echo "<form id='form1' method='get' action='result.php'>";
echo "<select  name='te' size='1' id='te'>";
echo "<option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B0011'>BBa_B0011</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B0012'>BBa_B0012</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B0013'>BBa_B0013</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B0014'>BBa_B0014</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B0015'>BBa_B0015</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B0016'>BBa_B0016</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B0017'>BBa_B0017</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B0021'>BBa_B0021</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B0023'>BBa_B0023</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B1003'>BBa_B1003</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B1005'>BBa_B1005</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B1006'>BBa_B1006</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B1007'>BBa_B1007</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B1008'>BBa_B1008</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B1009'>BBa_B1009</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_B1010'>BBa_B1010</option>";
echo "</option><option value='";
echo $row['start']."-".$row['p1']."-".$row['p2']."-".$row['p3']."-".$row['end']."-BBa_K864600'>BBa_K864600</option></select>";

echo "<input name='Submit3' type='submit' value='Get pathway' /></form>";

?>

<?php echo "</td></tr>"; ?>
<?php endwhile; ?>
<?php echo "</table>";?>
<?php }
else {echo "Sorry There is no pathway";}?>




<br>
<h1><br />
 </h1>
 </div>
</div>
<div id="progress" class="dialogContent" style="text-align: center; display: none;"></div>
</body>
</html>
