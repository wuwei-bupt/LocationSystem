<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		
		<meta charset='utf-8'>
		<title>å¾çå è½½å¹³ç§»æ¾å¤§ç¼©å°ç¤ºä¾</title>
		<style>
			html,body{
				margin:0px;
				padding:0px;
			}
			#container{
				position:relative;
				width:800px;
				height:800px;
                border: 1px solid #000;
			}
			#canvas{
				width:100%;
				height:100%;
			}
			#icon{
				position:absolute;
				right:10px;
				bottom:10px;
			}
			button{
				padding:0;
				margin:0;
			}
		</style>
		<jsp:include page="/common/easyui.jsp"></jsp:include>
	</head>
	<body class="easyui-layout" data-options="fit:false,border:false">
		<div id="container" data-options="region:'center',split:false,border:true" 
			style="overflow: hidden; ">
			<div id="container_map">
				<canvas id="canvas" width="800" height="800"></canvas>
				<canvas id="layer2" width="800" height="800"></canvas>
			</div>
			<div id="icon">
				<button type="button" id="zoom-in"><img src="zoom-in.png" alt="zoom-in" /></button>	
				<button type="button" id="zoom-out"><img src="zoom-out.png" alt="zoom-out" /></button>	
				<button type="button" id="revert"><img src="key.png" alt="revert" /></button>				
			</div>
		</div>
		<div data-options="region:'east',split:false " title=" "
		style="overflow: hidden;width: 220px;">
		<ul id="tt" class="easyui-tree">  
				   
			             
			            <li>   
			                <span>总人数 :100</span>   
			            </li>   
			            <li>   
			                <span>已到人数:99</span>   
			            </li>
			             <li>   
			                <span>缺勤人数:1</span>   
			            </li>   
			            <li>   
			                <span>缺勤人员名单</span>
			                 <ul> 
			                <li>   
			                <span>张三</span>   
			            	</li>   
			            	</ul>
			            </li>
			                 
			       
			       
			</ul>  
		</div>
		<script type="text/javascript" src="main.js"></script>
	</body>
</html>
