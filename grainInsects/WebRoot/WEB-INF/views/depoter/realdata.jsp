<%@ page language="java" 
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path +"/";
%>
<html>
<script type="text/javascript"
	src="<%= request.getContextPath() %>/resources/admin/js/jquery.js"></script>
<script type="text/javascript" 
	src="<%= request.getContextPath() %>/resources/easyUI/extJquery.js" charset="utf-8"></script>

<script>
function js_load(){
	div_main.innerHTML = '<br><table border=5 align=center bgcolor=#efefef><tr><td align=center width=200 height=30 style=\'padding:5px 0px 1px 0px\'><span style=\'font-size:14px;color:blue;font-family:Arial\'><b>请稍等，正在上传数据</b></span><img src=\'images/loading.gif\'></td></tr></table><br>';
}

getlk=function(){
	openBlank('app/depot/datacollect/getlk',	//url
			{
				/* lkbm: ' 100002', */
				username: 'bb',
				password: '1111'
			}		//paramaters
	 );
}

getlkusers = function(){
	openBlank('app/depot/datacollect/getlkusers',	//url
			{
				/* lkbm: ' 100002', */
				username: 'bb',
				password: '1111'
			}		//paramaters
	 );
}

getlkalllc=function(){
	openBlank('app/depot/datacollect/getlkalllc',	//url
			{
				/* lkbm: ' 100002', */
				username: 'bb',
				password: '1111',
				page: 1,		//回传数据的第几页
				rows: 10,		//每页行数
				sort: 'lcbm',	//排序字段,只能是返回的参数列表中的字段，否则返回错误
				order: 'asc',	//排序方向，只有两个值:asc  升序排列, desc 将序排列
				//				以下为查询条件，即指定字段的值作为条件查询，支持模糊查询，如果条件错误，则该条件不起作用
				lcbm:	'1000001'
			}		//paramaters
	 );
}	

getHisRealdata=function(){
	openBlank('app/depot/datacollect/getHisRealdata',	//url
			{
				/* lkbm: ' 100002', */
				//lcbm: '1000001',
				username: 'aaa',
				password: '1111',
				page: 1,		//回传数据的第几页
				rows: 10,		//每页行数
				start_collecttime: '2016-01-06',	//采集开始日期
				end_collettime: '2016-12-12',		//采集结束日期
				sort: 'collecttime',	//排序字段,只能是返回的参数列表中的字段，否则返回错误
				order: 'asc',	//排序方向，只有两个值:asc  升序排列, desc 将序排列
				//				以下为查询条件，即指定字段的值作为条件查询，支持模糊查询，如果条件错误，则该条件不起作用
				lcbm:	'1000001',
			}		//paramaters
	 );
}

getLastGrain = function(){
	openBlank('app/depot/datacollect/getLastGrain',	//url
			{
				/* lkbm: ' 100002',	//粮库编码 */
				lcbm: ' 00100100101',	//粮仓编码
				username: '799141878',		//用户名	
				password: '123456789ooo',		//密码
			}		
	 );
}

deleteGrainPic = function(){
	openBlank('app/depot/datacollect/deleteGrainPic',	//url
			{
				id: '3',	//粮食图片id
				/* lkbm: ' 100002',	//粮库编码 */
				lcbm: '1000001',	//粮仓编码
				username: 'bb',		//用户名	
				password: '1111',		//密码
			}		
	 );
}

login = function(){
	openBlank('app/depot/login',	//url
			{
				/* lkbm: ' 100002',	//粮库编码 */
				username: 'bb',		//用户名	
				password: '1111',		//密码
			}		
	 );
}

</script>

