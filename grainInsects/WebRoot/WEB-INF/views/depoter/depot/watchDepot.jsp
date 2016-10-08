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
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	// 表单验证
	$inputForm.validate({
		rules: {
			lkmc: {required:true},
			postcode:{digits:true},
			hasreal:{required:true}
		},
		submitHandler: function() {
			$.ajax({
				url : 'editDepot',
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
<body>
	<div class="container" >
		<br>&nbsp;&nbsp;&nbsp;&raquo;修改粮库信息
		<form id="inputForm"  method="post" >
			<table class="input">
				<tr><th><span class="requiredField">*</span> 粮库编码：</th><td><input type="text" name="lkbm" class="text" value="${graindepot.lkbm }"  readonly="readonly"/></td></tr>
				<tr><th><span class="requiredField">*</span> 粮库名称：</th><td><input type="text" name="lkmc" class="text" value="${graindepot.lkmc }"  readonly="readonly"/></td></tr>
				<tr><th> 储粮区：</th> <td><input id="graindirect" name="graindirect" type="text" value="${graindepot.area.gd.fullname}" readonly="readonly"></td></tr>
				<tr><th><span class="requiredField">*</span> 粮库所在地区：</th> <td><input id="area" name="areaid" type="text" 
																	value="${graindepot.area.fullName }" readonly="readonly"></td></tr>
				<tr><th> 粮库地址：</th><td><input type="text" name="lkdz" class="text" value="${graindepot.lkdz }"  readonly="readonly"/></td></tr>
				<tr><th> 邮编：</th><td><input type="text" name="postcode" class="text" value="${graindepot.postcode }"  readonly="readonly"/></td></tr>
				<tr><th> 联系人：</th><td><input type="text" name="contact" class="text" value="${graindepot.contact }"  readonly="readonly"/></td></tr>
				<tr><th> 手机：</th><td><input type="text" name="phone" class="text" value="${graindepot.phone }"  readonly="readonly"/></td></tr>
				<tr><th> 经度：</th><td><input type="text" name="longtitude" class="text" value="${graindepot.longtitude }"  readonly="readonly"/></td></tr>
				<tr><th> 纬度：</th><td><input type="text" name="latitude" class="text" value="${graindepot.latitude }"  readonly="readonly"/></td></tr>
				<tr><th> 高程：</th><td><input type="text" name="altitude" class="text" value="${graindepot.altitude }"  readonly="readonly"/></td></tr>
				<tr><th> 粮仓数：</th><td><input type="text" name="totalbin" class="text" value="${graindepot.totalbin }"  readonly="readonly"/></td></tr>
				<tr><th><span class="requiredField">*</span> 是否实时采集数据：</th><td>
					<select name="hasreal" onfocus="this.defaultIndex=this.selectedIndex;" onchange="this.selectedIndex=this.defaultIndex;">
						<option value=0 <c:if test="${!graindepot.hasreal}"> selected="true" </c:if> >否</option>
						<option value=1 <c:if test="${graindepot.hasreal}"> selected="true" </c:if> >是</option>
					</select></td>
				<tr><th>&nbsp;</th>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>