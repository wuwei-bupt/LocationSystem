<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.area.list")} - Powered By Szy++</title>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/list.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $delete = $("#listTable a.delete");
	[@flash_message /]
	
	// 删除
	$delete.click(function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "${message("admin.dialog.deleteConfirm")}",
			onOk: function() {
				$.ajax({
					url: "delete",
					type: "POST",
					data: {sm: $this.attr("val")},
					dataType: "json",
					cache: false,
					success: function(message) {
						$.message(message);
						if (message.type == "success") {
							$this.parent().html("&nbsp;");
						}
					}
				});
			}
		});
		return false;
	});
	
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index">${message("admin.path.index")}</a> &raquo; ${message("admin.proctype.list")}
	</div>
	<div class="bar">
		<a href="add[#if parent??]?parentId=${parent.sm}[/#if]" class="iconButton">
			<span class="addIcon">&nbsp;</span>${message("admin.common.add")}
		</a>
		[#if parent??]
			<div class="pageBar">
				[#if parent.parent??]
					<a href="list?parentId=${parent.parent.sm}" class="iconButton">
						<span class="upIcon">&nbsp;</span>${message("admin.proctype.parent")}
					</a>
				[#else]
					<a href="list" class="iconButton">
						<span class="upIcon">&nbsp;</span>${message("admin.proctype.parent")}
					</a>
				[/#if]
			</div>
		[/#if]
	</div>
	<table id="listTable" class="list">
		<tr>
			<th colspan="5" class="green" style="text-align: center;">
				[#if parent??]${message("admin.proctype.parent")} - ${parent.proctype}[#else]${message("admin.proctype.root")}[/#if]
			</th>
		</tr>
		[#list proctypes?chunk(5, "") as row]
			<tr>
				[#list row as proctype]
					[#if proctype?has_content]
						<td>
							<a href="list?parentId=${proctype.sm}" title="${message("admin.common.view")}">${proctype.proctype}</a>
							<a href="edit?id=${proctype.sm}">[${message("admin.common.edit")}]</a>
							<a href="javascript:;" class="delete" val="${proctype.sm}">[${message("admin.common.delete")}]</a>
						</td>
					[#else]
						<td>
							&nbsp;
						</td>
					[/#if]
				[/#list]
			</tr>
		[/#list]
		[#if !proctypes?has_content]
			<tr>
				<td colspan="5" style="text-align: center; color: red;">
					${message("admin.proctype.emptyChildren")} <a href="add[#if parent??]?parentId=${parent.sm}[/#if]" style="color: gray">${message("admin.common.add")}</a>
				</td>
			</tr>
		[/#if]
	</table>
</body>
</html>