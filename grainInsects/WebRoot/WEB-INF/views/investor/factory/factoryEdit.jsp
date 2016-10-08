<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- doctype一定要写在这个位置 -->
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
		table.input {
			width: 100%;
			word-break: break-all;
		}
	</style>
	<script type="text/javascript">
	
		//submit the form
	 	doEdit = function(){
			$("#inputForm").submit();
		} 
		$(function(){
			var $inputForm = $("#inputForm");
			
			// 表单验证
			$inputForm.validate({
				rules: {
					smFactory: "required",
				},
				submitHandler: function() {
					var formData = new FormData($("#inputForm")[0]); 
					$.ajax({
						url : 'factoryEdit',
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
		})
		
		goback = function(){
			window.history.back();
		}
	</script>
</head>
<body>			
	<div class="path">路径>>编辑加工厂信息</div>
	<div class="container" >
		<form id="inputForm"  method="post">
			<table class="input">
				<tr>
					<th><span class="requiredField">*</span>加工厂编号：</th>
					<td><input name="smFactory" class="myinput" type="text" readonly="readonly" style="width:90px" value="${factory.smFactory }"/></td>
				</tr>
				<tr>
					<th>工厂名称：</th>
					<td><input name="nameFactory" class="myinput" type="text" style="width:200px" value="${factory.nameFactory }"/></td>
				</tr>
				<tr>
					<th>邮编：</th>
					<td><input id="postcode" type="text" name="postcode" class="myinput" maxlength="10" value="${factory.postcode }" style="width:50px;"/></td>
				</tr>
				<tr>
					<th>地址：</th>
					<td><input name="address" class="myinput" type="text" style="width:200px" value="${factory.address }"/></td>
				</tr>
				<tr>
					<th>联系人：</th>
					<td>
						<input name="contacts" class="myinput" type="text" style="width:90px" value="${factory.contacts }"/>
					</td>
				</tr>
				<tr>
					<th>联系电话：</th>
					<td>
						<input name="phone" class="myinput" type="text" style="width:200px" value="${factory.phone }"/>
					</td>
				</tr>
				<tr>
					<th>建厂（所）时间:</th>
					<td>
						<input name="constructiondate" class="easyui-datebox" type="text" style="width:150px" value="${factory.constructiondate }"/>
					</td>
				</tr>
				<tr>
					<th>收购/加工量：</th>
					<td>
						<input name="annualpurchase" class="myinput" type="text" style="width:90px" value="${factory.annualpurchase }"/>（吨/年）
					</td>
				</tr>
				<tr>
					<th>主要仓型：</th>
					<td>
						<input name="mainBintype" class="myinput" type="checkbox" <c:if test='${factory.mainBintype.contains("房式仓") }'> checked="true" </c:if> style="width:30px" value="房式仓"/>房式仓
						<input name="mainBintype" class="myinput" type="checkbox" <c:if test='${factory.mainBintype.contains("浅圆仓") }'> checked="true" </c:if> style="width:30px" value="浅圆仓"/>浅圆仓
						<input name="mainBintype" class="myinput" type="checkbox" <c:if test='${factory.mainBintype.contains("立筒仓") }'> checked="true" </c:if> style="width:30px" value="立筒仓"/>立筒仓
						<input name="mainBintype" class="myinput" type="checkbox" <c:if test='${factory.mainBintype.contains("其他") }'> checked="true" </c:if> style="width:30px" value="其他"/>其他
					</td>
				</tr>
				
				<tr>
					<th>主要收购或加工粮种：</th>
					<td>
						<input name="majorkindofpurchase" type="checkbox" <c:if test='${factory.majorkindofpurchase.contains("小麦") }'> checked="true" </c:if> style="width:30px" value="小麦"/>小麦
						<input name="majorkindofpurchase" type="checkbox" <c:if test='${factory.majorkindofpurchase.contains("稻谷") }'> checked="true" </c:if> style="width:30px" value="稻谷"/>稻谷
						<input name="majorkindofpurchase" type="checkbox" <c:if test='${factory.majorkindofpurchase.contains("玉米") }'> checked="true" </c:if> style="width:30px" value="玉米"/>玉米
						<input name="majorkindofpurchase" type="checkbox" <c:if test='${factory.majorkindofpurchase.contains("豆类") }'> checked="true" </c:if> style="width:30px" value="豆类"/>豆类
						<input name="majorkindofpurchase" type="checkbox" <c:if test='${factory.majorkindofpurchase.contains("油料") }'> checked="true" </c:if> style="width:30px" value="油料"/>油料
						<input name="majorkindofpurchase" type="checkbox" <c:if test='${factory.majorkindofpurchase.contains("其他") }'> checked="true" </c:if> style="width:30px" value="其他"/>其他
					</td>
				</tr>
				<tr>
					<th>海拔高度：</th>
					<td>
						<input name="altitude" type="text" class="myinput" style="width:150px;" value="${factory.altitude }"/>米
					</td>
				</tr>
				<tr>
					<th>GPS:</th>
					<td>GPS(E)<input name="longitude" class="myinput" type="text" style="width:150px" value="${factory.longitude }"/>、
						GPS(N)<input name="latitude" class="myinput" type="text" style="width:150px" value="${factory.latitude }"/>
					</td>
				</tr>
				<tr><th>&nbsp;</th>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton"
								plain="false" onclick="doEdit()" iconCls="icon-save">修改</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"
								plain="false" onclick="goback()" iconCls="icon-back">返回</a>
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>