<%@ page language="java" import="java.util.*,com.grain.util.JsonUtils" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript">
var graindepotdirects =<%= JsonUtils.toJson( request.getAttribute("Graindepotdirect")) %>

$().ready(function() {
	console.info(graindepotdirects);
	//储粮区 combobox
	$('#graindirect').combobox({    
	    url:'getGraindirect',    
	    valueField:'id',    
	    textField:'fullname',
	    onSelect: function(rec){    
	    	$('#graindepotid').combobox({
      		  url : 'getGraindepot?graindirectionid=' + rec.id
      		  //queryParams:{ graindirectionid : rec.id}
      	  });
	    }
	}); 
	
 	//粮库列表 combobox
	$('#graindepotid').combobox({    
	    //url:'getGraindepot',    
	    valueField:'lkbm',    
	    textField:'lkmc',
	}); 
 	
	var $inputForm = $("#inputForm");
	
	
	
	// 表单验证
	$inputForm.validate({
		rules: {
			username: {required:true,
				remote: {
					url: "check_username",
					cache: false
				}
			},
			pass: {
				required: true,
				pattern: /^[^\s&\"<>]+$/,
				minlength: 4,
				maxlength: 20
			},
			rePass: {
				required: true,
				equalTo: "#pass"
			},
			hasaudit:	{required:true},
			manager:	{required:true},
			graindepotid:	{required:true},
		},
 		submitHandler: function() {
			$.ajax({
				url : 'addDepotUser',//$inputForm.attr("action"),
				data :/* {
					username:$("#username").val(),
					realname:$("#realname").val(),
					//graindepot:$("#graindepot").combobox('getValue'),
					pass:$("#pass").val(),
					hasaudit:$("#hasaudit").combobox('getValue'),
					manager:$("#manager").combobox('getValue')
					} , *///
					$("#inputForm").serialize(),
				dataType : 'json',
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
	//submit the form
 	doAdd = function(){
		$("#inputForm").submit();
	} 
/* 	window.onunload=function(){
		parent.opener.dataGrid.datagrid('reload');  
	} */
	goback = function(){
		openBlank("<%= request.getContextPath() %>/admin/depot/user/entrance",{} );
	}
</script>	
</head>
<body>
	<div class="container" >
		<br>&nbsp;&nbsp;&nbsp;&raquo;添加库管员
		<form id="inputForm"   method="post" >
			<table class="input tabContent">
				<tr><th><span class="requiredField">*</span> 用户名：</th><td><input type="text" name="username" class="text" /></td></tr>
				<tr><th> 真实姓名：</th><td><input type="text" name="realname" class="text" /></td></tr>
				<tr><th> 储粮区：</th> <td><input id="graindirect" name="graindirect" ></td></tr>
				<tr><th><span class="requiredField">*</span> 粮库：</th><td><input id="graindepotid" name="graindepotid" ></td></tr>
				<tr><th><span class="requiredField">*</span> 密码：</th><td><input type="text" id="pass" name="pass" class="text" /></td></tr>
				<tr><th><span class="requiredField">*</span> 确认密码：</th><td><input type="text" id="rePass" name="rePass" class="text" /></td></tr>
				<tr><th> 职称：</th><td><input type="text" name="title" class="text"  /></td></tr>
				<tr><th> 手机：</th><td><input type="text" name="mobile" class="text"  /></td></tr>
				<tr><th><span class="requiredField">*</span> 审核：</th><td><input type="text" name="hasaudit" class="easyui-combobox" 
					data-options="valueField:'id',textField:'value',data: [ {id: '0',value: '否'	,selected:true},{	id: '1',	value: '是'	} ]"/></td></tr>
				<tr><th><span class="requiredField">*</span> 所长：</th><td><input type="text" name="manager" class="easyui-combobox" 
					data-options="valueField:'id',textField:'value',data: [ {id: '0',value: '否'	,selected:true},{	id: '1',	value: '是'	} ]"/></td></tr>

				<tr><th>&nbsp;</th>
				<td >
				<!--  <input type="submit" class="button" value="save" /> -->
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="doAdd()" iconCls="icon-save">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="goback()" iconCls="icon-back">返回</a>
				</td>
				</tr>	
			</table>	
		</form>
	</div>
</body>
</html>