<head>
<base href="<%=basePath%>">
</head>
<body>
	<font color= black  size=3 >请上传实时数据</font>
	<br><div id="info"></div>	<br>
	<form action="app/depot/datacollect/uploadDataAndpic" method="post" enctype="multipart/form-data">
		请选择图片文件:<input type="file" name="file"  title="Browse..."	>
		<br>
		<br>
		<input type="submit" value="提交" onclick="js_load()" > 
		
		<input type="button" value="获取粮库信息" onclick="getlk()" > 
		<input type="button" value="获取指定粮库所有粮仓信息,支持条件（含多条件组合）查询" onclick="getlkalllc()" > 
		<input type="button" value="获取数据上传历史" onclick="getHisRealdata()" > 
		<input type="button" value="获取粮库用户" onclick="getlkusers()" >  <br>
		<input type="button" value="登录" onclick="login()" >  <br>
	<div id='div_main'></div>
	<input type="hidden" name="username" value="aa" />
	<input type="hidden" name="password" value="1111" />
	<input type="hidden" name="pid" value="2" />
	
	<div>
		<hr>
		<table>
			<tr><td> 粮库编码：</td><td><input type="text" name="lkbm" value=" 100002"/></td></tr>
			<tr><td> 粮仓编码：</td><td><input type="text" name="lcbm"  value="1000001" /></td></tr>
			<tr><td> 设备号：</td><td><input type="text" name="deviceno" value="100"/></td></tr>
			<tr><td> 温度：</td><td><input type="text" name="temperature" value="15"/></td></tr>
			<tr><td> 湿度：</td><td><input type="text" name="humidity" value="30"/></td></tr>
			<tr><td> 二氧化碳：</td><td><input type="text" name="co2" value="20"/></td></tr>
			<tr><td> 氧气：</td><td><input type="text" name="o2" value="10"/></td></tr>
			<tr><td> 虫种：</td><td><input type="text" name="kind" value="甲虫"/></td></tr>
			<tr><td> 虫态：</td><td><input type="text" name="stage" value="成虫" /></td></tr>
			<tr><td> 数量：</td><td><input type="text" name="num" value="10" /></td></tr>
			<tr><td> X：</td><td><input type="text" name="X" value="1"/></td></tr>
			<tr><td> Y：</td><td><input type="text" name="Y" value="8"/></td></tr>
			<tr><td> Z：</td><td><input type="text" name="Z" value="10"/></td></tr>
			<tr><td> 经度：</td><td><input type="text" name="longtitude" value="143560.980"/></td></tr>
			<tr><td> 纬度：</td><td><input type="text" name="latitude" value="123400.789"/></td></tr>
			<tr><td> 海拔：</td><td><input type="text" name="altitude" value="1000"/></td></tr>
			<tr><td> 采集时刻：</td><td><input type="text" name="collecttime" value="20160406"/></td></tr>
			<tr><td> 信息来源：</td><td><input type="text" name="source" value="App"/></td></tr>
			
		</table>
	</div>
	</form>
	<br>
	<hr>
	粮食信息(只提交文本信息，可以调用：uploadGrain, 只提交图片可以调用：uploadGrainPic,一起提交则调用：uploadGrainAndPic)
	<br> 更新粮食信息，将action改为"app/depot/datacollect/updateGrain"
	<form id="grain" action="app/depot/datacollect/updateGrain" method="post" enctype="multipart/form-data">
		<input type="submit" value="新增粮情信息" onclick="js_load()" > 
		<input type="button" value="获取最近粮情信息" onclick="getLastGrain()" > 
		<input type="button" value="更新粮情信息" onclick="form.submit()" > 
		<input type="button" value="删除粮情图片" onclick="deleteGrainPic()" > 
		
		<input type="hidden" name="username" value="aa" />
		<input type="hidden" name="password" value="1111" />
		<!-- 更新时使用增加下俩行，增加信息时去掉该行 -->
		<input type="hidden" name="id" value="1" />
		<input type="hidden" name="pid" value="2" />
		
		<br>
		请选择图片文件:<input type="file" name="file"  title="Browse..."	>
			<table>
			<tr><td> 粮库编码：</td><td><input type="text" name="lkbm" value=" 100002"/></td></tr>
			<tr><td> 粮仓编码：</td><td><input type="text" name="lcbm"  value="1000001" /></td></tr>
			<tr><td> 入储日期：</td><td><input type="text" name="indate" value="2016-02-04"/></td></tr>
			<tr><td> 装粮形式：</td><td><input type="text" name="clxs" value="散装粮"/></td></tr>
			<tr><td> 粮种名称：</td><td><input type="text" name="grainname" value="水稻" maxlength="30"/></td></tr>
			<tr><td> 收获日期：</td><td><input type="text" name="harvestdate" value="2015-08-09"/></td></tr>
			<tr><td> 来源：</td><td><input type="text" name="source" value="hunan" maxlength="30"/></td></tr>
			<tr><td> 水分：</td><td><input type="text" name="water" value="20"/></td></tr>
			<tr><td> 杂质：</td><td><input type="text" name="impurity" value="10" /></td></tr>
			<tr><td> 粮堆高度（m）：</td><td><input type="text" name="grainheight" value="10" /></td></tr>
			<tr><td> 干燥方式：</td><td><input type="text" name="dryingmethod" value="风干"/></td></tr>
			<tr><td> 存储期限(年)：</td><td><input type="text" name="reserveperiod" value="8"/></td></tr>
			<tr><td> 入储数量(吨)：</td><td><input type="text" name="innum" value="1000"/></td></tr>
			<tr><td> 装具：</td><td><input type="text" name="container" value="无" maxlength="60"/></td></tr>
			<tr><td> 空仓500Pa(小时)：</td><td><input type="text" name="empty_bin500pa" value="50"/></td></tr>
			<tr><td> 空仓半衰500pa(小时)：</td><td><input type="text" name="halfemptybin500pa" value="50"/></td></tr>
			<tr><td> 满仓300pa(小时)：</td><td><input type="text" name="fullbin300pa" value="200"/></td></tr>
			<tr><td> 满仓半衰(小时)：</td><td><input type="text" name="halffullbin" value="180"/></td></tr>
			<tr><td> 储藏技术：</td><td><input type="text" name="storetechnology" value="长文本"/></td></tr>
			<tr><td> 储藏方式：</td><td><input type="text" name="storemethod" value="冷藏" maxlength="60"/></td></tr>
			<tr><td> 控温措施：</td><td><input type="text" name="controltemperaturemeasures" value="长文本"/></td></tr>
			<tr><td> 控湿措施：</td><td><input type="text" name="controlhumiditymeasures" value="长文本"/></td></tr>
			
		</table>
	</form>
</body>
</html>