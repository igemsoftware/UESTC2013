<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico" >

</head>

<body>
<?php
$te=$_GET['te'];
echo "<br/>";
$ste=strtr($te,"-"," ");
$pathway=explode("-",$te);
#echo $te;
echo "<br/>";?>
<?php echo $pathway[0]; 
echo "---";?>
<?php 
if ($pathway[1]=="NULL")
{echo "";}
else { echo $pathway[1];
echo "---";}?>
<?php 
if ($pathway[2]=="NULL")
{echo "";}
else { echo $pathway[2];
echo "---";}?>
<?php 
if ($pathway[3]=="NULL")
{echo "";}
else { echo $pathway[3];
echo "---";}?>
<?php echo $pathway[4];
echo "--->";?>
<?php echo $pathway[5]; ?>
<?php 
echo "<br/>";
echo "The score is : "; 
?> 

<?php 
$score=passthru("python score.py $ste");

echo $score;
?>





<br>
<h1><br />
 </h1>
 </div>
</div>
<div id="progress" class="dialogContent" style="text-align: center; display: none;"></div>
</body>
</html>
