<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico" >
</head>
<?php require_once('Connections/mrdb.php'); ?>
<body>
<?php
$input = sprintf("SELECT DISTINCT `Iid` FROM `input` ");
mysql_query("set names utf8");
$result_input=mysql_db_query($database_ceg, $input, $ceg); ?> 
<form action='pathway.php' enctype='application/x-www-form-urlencoded' method='get'>
Input <select name="st" size="1" id="st">
<?php while ($row = mysql_fetch_assoc($result_input)): ?>
<?php echo "<option value='";
echo  $row['Iid'];
echo "'>";
echo $row['Iid'];
echo "</option>";?>

<?php echo "<p></p>"; ?>

<?php endwhile; ?>
</select>
Output<select name="ed" size="1" id="st">
<?php 
$output = sprintf("SELECT DISTINCT `Oid` FROM `output` ");
$result_output=mysql_db_query($database_ceg, $output, $ceg); ?> 
<?php while ($row = mysql_fetch_assoc($result_output)): ?>
<?php echo "<option value='";
echo  $row['Oid'];
echo "'>";
echo $row['Oid'];
echo "</option>";?>

<?php echo "<p></p>"; ?>

<?php endwhile; ?>
</select>

 <p>
 <input name='Submit3' type='submit' value='Generate' />
 </p>
 </form></td>
 </tr>
 </tbody>
</table><br></br>
<br></br>
<br>
<H1>&nbsp;</H1>
<br />
<h1>&nbsp;</h1>
<br>
<h1><br />
 </h1>
 </div>
</div>
<div id="progress" class="dialogContent" style="text-align: center; display: none;"></div>
</body>
</html>
