<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.area.edit")} - Powered By SHOP++</title>
<meta name="author" content="SHOP++ Team" />
<meta name="copyright" content="SHOP++" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	
	// 表单验证
	$inputForm.validate({
		rules: {
			proctype: "required"
		}
	});
	
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index">${message("admin.path.index")}</a> &raquo; ${message("admin.proctype.edit")}
	</div>
	<form id="inputForm" action="update" method="post">
		<table class="input">
			<tr>
				<th>
					${message("admin.proctype.parent")}:
				</th>
				<td>
					[#if proctype.parent??]${proctype.parent.name}[#else]${message("admin.proctype.root")}[/#if]
				</td>
			</tr>
			
			<tr>
				<th>
					<span class="requiredField">*</span>${message("TProcType.sm")}:
				</th>
				<td>
					<input type="text"  name="sm" value="${proctype.sm}" class="text" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("TProcType.proctype")}:
				</th>
				<td>
					<input type="text" name="proctype" class="text" value="${proctype.proctype}" />
				</td>
			</tr>
			
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list[#if area.parent??]?parentId=${area.parent.id}[/#if]'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>