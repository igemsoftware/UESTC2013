<?php echo "<select name='ed' size='1' id=st'>";    ?>
<?php 
function display_children($category_id, $level)  
{     $con = mysql_connect("localhost","root","qWRPLperXKDS");     
	if (!$con) {         die('数据库连接失败: ' . mysql_error());     }   
	
	mysql_select_db('igem', $con);      // 获得当前节点的所有孩子节点（直接孩子，没有孙子）     
	$result = mysql_query("SELECT * FROM category WHERE parent_id='$category_id'");       // 遍历孩子节点，打印节点  
	   
	while ($row = mysql_fetch_array($result))      
	{         
		// 根据层级，按照缩进格式打印节点的名字         
		// 这里只是打印，你可以将以下代码改成其他，比如把节点信息存储起来      
		echo "<option value='".$row['value']."'>".str_repeat('|-',$level).$row['category_name']."</option>";          
		// 递归的打印所有的孩子节点        
		display_children($row['category_id'], $level+1);     } 
		}   
		//根节点是A:1我们就用它来打印所有的节点 
		display_children(1, 0); 
		echo "</select>";?> 
		


