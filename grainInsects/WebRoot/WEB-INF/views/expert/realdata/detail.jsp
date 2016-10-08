<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<style>
	img{
		margin: 4px;
		width:100%;height:auto;
	}
</style>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript"> 
	
	goback = function(){
		window.history.back();
	}

</script>	
</head>
<body class="easyui-layout">
	<div data-options="region:'center',border:false" title="监控预报 > 数据列表 > 详情" style="">
		<div class="container" >
			
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="粮仓信息"/>
				</li>
				<li>
					<input type="button" value="实时信息"/>
				</li>
				<li>
					<input type="button" value="设备注册" />
				</li> 
				<li>
					<input type="button" value="实时图片" />
				</li> 
			</ul>			
			<!-- 粮仓信息 -->
			<table class="input tabContent">
				<tr>
					<th> 粮仓编码：</th> <td>${grainbin.lcbm}</td>
					<th> 仓型：</th> <td>${grainbin.typebin}</td>
				</tr>
				<tr>
					<th> 设计容量：</th> <td>${grainbin.capacity}</td>
					<th> 仓体结构：</th> <td>${grainbin.structureofbody}</td>
				</tr>
				<tr>
					<th> 仓顶结构：</th> <td>${grainbin.structureofroof}</td>
					<th> 设计单仓容量：</th> <td>${grainbin.designcapacity}</td>
				</tr>
				<tr>
					<th> 设计粮堆高度：</th> <td>${grainbin.designgrainheapheight}</td>
					<th> 长：</th> <td>${grainbin.longth}</td>
				</tr>
				<tr>
					<th> 宽：</th> <td>${grainbin.width}</td>
					<th> 高：</th> <td>${grainbin.height}</td>
				</tr>
				<tr>
					<th> 环流装置：</th> <td>${grainbin.circulatedevice}</td>
					<th> 环流风机：</th> <td>${grainbin.circulatefan}</td>
				</tr>
				<tr>
					<th> 仓房风道：</th> <td>${grainbin.fanway}</td>
					<th> 其他设施：</th> <td>${grainbin.elsedevice}</td>
				</tr>
				<tr>
					<th> 联系人：</th> <td>${grainbin.contract}</td>
					<th> 联系电话：</th> <td>${grainbin.phone}</td>
				</tr>
				<tr>
					<th> 备注：</th> <td>${grainbin.note}</td>
					
				</tr>
				<tr>
					<th> 录入人：</th> <td>${grainbin.modifer}</td>
					<th> 录入日期：</th> <td>${grainbin.modifydate}</td>
				</tr>
			</table> 
			<!-- "实时信息" -->
			<table class="input tabContent">
	
				<tr>
					<th> 温度：</th> <td>${realdata.temperature}</td>
					<th> 湿度：</th> <td>${realdata.humidity}</td>
				</tr>
				<tr>
					<th> 二氧化碳：</th> <td>${realdata.co2}</td>
					<th> 氧气：</th> <td>${realdata.o2}</td>
				</tr>
				<tr>
					<th> 虫种：</th> <td>${realdata.kind}</td>
					<th> 虫态：</th> <td>${realdata.stage}</td>
				</tr>
				<tr>
					<th> 数量：</th> <td>${realdata.num}</td>
				</tr>
				<tr>
					<th> 经度：</th> <td>${realdata.longtitude}</td>
					<th> 纬度：</th> <td>${realdata.latitude}</td>
				</tr>
				<tr>
					<th> 海拔：</th> <td colspan=3>${realdata.altitude}</td>
				</tr>
				<tr>
					<th> X：</th> <td>${realdata.x}</td>
					<th> Y：</th> <td>${realdata.y}</td>
				</tr>
				<tr>
					<th> Z：</th> <td colspan=3>${realdata.z}</td>
				</tr>
				<tr>
					<th> 采集时刻：</th> <td>${realdata.collecttime}</td>
					<th> 信息来源：</th> <td>${realdata.source}</td>
				</tr>
			</table> 
			<!-- 设备注册 -->
			<table class="input tabContent">
				<tr>
					<th> 设备名称：</th> <td>${deviceRegister.name}</td>
					<th> 类型：</th> <td>${deviceRegister.kind}</td>
				</tr>
				<tr>
					<th> 生产厂家：</th> <td>${deviceRegister.productor}</td>
					<th> 注册日期：</th> <td>${deviceRegister.regitserdate}</td>
				</tr>
			</table> 
			<!-- 实时图片 -->
			<table class="input tabContent">
				<c:forEach var="pic" items="${realdataPics}" varStatus="status">
				<tr>
					<td>
						<img src="<%= request.getContextPath() %>${ pic.pic}"/>
					</td>
				</tr>
				</c:forEach>
				
			</table> 					
			<table class="input">
				<tr><th>&nbsp;</th>
				<td >
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="window.history.back()" iconCls="icon-back">返回</a>
				</td>
				</tr>	
			</table>		
		</div>
	</div>
</body>
</html>