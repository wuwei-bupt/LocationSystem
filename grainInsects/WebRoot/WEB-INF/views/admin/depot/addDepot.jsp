<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
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
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $browserButton = $("#browserButton");
	$browserButton.browser({
		type: "image",
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			lkbm: {required:true},
			lkmc: {required:true},
			areaid: {required:true,digits:true},
			postcode:{digits:true},
			hasreal:{required:true}
		},
		submitHandler: function() {
			$.ajax({
				url : 'addDepot',
				data : $("#inputForm").serialize(),
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
	
	
	//储粮区 combobox
	$('#graindirect').combobox({    
	    url:'getGraindirect',    
	    valueField:'id',    
	    textField:'fullname',
	    onSelect: function(rec){    
	    	$('#area').combobox({
      		  url : 'getArea?graindirectionid=' + rec.id
      		  //queryParams:{ graindirectionid : rec.id}
      	  });
	    }
	}); 
	
	//地区 combobox
	$('#area').combobox({    
	    valueField:'id',    
	    textField:'fullname',
	});  
	
});
	//submit the form
 	doAdd = function(){
		$("#inputForm").submit();
	} 
	
	goback = function(){
		openBlank("<%= request.getContextPath() %>/admin/depot/depot/entrance",{} );
	}
</script>	
</head>
<body>
	<div class="container" >
		<br>&nbsp;&nbsp;&nbsp;&raquo;新增粮库
		<form id="inputForm"  method="post" >
			<table class="input">
				<tr><th><span class="requiredField">*</span> 粮库编码：</th><td><input type="text" name="lkbm" class="text" value=" "/></td></tr>
				<tr><th><span class="requiredField">*</span> 粮库名称：</th><td><input type="text" name="lkmc" class="text" value=" "/></td></tr>
				<tr><th> 储粮区：</th> <td><input id="graindirect" name="graindirect" ></td></tr>
				<tr><th><span class="requiredField">*</span> 粮库所在地区：</th> <td><input id="area" name="areaid"  ></td></tr>
				<tr><th> 图片：</th>
				<td>
					<span class="fieldSet">
						<input type="text" name="pic" class="text" maxlength="256" />
						<input type="button" id="browserButton" class="button" value="选择文件" />
					</span>
				</td></tr>
				<tr><th> 粮库地址：</th><td><input type="text" name="lkdz" class="text" value="10000"/></td></tr>
				<tr><th> 邮编：</th><td><input type="text" name="postcode" class="text" value="10000"/></td></tr>
				<tr><th> 联系人：</th><td><input type="text" name="contact" class="text" value="10000"/></td></tr>
				<tr><th> 手机：</th><td><input type="text" name="phone" class="text" value="10000"/></td></tr>
				<tr><th> 经度：</th><td><input type="text" name="longtitude" class="text" value="10000"/></td></tr>
				<tr><th> 纬度：</th><td><input type="text" name="latitude" class="text" value="10000"/></td></tr>
				<tr><th> 高程：</th><td><input type="text" name="altitude" class="text" value="10000"/></td></tr>
				<tr><th> 粮仓数：</th><td><input type="text" name="totalbin" class="text" value="10000"/></td></tr>
				<tr><th><span class="requiredField">*</span> 是否实时采集数据：</th><td><input type="text" name="hasreal" class="easyui-combobox" 
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