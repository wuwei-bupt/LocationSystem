<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.area.add")} - Powered By Szy++</title>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	
	[@flash_message /]
	
	// 表单验证
	$inputForm.validate({
		rules: {
			sm: "required",
			proctype: "required"
		}
	});
	
});

</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index">${message("admin.path.index")}</a> &raquo; ${message("admin.proctype.add")}
	</div>
	<form id="inputForm" action="save" method="post">
		[#if parent??]
			<input type="hidden" name="parentId" value="${parent.sm}" />
		[/#if]
		<table class="input">
			<tr>
				<th>
					${message("admin.proctype.parent")}:
				</th>
				<td>
					[#if parent??]${parent.proctype}[#else]${message("admin.proctype.root")}[/#if]
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("TProcType.sm")}:
				</th>
				<td>
					<input type="text"  name="sm" class="text" />
				</td>
			</tr>
			
			<tr>
				<th>
					<span class="requiredField">*</span>${message("TProcType.proctype")}:
				</th>
				<td>
					<input type="text"  name="proctype" class="text"  />
				</td>
			</tr>
						
			<tr>
				<th>
					${message("TProcType.source")}:
				</th>
				<td>
					<input type="text" name="source" class="text"  />
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list[#if parent??]?parentId=${parent.sm}[/#if]'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>