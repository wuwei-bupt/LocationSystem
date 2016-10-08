<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/resources/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<style>	
	.text.index{
		width: 6em;
	}
	
	#pop-editor {
		border: 2px solid #000;
		border-right: 4px solid #000;
		border-radius: 5px;
		display:none;
		width: 80%;
		position: absolute;
		left: 10%;
		top: 2em;
		background-color: #FFF;
		transition: opacity 1.5s;
	}
	
	#add-photo {
		display:none;
		width: 80%;
		position: absolute;
		left: 10%;
		top: 2em;
		transition: opacity 1.5s;
		background-color: #FFF;
		border: 2px solid #000;
		border-radius: 5px;
	}
</style>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/select2/js/select2.min.js"></script>
<script type="text/javascript">
(function($) {
    $.fn.exist = function(){ 
        if($(this).length>=1){
            return true;
        }
        return false;
    };
})(jQuery);
$().ready(function() {
	var $inputForm = $("#inputForm");
	// 表单验证
	$inputForm.validate({
		rules: {
/* 			pass: {
				pattern: /^[^\s&\"<>]+$/,
				minlength: 4,
				maxlength: 20
			},
			rePass: {
				equalTo: "#pass"
			},
			hasaudit:{required:true},
			manager:{required:true},
			graindepotid:{required:true}, */
		},
 		submitHandler: function() {
 			
 			var formData = new FormData($( "#inputForm" )[0]); 
			$.ajax({
				url : 'addCompany',//$("#inputForm").attr("action"),
				data : formData, //$("#inputForm").serialize(),
				dataType : 'json',
  				contentType: false,  
		        processData: false,
				success : function(r) {
					if (r && r.success) {
						parent.$.messager.alert('提示', r.msg); //easyui中的控件messager
						goback();
					} else {
						parent.$.messager.alert('数据更新或插入', r.msg, 'error'); //easyui中的控件messager
					}
				}
			});
		} 
	});
	
	// 删除index
	$deleteSpecification.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该害虫检索特征吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
	
}); 
	//submit the form
 	doAdd = function(){
		$("#inputForm").submit();
	} 
	
	goback = function(){
		window.history.back();
	}

</script>	
</head>
<body >
	<div class="container" >
		<br>&nbsp;&nbsp;&nbsp;&raquo;添加单位
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
			</ul>			
			<table class="input tabContent">
				<tr><th> 单位编码：</th><td colspan="3"><input type="text" name="coding" class="text" maxlength='10'></td></tr>
				<tr><th><span class="requiredField">*</span> 单位名称：</th><td colspan="3"><input type="text" name="company" class="text"  maxlength='100'></td></tr>
			</table>

			<table class="input">
				<tr><td>&nbsp;</td>
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