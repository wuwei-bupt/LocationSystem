<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<script type="text/javascript">
	var base = "<%= request.getContextPath() %>";
</script>
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $binImageTable = $("#binImageTable");
	var $addBinImage = $("#addBinImage");
	var $deleteBinImage = $("a.deleteProductImage");
	var binImageIndex = 0;
	
	// 增加商品图片
	$addBinImage.click(function() {
			var trHtml = 
			'<tr>' +
				'<td>' +
					'<input type="file" name="bintypePics[' + binImageIndex + '].file" class="productImageFile" />' + 
				'</td>' + 
				'<td>' +
					'<input type="text" name="bintypePics[' + binImageIndex + '].title" class="text" maxlength="200" />' +
				'</td>' +
		 		'<td>' +
					'<input type="text" name="bintypePics[' + binImageIndex + '].order" class="text productImageOrder" maxlength="9" style="width: 50px;"/>'+
				'</td>' + 
				'<td> ' +
					'<a href="javascript:;" class="deleteProductImage" style="width:50px,align:left" >[ 删除 ]</a>' +
				'</td> ' +
			'</tr>';
		$binImageTable.append(trHtml);
		binImageIndex ++;
	});
	
	// 删除商品图片
	$deleteBinImage.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该仓型图片吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});

	var $depotuserTable = $("#depotuserTable");
	var $addDepotuser = $("#addDepotuser");
	var $selectdepotuser = $("#depotuser");
	var $deleteDepotuser = $("a.deleteDepotuser");
	
	// 增加库管员
	$addDepotuser.click(function() {
		var trHtml = 
			'<tr>' +
 				'<td>' +
					'<select id="depotuser" name="usernames" style="width:250px;" >' + 
					'<c:forEach var="user" items="${nousedusers}" begin="0">' +
					'<option value="${user.username}">${user.username} , ${user.realname} , ${user.title} , ${user.manager} , ${user.mobile}</option>' +
					'</c:forEach>' +
					'</select>' +
				'</td>' +  
				'<td id="realname" class="text">' +'</td>' +
				'<td id="title" class="text">' +'</td>' +
				'<td id="manager" class="text">' +'</td>' +
				'<td id="mobile" class="text">' +'</td>' +
				'<td> ' +
					'<a href="javascript:;" class="deleteDepotuser" style="width:50px,align:left" >[ 删除 ]</a>' +
				'</td> ' +
			'</tr>';
		$depotuserTable.append(trHtml);
	});
	
	// 删除库管员
	$deleteDepotuser.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该库管员吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
	
 	$selectdepotuser.live("change", function(value) {
		var $this = $(this);
		var select=$this.closest("tr").find("#depotuser")[0];
		var value = select.value;
		var index=select.selectedIndex; //序号，取当前选中选项的序号
		var text = select.options[index].text;
		var str= text.split(","); //字符分割 

		$this.closest("tr").find("#realname").html(str[1]);
		$this.closest("tr").find("#title").html(str[2]);
		$this.closest("tr").find("#manager").html(str[3]);
		$this.closest("tr").find("#mobile").html(str[4]);
	}); 
 	
	// 表单验证
	$inputForm.validate({
		rules: {
			lcbm: {
				required:true,
				minlength: 4,
				maxlength: 60,
/* 				remote: {
					url: "check_lcbm",
					cache: false
				} */
			},
			orientation: {
				number: true,
			},
			longth: {
				number: true,
			},
			width: {
				number: true,
			},
			height: {
				number: true,
			},
			typebin: {required:true}
		},
		messages: {
			orientation: "请输入小数",
			longth: "请输入小数",
			width: "请输入小数",
			height: "请输入小数",
		},
		submitHandler: function() {
			var formData = new FormData($( "#inputForm" )[0]); 
			$.ajax({
				url : 'addBin',
				data : formData,	//$("#inputForm").serialize(),
				dataType : 'json',
			/* 	async: false,  
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
	//submit the form
 	doAdd = function(){
		
		$("#inputForm").submit();
	} 
	
/* 	window.onunload=function(){
		parent.opener.depotdg.datagrid('reload');  
	} */
	goback = function(){
		openBlank("<%= request.getContextPath() %>/admin/depot/depot/entrance",{} );
	}
</script>	
</head> <title>增加粮仓</title>
<body>
	<div class="container" >
		<br>&nbsp;&nbsp;&nbsp;&raquo;增加粮仓
		<form id="inputForm"  method="post" enctype="multipart/form-data">
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本信息" />
				</li>
				<li>
					<input type="button" value="其他设施" />
				</li>
				<li>
					<input type="button" value="仓型图片" />
				</li>
				<li>
					<input type="button" value="库管员" />
				</li>
			</ul>
			<table class="input tabContent">
				<tr><th> 粮库编码：</th><td><input type="text" name="lkbm" value="${lkbm }" readonly="readonly" class="text" /></td></tr>
				<tr><th> 粮库名称：</th><td><input type="text" name="lkmc" value="${lkmc }" readonly="readonly" class="text" /></td></tr>
				<tr><th><span class="requiredField">*</span> 粮仓编码：</th><td><input type="text" name="lcbm" class="text" value=" "/></td></tr>
				<tr><th>粮仓名：</th><td><input type="text" name="binname" class="text" value=" "/></td></tr>
				<tr><th><span class="requiredField">*</span> 粮仓类型：</th><td><input type="text" name="typebin" class="text" maxlength="20"/></td></tr>
				<tr><th> 设计容量：</th> <td><input name="capacity" type="text" class="text" ></td></tr>
				<tr><th> 朝向：</th> <td><input name="orientation" type="text" class="text" ></td></tr>
				<tr><th> 廒间数：</th> <td><input name="granarynum" type="text" class="text" ></td></tr>
				<tr><th> 仓体结构：</th> <td><input name="structureofbody" type="text" class="text" maxlength="60"></td></tr>
				<tr><th> 顶仓结构：</th><td><input type="text" name="structureofroof" class="text" maxlength="60"/></td></tr>
				<tr><th> 设计单仓容量(T)：</th><td><input type="text" name="designcapacity" class="text" value="1000"/></td></tr>
				<tr><th> 设计粮堆高度(m)：</th><td><input type="text" name="designgrainheapheight" class="text" value="100"/></td></tr>
				<tr><th> 长(m)：</th><td><input type="text" name="longth" class="text" value="100"/></td></tr>
				<tr><th> 宽(m)：</th><td><input type="text" name="width" class="text" value="100"/></td></tr>
				<tr><th> 高(m)：</th><td><input type="text" name="height" class="text" value="100"/></td></tr>
				
				<tr><th> 环流装置：</th><td><input type="text" name="circulatedevice" class="text" maxlength="100"/></td></tr>
				<tr><th> 环流风机：</th><td><input type="text" name="Circulatefan" class="text" maxlength="100"/></td></tr>
				<tr><th> 仓房风道：</th><td><input type="text" name="fanway" class="text" maxlength="100"/></td></tr>
				<tr><th> 联系人：</th><td><input type="text" name="contract" class="text" /></td></tr>
				<tr><th> 联系电话：</th><td><input type="text" name="phone" class="text"/></td></tr>
				<tr><th> 备注：</th><td><input type="text" name="note" class="text" /></td></tr>
			</table>
			<table class="input tabContent">
				<tr>
					<td>
						<textarea id="editor" name="elsedevice" class="editor" style="width: 100%;"></textarea>
					</td>
				</tr>
			</table>
			<table id="binImageTable" class="input tabContent">
				<tr>
					<td colspan="4">
						<a href="javascript:;" id="addBinImage" class="button">增加仓型图片</a>
					</td>
				</tr>
				<tr class="title">
					<td >仓型图片</td>
					<td >标题</td>
					<td >排序</td>
					<td >操作</td>
				</tr>
			</table>
			<table id="depotuserTable" class="input tabContent">
				<tr>
					<td colspan="5">
						<a href="javascript:;" id="addDepotuser" class="button">增加库管员</a>
					</td>
				</tr>
				<tr class="title">
					<td >用户名</td>
					<td >用户真名</td>
					<td >职称</td>
					<td >所长</td>
					<td >手机</td>
				</tr>
			</table>
			<table class="input">
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