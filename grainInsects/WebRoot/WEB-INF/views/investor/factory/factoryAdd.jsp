<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.print(path);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!-- <#assign content="welcome"> -->
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>main - Powered By Szy++</title>
	<meta name="author" content="Szy++ Team" />
	<meta name="copyright" content="Szy++" />
	<link href="<%=base %>resources/admin/css/common.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=base %>resources/easyUI/themes/cupertino/easyui.css"></link>
	<script type="text/javascript" src="<%=base %>resources/admin/js/common.js"></script>
	<script type="text/javascript" src="<%=base %>resources/admin/js/list.js"></script>
	<script type="text/javascript" src="<%=base %>resources/admin/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
	<style type="text/css">
		
		.myinput {
			outline:none;	/*去掉input获得焦点时的外边框*/
			text-align:center;
			border-style:none;
			border-bottom-style:solid;
			border-bottom-width:1px;
			/* background-color:#F2F5F7; */
		}
		.big_title {
			padding-left: 5px;
			background-color: #D7E8F1; /*E8F2FE  D7E8F1*/
		}
		tr:hover td.big_title {
			background-color: #f1f8ff;
		}
		table.input {
			width: 100%;
			word-break: break-all;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			$("#factoryInfoForm").validate({
				rules: {
					//smFactory: "required",
					nameFactory: "required",
					phone: "required",
				},
				submitHandler: function() {
					var formData = new FormData($("#factoryInfoForm")[0]); 
					$.ajax({
						url : 'factoryAdd',
						data: formData,
						dataType : 'json',
						type: 'POST',
						/* async: false,  
				        cache: false,  */
						contentType: false,  
				        processData: false,  
						success : function(r) {
							if (r && r.success) {
								parent.$.messager.alert('提示', r.msg); //easyui中的控件messager
							} else {
								parent.$.messager.alert('数据更新或插入', r.msg, 'error'); //easyui中的控件messager
							}
						}
					});
				}
			});
		});
			
		function doAdd(){
			$("#factoryInfoForm").submit();
		}
		
		goback = function(){
			window.history.back();
		}
	</script>
</head>
<body>			
	<div class="path">路径>>添加加工厂</div>
	<form id="factoryInfoForm" method="post">
		<table class="input">
			<tr>
					<th>加工厂编号：</th>
					<td><input name="smFactory" class="myinput" type="text" readonly="readonly" style="width:200px" value="${smFactory }"/></td>
			</tr>
			<tr>
				<th><span class="requiredField">*</span>工厂名称：</th>
				<td><input id="nameFactory" type="text" name="nameFactory" class="myinput" maxlength="30" style="width:200px;"/></td>
			</tr>
			<tr>
				<th>地址：</th>
				<td><input name="address" class="myinput" type="text" style="width:200px"/></td>
			</tr>
			<tr>
				<th>邮编：</th>
				<td><input id="postcode" type="text" name="postcode" class="myinput" maxlength="10" style="width:90px;"/></td>
			</tr>
			<tr>
				<th>联系人：</th>
				<td><input id="contacts" name="contacts" class="myinput" type="text" style="width:90px"/></td>
			</tr>
			<tr>
				<th><span class="requiredField">*</span>联系电话：</th>
				<td><input id="phone" name="phone" class="myinput" type="text" style="width:200px"/></td>
			</tr>
			<tr>
				<th>建厂（所）时间：</th>
				<td>
					<input name="constructiondate" type="text" class="easyui-datebox"/>
			</tr>
			<tr>
				<th>收购/加工量：</th>
				<td><input id="annualpurchase" name="annualpurchase" class="myinput" type="text" style="width:90px"/>（吨/年）</td>
			</tr>
			<tr>
				<th>主要仓型：</th>
				<td>
					<input name="mainBintype" class="myinput" type="checkbox" style="width:30px" value="房式仓"/>房式仓
					<input name="mainBintype" class="myinput" type="checkbox" style="width:30px" value="浅圆仓"/>浅圆仓
					<input name="mainBintype" class="myinput" type="checkbox" style="width:30px" value="立筒仓"/>立筒仓
					<input name="mainBintype" class="myinput" type="checkbox" style="width:30px" value="其他"/>其他
				</td>
			</tr>
			<tr>
				<th>主要收购或加工粮种：</th>
				<td>
					<input name="majorkindofpurchase" type="checkbox" style="width:30px" value="小麦"/>小麦
					<input name="majorkindofpurchase" type="checkbox" style="width:30px" value="稻谷"/>稻谷
					<input name="majorkindofpurchase" type="checkbox" style="width:30px" value="玉米"/>玉米
					<input name="majorkindofpurchase" type="checkbox" style="width:30px" value="豆类"/>豆类
					<input name="majorkindofpurchase" type="checkbox" style="width:30px" value="油料"/>油料
					<input name="majorkindofpurchase" type="checkbox" style="width:30px" value="其他"/>其他
				</td>
			</tr>
			<tr>
				<th>海拔高度:</th>
				<td><input id="altitude" name="altitude" class="myinput" type="text" style="width:150px"/>米</td>
			</tr>
			<tr>
				<th>GPS:</th>
				<td>GPS(E)<input id="longitude" name="longitude" class="myinput" type="text" style="width:150px"/>、
					GPS(N)<input id="latitude" name="latitude" class="myinput" type="text" style="width:150px"/>
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="doAdd()" iconCls="icon-save">添加</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="goback()" iconCls="icon-back">返回</a>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>