<?php   
function get_path($category_id)  
{     $con = mysql_connect("localhost","root","qWRPLperXKDS");     
	if (!$con) 
	{         
		die('数据库连接失败: ' . mysql_error());     
		}       
		mysql_select_db('igem', $con);        // 查找当前节点的父节点的ID，这里使用表自身与自身连接实现     
		$sql = "SELECT c1.parent_id, c2.category_name AS parent_name FROM category AS c1 LEFT JOIN category AS c2 ON c1.parent_id=c2.category_id            WHERE c1.category_id='$category_id' ";     //echo $sql."<br>";//测试把SQL打印出来，拿到数据库执行一下看看结果     
		$result = mysql_query($sql);     
		$row = mysql_fetch_array($result);//现在$row数组存了父亲节点的ID和名称信息       // 将树状路径保存在数组里面     
		$path = array();       //如果父亲节点不为空（根节点），就把父节点加到路径里面     
		if ($row['parent_id']!=NULL)      
		{         //将父节点信息存入一个数组元素         
			$parent[0]['category_id'] = $row['parent_id'];         
			$parent[0]['category_name'] = $row['parent_name'];           //递归的将父节点加到路径中         
			$path = array_merge(get_path($row['parent_id']), $parent);     
			}      
			return $path; 
			}   //根据上面的图可以看出，K的ID是11，我们就用它来测试路径 
			$path =  get_path(11); echo "<h2>路径数组：</h2>"; echo "<pre>"; print_r($path); echo "</pre>"; 
			//将路径到根节点的路径打印出来 //打印结果：J>I>D>A> 
			echo "<h2>向根节点打印路径：</h2>";   
			for ($i=count($path)-1; $i>=0; $i--) 
			{      echo $path[$i]['category_name']. '>'; 
				}   
				?>