<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/ztree/js/jquery.ztree.excheck.js"></script>
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/resources/ztree/css/zTreeStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript">
// 下拉框ztree框架设置
		var ztree_setting = {
			check: {
				enable: false,
				chkboxType: { "Y": "", "N": "" } 
			},
			data: {
				key:{
					name :"proctype"
				},
				simpleData: {
					enable: true,
					idKey: "sm",
					pIdKey: "_parentId"
				}	
			},
			async: {
					enable: true, //启用异步加载
					url:getUrl //调用的后台的方法
			},
			callback: {
					beforeExpand: beforeExpand,
					//beforeClick: beforeClick,
					onClick: onClick,
					onAsyncSuccess: onAsyncSuccess,
					onAsyncError: onAsyncError
			}
		};
		function getUrl(treeId, treeNode){
			return "../process/combotextList?sm=" + treeNode.sm;
		};
		function beforeExpand(treeId, treeNode) {
			if (!treeNode.isAjaxing) {
				ajaxGetNodes(treeNode, "refresh");
				return true;
			} else {
				parent.$.messager.alert('下拉选择框','zTree 正在下载数据中，请稍后展开节点');
				return false;
			}
		};
		function onAsyncSuccess(event, treeId, treeNode, msg) {
			if (!msg || msg.length == 0) {
				return;
			}
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.updateNode(treeNode);
			zTree.selectNode(treeNode.children[0]);
		}
		function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			parent.$.messager.alert('下拉选择框', '异步获取数据出现异常。', 'error');
			zTree.updateNode(treeNode);
		}
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
 			$("table input[type=checkbox]").each(function(){
 				if ($(this).attr("checked"))
 					$(this).val(1);
 				else
 					$(this).val(0);
 			});
 			var data=$("#inputForm").serialize();
 			data = data.replace(/\+/g," "); // g表示对整个字符串中符合条件的都进行替换
			$.ajax({
				url : 'update',//$("#inputForm").attr("action"),
				data : data, //$("#inputForm").serialize(),
				dataType : 'json',
/*  				contentType: false,  
		        processData: false,   */
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
	
	var options = {
			height: "350px",
			items: [
				"source", "|", "undo", "redo", "|", "preview", "print", "template", "cut", "copy", "paste",
				"plainpaste", "wordpaste", "|", "justifyleft", "justifycenter", "justifyright",
				"justifyfull", "insertorderedlist", "insertunorderedlist", "indent", "outdent", "subscript",
				"superscript", "clearhtml", "quickformat", "selectall", "|", "fullscreen", "/",
				"formatblock", "fontname", "fontsize", "|", "forecolor", "hilitecolor", "bold",
				"italic", "underline", "strikethrough", "lineheight", "removeformat", "|", "image",
				"flash", "media", "insertfile", "table", "hr", "emoticons", "baidumap", "pagebreak",
				"anchor", "link", "unlink"
			],
			langType: grainInsects.locale,
			syncType: "form",
			filterMode: false,
			pagebreakHtml: '<hr class="pageBreak" \/>',
			allowFileManager: true,
			filePostName: "file",
			fileManagerJson: grainInsects.base + "/admin/file/browser",
			uploadJson: grainInsects.base + "/admin/file/upload",
			uploadImageExtension: setting.uploadImageExtension,
			uploadFlashExtension: setting.uploadFlashExtension,
			uploadMediaExtension: setting.uploadMediaExtension,
			uploadFileExtension: setting.uploadFileExtension,
			extraFileUploadParams: {
				token: getCookie("token")
			},
			afterChange: function() {
				this.sync();
			}
		};
		
		var editorList = new Array();
		if(typeof(KindEditor) != "undefined") {
			KindEditor.ready(function(K) {
				editorList[0]=K.create("#processeditor",options);
				editorList[1]=K.create("#noteeditor",options);
			});
		};
		
		var urlAddr = '${pageContext.request.contextPath}/admin/process/combotextList';
		$.getJSON(urlAddr, function(json) {
			$.fn.zTree.init($("#treeDemo"), ztree_setting, json);
		});
		
		//设置隐藏属性procId的值
		var initProctypeid = '${preventprocess.TProctype.sm}';
		$("#proctypeid").attr("value", initProctypeid);
});
	//submit the form
 	doAdd = function(){
		$("#inputForm").submit();
	}; 
	
	goback = function(){
		window.history.back();
	};
	
	function ajaxGetNodes(treeNode, reloadType) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			if (reloadType == "refresh") {
				zTree.updateNode(treeNode);
			}
			zTree.reAsyncChildNodes(treeNode, reloadType, true);
	};
	function onClick (e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes();
			//只允许单选，多选取第一个
			var v;
			if(nodes.length>0)
				v = nodes[0].proctype;
			var cityObj = $("#proctypeSel");
			cityObj.attr("value", v);
			$("#proctypeid").attr("value",nodes[0].sm);
	};
	 function showMenu() {
			var cityObj = $("#proctypeSel");
			var cityOffset = $("#proctypeSel").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		};

	hideMenu = function () {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		};
	onBodyDown = function (event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
</script>	
</head>
<body >
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false" title="知识库  > 防治技术 > 编辑 ">
		<form id="inputForm"    method="post" enctype="multipart/form-data">
		<input type="hidden" name="procId" id="proctypeid"/>
			<ul id="tab" class="tab">
				<li>
					<input class="text" type="button" value="基本情况" />
				</li>
				<li><span class="requiredField">&nbsp;*</span>
					<input class="text" type="button" value="工艺过程" />
				</li>
				<li>
					<input class="text" type="button" value="备注" />
				</li> 
			</ul>	
			<!-- 基本情况 -->		
			<table class="input tabContent">
				<tr><th><span class="requiredField">*</span> 工艺编码：</th> <td><input type="text" name="sm" value="${preventprocess.sm}" maxlength="10"></td></tr>
				<tr><th><span class="requiredField">*</span> 工艺名称：</th> <td><input type="text" name="proname" value="${preventprocess.proname}" maxlength="60" style="width: 400px;"></td></tr>
				<tr><th> 工艺类型：</th>
					<td colspan="3"><input id="proctypeSel" type="text" readonly value="${preventprocess.TProctype.proctype}" style="width:120px;"/>&nbsp;<a id="menuBtn" href="javascript:void(0);" onclick="showMenu(); return false;">选择</a>
						<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
							<ul id="treeDemo" class="ztree" style="margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:220px;overflow-y:scroll;overflow-x:auto;"></ul>
						</div>
					</td>
				</tr>
				<tr><th><span class="requiredField">*</span> 关键词：</th><td><input type="text" name="keywords" value="${preventprocess.keywords}" class="text" maxlength="200" style="width: 400px;"/></td></tr>
				<tr><th> 材料：</th><td><input type="text" name="material" value="${preventprocess.material}" class="text" maxlength="200" style="width: 400px;"/></td></tr>
				<tr><th> 处理方式：</th><td><input type="text" class="text" name="procway" value="${preventprocess.procway}" maxlength="200" style="width: 400px;"/></td></tr>
				<tr><th><span class="requiredField">*</span> 区域：</th><td><input type="text" name="area" value="${preventprocess.area}" class="text" maxlength="200" style="width: 400px;"/></td></tr>
				<tr><th><span class="requiredField">*</span> 季节：</th><td><input type="text" name="seasion" value="${preventprocess.seasion}" class="text" maxlength="60" style="width: 400px;"/></td></tr>
				<tr><th> 资料来源：</th><td><input type="text" name="source" value="${preventprocess.source}" class="text" maxlength="100"/></td></tr>
				<tr><th> 修改人：</th> <td>${preventprocess.modifer}</td><th> 修改时间：</th> <td>${preventprocess.modifydate}</td></tr>
			</table>
			<!-- 工艺过程 -->
			<table class="input tabContent">
				<tr>
					<td>
						<textarea id="processeditor" name="process" style="width: 98%;">${preventprocess.process}</textarea>
					</td>
				</tr>
			</table>
			<!-- 备注 -->
			<table class="input tabContent">
				<tr>
					<td>
						<textarea id="noteeditor" name="note" style="width: 98%;">${preventprocess.note}</textarea>
					</td>
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
	</div>
</body>