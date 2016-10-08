<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {
		
		//设置隐藏属性procId的值
		var initProctypeid = '${preventprocess.TProctype.sm}';
		$("#proctypeid").attr("value", initProctypeid);
});

	goback = function(){
		window.close();
	};
</script>	
</head>
<body >
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false" title="知识库  > 防治技术 > 查看">
		
			
			<!-- 基本情况 -->		
			<table class="input tabContent">
				<tr><th> 工艺编码：</th> <td>${preventprocess.sm}</td></tr>
				<tr><th> 工艺名称：</th> <td>${preventprocess.proname}</td></tr>
				<tr><th> 工艺类型：</th>
					<td colspan="3">${preventprocess.TProctype.proctype}
					</td>
				</tr>
				<tr><th> 关键词：</th><td>${preventprocess.keywords}</td></tr>
				<tr><th> 材料：</th><td>${preventprocess.material}</td></tr>
				<tr><th> 处理方式：</th><td>${preventprocess.procway}</td></tr>
				<tr><th> 区域：</th><td>${preventprocess.area}</td></tr>
				<tr><th> 季节：</th><td>${preventprocess.seasion}</td></tr>
				<tr><th> 资料来源：</th><td>${preventprocess.source}</td></tr>
				
			
				<tr>
				<th> 工艺过程：</th>
					<td>
						${preventprocess.process}
					</td>
				</tr>
			
			
				<tr>
				<th> 备注：</th>
					<td>
						${preventprocess.note}
					</td>
				</tr>
				<tr><th> 修改人：</th> <td>${preventprocess.modifer}</td><th> 修改时间：</th> <td>${preventprocess.modifydate}</td></tr>
			</table>
			<table class="input">
				<tr><th>&nbsp;</th>
				<td >
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="goback()" iconCls="icon-no">关闭当前窗口</a>
				</td>
				</tr>	
			</table>							
	</div>
	</div>
</body>