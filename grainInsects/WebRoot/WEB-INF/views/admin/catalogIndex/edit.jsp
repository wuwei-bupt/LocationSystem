<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>害虫类别</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<script type="text/javascript">
	var base = "<%= request.getContextPath() %>";
</script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/ztree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/easyUI/datagrid-detailview.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/select2/js/select2.min.js"></script>

<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/resources/ztree/css/zTreeStyle.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/resources/select2/css/select2.min.css" rel="stylesheet" type="text/css" />

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style type="text/css">
	.specificationSelect {
		height: 100px;
		padding: 5px;
		overflow-y: scroll;
		border: 1px solid #cccccc;
	}
	
	.specificationSelect li {
		float: left;
		min-width: 150px;
		_width: 200px;
	}
	
	.datagrid-row-detail div {
		line-height: 600px;
	}
	
	textarea{
		padding:0 0 0 0px;
		border: 1px solid #cccccc;
	}
</style>
<script type="text/javascript">
// 下拉框ztree框架设置
		var ztree_setting = {
			check: {
				enable: false,
				chkboxType: { "Y": "", "N": "" } 
			},
			data: {
				key:{
					name :"mc"
				},
				simpleData: {
					enable: true,
					idKey: "id",
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
			if(treeNode!=null && treeNode != undefined)
				return "../catalogIndex/ztreeList?id=" + treeNode.id;
			else
				return "../catalogIndex/ztreeList";
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
			parent.$.messager.alert('数据更新或插入', "异步获取数据出现异常。", 'error');
			zTree.updateNode(treeNode);
		}
$().ready(function() {
	var urlAddr = '${pageContext.request.contextPath}/admin/catalogIndex/ztreeList';
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
			zylb:{required:true}
		},
 		submitHandler: function() {
 			var getdfRows = $('#digitalFeatureTable').datagrid('getRows');
 			var dfRowsIds = [];
	 		getdfRows.forEach(function(getdfRow){
				dfRowsIds.push(getdfRow["id"]);
					//console.log(JSON.stringify(getdfRow));
			});
			//if($("#digitalFeatureIds").val().length<dfRowsIds.length)
 			$("#digitalFeatureIds").attr("value",dfRowsIds);
			//$("td[field]").closest("tr").remove();
 			var formData = new FormData($( "#inputForm" )[0]);
			$.ajax({
				url : 'editCatalogIndex',//$("#inputForm").attr("action"),
				data : formData, //$("#inputForm").serialize(),
				dataType : 'json',
/*  				contentType: false,  
		        processData: false,   */
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
	
	var $binImageTable = $("#binImageTable");
	var $addBinImage = $("#addBinImage");
	var $deleteBinImage = $("#deleteBinImage");
	var binImageIndex = "${picTotal}";
	
	var $basicInformation = $("#basicInformation");
	var $diffFeature = $("#diffFeature");
	var $digitalFeature = $("#digitalFeature");
	
	var $expertAudit = $('#expertAudit');
	
	var digitalFeatureTableClickCount = 0;
	
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
	
	var optionsReadOnly = {
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
			readonlyMode : true,
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
			editorList[0]=K.create("#tzeditor",options);
			editorList[1]=K.create("#shxxeditor",options);
			editorList[2]=K.create("#fbeditor",options);
			editorList[3]=K.create("#wheditor",options);
			editorList[4]=K.create("#mseditor",options);
			editorList[5]=K.create("#auditadviceeditor",optionsReadOnly);
		});
	};
	
	$basicInformation.click(function(){
		$(".datagrid").hide();
		$("#saveIndex").show();
		$("#expertAuditTable").hide();
	});
	
	$diffFeature.click(function(){
		$(".datagrid").hide();
		$("#saveIndex").show();
		$("#expertAuditTable").hide();
	});
	
	$expertAudit.click(function(){
		$(".datagrid").hide();
		$("#saveIndex").hide();
		$("#expertAuditTable").show();
	});
	
	$digitalFeature.click(function(){
		$(".datagrid").show();
		$("#saveIndex").hide();
		$("#expertAuditTable").hide();
		//初始化数据
		if(digitalFeatureTableClickCount==0){
        	$.getJSON("${pageContext.request.contextPath}/admin/catalogIndex/getTDigitalFeatures?id="+'${cid}', function(result) {
        		rows = result.rows;
	        	$("#digitalFeatureTable").datagrid('loadData', rows);
	 		});
	 		digitalFeatureTableClickCount =1;
        }
	});
	// 增加图片
	$addBinImage.click(function() {
			var trHtml = 
			'<tr>' +
				'<td>' +
					'<input type="file" name="TCatalogPics[' + binImageIndex + '].file" class="productImageFile" />' + 
				'</td>' + 
				'<td>' +
					'<input type="text" name="TCatalogPics[' + binImageIndex + '].title" class="text" maxlength="200" />' +
				'</td>' +
				'<td>' +
					'<input type="text" name="TCatalogPics[' + binImageIndex + '].fromwhere" class="text" maxlength="8" required="true"/>' +
				'</td>' +
		 		'<td>' +
					'<input type="digits" name="TCatalogPics[' + binImageIndex + '].order" class="text productImageOrder" data-options="validType:\'digits\'"/>'+
				'</td>' + 
				'<td> ' +
					'<a href="javascript:;" id="deleteBinImage" class="deleteBinImage" style="width:50px,align:left" >[ 删除 ]</a>' +
				'</td> ' +
			'</tr>';
		$binImageTable.append(trHtml);
		binImageIndex ++;
	});
	
	// 删除图片
	$deleteBinImage.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该图片吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
	
	$digitalFeature.click(function(){
		
		$("#digitalFeatureTable").show();
		
		$('#digitalFeatureTable').datagrid({
			heigth:700,     
        	idField:'id',
        	fitColumns:true,  
        	nowrap:true,  
	        columns:[[ 
	            {field:'id',checkbox:true},  
	            {field:'name',title:'特征名称',width:100,editor:'text',sortable:false},  
	            {field:'value',title:'特征值',width:100,editor:'text',sortable:false},  
	            {field:'indentifyindex',title:'识别顺序',width:100,editor:'text',sortable:false},  
	            {field:'note',title:'说明',width:100,editor:'text',sortable:false},  
	            {field:'source',title:'资料来源',width:100,editor:'text',sortable:false}  
	        ]],
	        toolbar: [{
	        	text:'添加',
				iconCls: 'icon-add',
				handler: addItem
				},'-',{
				text:'删除',
				iconCls: 'icon-remove',
				handler: deleteItem
				}],
			view: detailview,  
        	detailFormatter:function(index,row){ 
            	return '<div id="detailForm-'+index+'" style="line-height:500px;"></div>';  
        	},
       		onExpandRow: function(index,row){
	            var id= $(this).datagrid('getRows')[index].id; 
	            $('#detailForm-'+index).panel({  
	                doSize:true,  
	                border:false,  
	                cache:false,  
	                href: row.isNewRecord ? '${pageContext.request.contextPath}/admin/digitalfeature/addtdigitalfeatureEntrance?index='+index:'${pageContext.request.contextPath}/admin/digitalfeature/editTDigitalFeatureEntrance?id='+id+'&index='+index, 
	                onLoad:function(){
	                    $('#digitalFeatureTable').datagrid('fixDetailRowHeight',index);  
	                    $('#digitalFeatureTable').datagrid('selectRow',index);
	            		var featureeditorname = "#featureeditor" + index;
	            		var noteeditorname = "#noteeditor" + index;
	                    editorList0 = KindEditor.create(featureeditorname,options);
	                    edtiorList1 = KindEditor.create(noteeditorname,options);
	                }  
	            });  
	            $('#digitalFeatureTable').datagrid('fixDetailRowHeight',index);  
        	},
        	onDblClickRow:function(index,row){  
	            $('#digitalFeatureTable').datagrid('expandRow', index);  
	            $('#digitalFeatureTable').datagrid('fitColumns',index);  
	            $('#digitalFeatureTable').datagrid('selectRow', index); 
        	}
		});
		
	});       
	        
	 
	//2级表：数字特征添加按钮触发事件  
	addItem = function (){ 
		//$('#digitalFeatureTable').datagrid('appendRow',{name:''}); 
	    $('#digitalFeatureTable').datagrid('appendRow',{isNewRecord:true}); 
	    var index = $('#digitalFeatureTable').datagrid('getRows').length - 1;  
	    $('#digitalFeatureTable').datagrid('expandRow', index);  
	    $('#digitalFeatureTable').datagrid('fitColumns',index);  
	    $('#digitalFeatureTable').datagrid('selectRow', index);   
	};
	
	deleteItem = function (){  
	     var rows = $('#digitalFeatureTable').datagrid('getSelections');  
	     if (null == rows || rows.length == 0) {  
	        parent.$.messager.alert('提示 ','请选择需要删除的对象');  
	        return;  
	     }
	     if (rows.length >1) {  
	        parent.$.messager.alert('提示','一次只能删除一个对象');  
	        return;  
	     }
	      
	    var ids=[];  
	    for(var i=0;i<rows.length;i++){
	    	 if (rows[i].isNewRecord == true) {  
		        parent.$.messager.alert('提示','请先取消保存新添加的对象');  
		        return;  
		     }  
	        ids.push(rows[i].id); 
	    }
	    var rowIndex = $('#digitalFeatureTable').datagrid('getRowIndex',rows[0]);
	    parent.$.messager.confirm('询问', '删除操作将直接影响数字特征信息，确定删除吗？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});	
					$.post('${pageContext.request.contextPath}/admin/digitalfeature/deleteTDigitalFeature', {
						id : ids.join(";")
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							parent.$.messager.progress('close');
							$('#digitalFeatureTable').datagrid('deleteRow',rowIndex);
						}else
							parent.$.messager.alert('提示', result.msg, 'error');
							parent.$.messager.progress('close');
						}, 'JSON');
					}
				});    
			}; 
			
			$('.select2').select2({
			ajax: {
			    url: "${pageContext.request.contextPath}/admin/catalogIcon/selectList",
			    type: 'POST',
			    dataType: 'json',
			    delay: 500,
			    data: function (params) {
			    	if (params.term == null) params.term = '';
			    	if (params.page == null) params.page = 1;
			      return {
			        q: params.term, // search term
			        page: params.page
			      };
			    },
			    processResults: function (data, params) {
			      // parse the results into the format expected by Select2
			      // since we are using custom formatting functions we do not need to
			      // alter the remote JSON data, except to indicate that infinite
			      // scrolling can be used
			      params.page = params.page || 1;

			      return {
			        results: data.rows,
			        pagination: {
			          more: (params.page * 15) < data.total_count
			        }
			      };
			    },
			    cache: true,
			    //必须要有, 解决请求被abort后弹出提示方框的问题
			    error: function (XMLHttpRequest, textStatus, errorThrown) {
				}
			  },
			  placeholder: {
				id: '-1', // the value of the option
				text: '请输入虫类名称'
			  },
			  escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
			   templateResult: formatRepoProvince, // omitted for brevity, see the source of this page
				templateSelection: formatRepoProvince, // omitted for brevity, see the source of this page
			  minimumInputLength: 1
		});
		
		$('.select2').on("change",function(){
			var temp = $('.select2').text().split(",");
			if(temp[1]!=undefined){
				var imgAddr;
				if(temp[1]!="")
					imgAddr = '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/insects/'+temp[1]+'.png';
				else
					imgAddr ="";
				$('#iconImage').attr('src',imgAddr);
				$('#jg').attr('value',temp[1]);
			}
		});
			var zylb = "${catalogIndex.zylb}";
			$("#zylb").attr("value",zylb);
			
			//设置专家审核内容不可编辑
			$("#passaudit").attr("disabled","disabled");
			var passaudit = "${catalogIndex.passaudit}";
			if(passaudit == "true")
				$("#passaudit option[value='true']").attr("selected","selected");
			
			$.getJSON(urlAddr, function(json) {
				$.fn.zTree.init($("#treeDemo"), ztree_setting, json);
			});
			
			var iconCls = "${catalogIndex.iconCls}";
			$('.select2').attr("value",iconCls);
			if(iconCls !=""){
				var imgaddr = '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/insects/'+iconCls+'.png';
				$('#iconImage').attr("src",imgaddr);
			}
			$('#jg').attr('value',iconCls);

});
	function formatRepoProvince(repo) {
		if (repo.loading) return repo.text;
		var markup = "<div>"+repo.text+"</div>"+"<div hidden=true>"+","+repo.name+"</div>";
		return markup;
	};
	doAdd = function(){
		$("#inputForm").submit();
	};
	
	goback = function(){
		window.history.back();
	};
	
    //保存数字特征
    function saveItem(index){
        var row = $('#digitalFeatureTable').datagrid('getRows')[index];
    	
    	var url = row.isNewRecord ? '${pageContext.request.contextPath}/admin/digitalfeature/addtdigitalfeature' : '${pageContext.request.contextPath}/admin/digitalfeature/editTDigitalFeature?id='+row.id;
        var data=$("#dfForm").serialize();
        data = data.replace(/\+/g," ");   // g表示对整个字符串中符合条件的都进行替换
        $.ajax({
        //$('#digitalFeatureTable').datagrid('getRowDetail',index).find('form').form('submit',{
	        url: url,
	        data : data, 
			dataType : "json",
			type :"POST",
	        success: function(json, _status){
	        	json.isNewRecord = false;
	            $('#digitalFeatureTable').datagrid('collapseRow',index);
	            $('#digitalFeatureTable').datagrid('updateRow',{
	                index: index,
	                row: json.obj,  
	            });
	            row.isNewRecord = false;
	        },
	        error: function(xhr, errorMsg, errorThrown){  
            	parent.$.messager.alert('数据特征数据更新', errorMsg); //easyui中的控件messager 
        	}
    	});
    	   
	};
	
	//取消保存数字特征  
    function cancelItem(index){
        var row = $('#digitalFeatureTable').datagrid('getRows')[index];  
        if (row.isNewRecord){  
            $('#digitalFeatureTable').datagrid('deleteRow',index);  
        } else {  
            $('#digitalFeatureTable').datagrid('collapseRow',index);  
        }  
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
			v = nodes[0].mc;
		var cityObj = $("#proctypeSel");
		cityObj.attr("value", v);
		$("#parentid").attr("value",nodes[0].id);
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
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false" title="知识库  > 昆虫类别  > 编辑 ">
	<form id="inputForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${cid}"/>
		<input type="hidden" id="digitalFeatureIds" name="digitalFeatureIds"/>
		<input type="hidden" name="parentId" id="parentid"/>
		<input id="jg" type="hidden" name="iconCls"/>
		<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" id="basicInformation"/>
				</li>
				<li>
					<input type="button" value="分类特征图片" id="diffFeature" />
				</li>
				<li>
					<input type="button" value="数字识别特征" id ="digitalFeature"/>
				</li> 
				<li>
					<input type="button" value="专家审核意见" id ="expertAudit"/>
				</li>
		</ul>
			<!-- 基本情况 -->
			<table class="input tabContent">
				<tr><th> 上级 害虫类别：</th><td>${parentMc}</td></tr>
				<tr><th> 修改 上级害虫类别：</th><td><input id="proctypeSel" type="text" readonly value="" style="width:120px;"/>&nbsp;<a id="menuBtn" href="javascript:void(0);" onclick="showMenu(); return false;">选择</a>
						<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
							<ul id="treeDemo" class="ztree" style="margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:220px;height:500px;overflow-y:scroll;overflow-x:auto;"></ul>
						</div></td></tr>
				<tr><th><span class="requiredField">*</span> 编码：</th><td><input type="text" name="bm" value="${catalogIndex.bm}" maxlength="30" style="width: 200px;" ></td></tr>
				<tr><th><span class="requiredField">*</span> 分类码：</th><td><input type="text" name="flm" value="${catalogIndex.flm}" maxlength="6"></td></tr>
				<tr><th><span class="requiredField">*</span> 中文名：</th><td><input type="text" name="mc" value="${catalogIndex.mc}" maxlength="60" style="width: 300px;"></td></tr>
				<tr><th><span class="requiredField">*</span> 英文名：</th><td><input type="text" name="ywm" value="${catalogIndex.ywm}" maxlength="200" style="width: 400px;"></td></tr>
				<tr><th><span class="requiredField">*</span> 重要储藏害虫：</th><td>
				<select id="zylb" name="zylb" style="width: 300px;" value="${catalogIndex.zylb}">
					<option value="">请选择</option>
					<option value="检疫害虫">检疫害虫</option>
					<option value="蛀食害虫">蛀食害虫</option>
					<option value="粉食类">粉食类</option>
					<option value="其他重要害虫">其他重要害虫</option>
				</select>
				</td></tr>
				<tr><th> 拉丁学名：</th>
					<td>
						<input type="text" name="ymc" value="${catalogIndex.ymc}" maxlength="100" style="width: 300px;"></input>
					</td>
				</tr>
				<tr><th> 特征：</th>
					<td>
						<textarea id="tzeditor" name="tz" style="width: 98%; height:200px ">${catalogIndex.tz}</textarea>
					</td>	
				</tr>
				<tr><th> 生活习性：</th>
					<td>
						<textarea id="shxxeditor" name="shxx" style="width: 98%; height:200px ">${catalogIndex.shxx}</textarea>
					</td>
				</tr>
				<tr><th> 分布：</th>
					<td>
						<textarea id="fbeditor" name="fb" style="width: 98%; height:200px ">${catalogIndex.fb}</textarea>
					</td>
				</tr>
				<tr><th> 危害：</th>
					<td>
						<textarea id="wheditor" name="wh" style="width: 98%; height:200px ">${catalogIndex.wh}</textarea>
					</td>
				</tr>
				
				<tr><th> 标签：</th><td>
				<c:set var="tagstr" value="" />
				<c:forEach var="item" items="${catalogIndex.tags}">
					<c:set var="tagstr" value="${tagstr},${item.name}" />
				</c:forEach>
				<c:set var="contains" value="false" />
				<c:forEach var="tag" items="${tags}" varStatus="status">
					<c:choose>
					    <c:when test="${fn:contains(tagstr,tag.name)}">
					        <label><input type="checkbox" name="tagIds" value="${tag.id}" checked="checked"/>${tag.name}</label>
					    </c:when>
					    <c:otherwise>
					        <label><input type="checkbox" name="tagIds" value="${tag.id}"/>${tag.name}</label>
					    </c:otherwise>
					</c:choose>	
				</c:forEach> 
				</td>
				</tr>
				
				<tr><th> 防治工艺：</th><td>
				<c:set var="prestr" value="" />
				<c:forEach var="pitem" items="${catalogIndex.tPreventprocesses}">
					<c:set var="prestr" value="${prestr},${pitem.proname}" />
				</c:forEach>
				<c:set var="pcontain" value="false" />
				<c:forEach var="ptag" items="${preventprocesses}" varStatus="pstatus">
					<c:choose>
					    <c:when test="${fn:contains(prestr,ptag.proname)}">
					        <label><input type="checkbox" name="preventprocessIds" value="${ptag.sm}" checked="checked"/><a href="${pageContext.request.contextPath}/admin/process/getPreventprocessDetail?sm=${ptag.sm}" target="_blank">${ptag.proname}</a></label>
					    </c:when>
					    <c:otherwise>
					        <label><input type="checkbox" name="preventprocessIds" value="${ptag.sm}"/><a href="${pageContext.request.contextPath}/admin/process/getPreventprocessDetail?sm=${ptag.sm}" target="_blank">${ptag.proname}</a></label>
					    </c:otherwise>
					</c:choose>	
				</c:forEach> 
				</td>
				</tr>
				
				<tr><th> 描述：</th>
					<td>
						<textarea id="mseditor" name="ms" style="width: 98%; height:200px ">${catalogIndex.ms}</textarea>
					</td>
				</tr>
				
				<tr><th> 资料来源：</th><td colspan="3"><input type="text" name="source" value="${catalogIndex.source}" maxlength="100"></td></tr>
				<tr><th> 图标录入：</th><td><select style="width:20em;" class="select2 text index jsjgr" ></select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img id="iconImage"></img></td></tr>

			</table>
			
			<!-- 分类特征图片 -->
			<table id="binImageTable" class="input tabContent">
				<tr>
					<td colspan="4">
						<a href="javascript:;" id="addBinImage" class="button">增加分类特征图片</a>
					</td>
				</tr>
				<tr class="title">
					<td >分类特征图片</td>
					<td >简述</td>
					<td ><span class="requiredField">*</span>图片来源</td>
					<td >排序（数字）</td>
				</tr>
				<c:forEach var="pic" items="${catalogIndex.TCatalogPics}" varStatus="status">
					<tr>
						<td>
							<input type="hidden" name="TCatalogPics[${status.index}].source" value="${pic.source}" />
							<input type="hidden" name="TCatalogPics[${status.index}].large" value="${pic.large}" />
							<input type="hidden" name="TCatalogPics[${status.index}].medium" value="${pic.medium}" />
							<input type="hidden" name="TCatalogPics[${status.index}].thumbnail" value="${pic.thumbnail}" />
							<input type="file" name="TCatalogPics[${status.index}].file" class="productImageFile ignore" />
							<img src="${pic.thumbnail}"/>
						</td>
						<td>
							<input type="text" name="TCatalogPics[${status.index}].title" class="text" maxlength="200" value="${pic.title}" />
						</td>
						<td>
							<input type="text" name="TCatalogPics[${status.index}].fromwhere" class="text" maxlength="8" value="${pic.fromwhere}" disabled="true" />
						</td>
						<td>
							<input type="digits" name="TCatalogPics[${status.index}].order" class="text productImageOrder" value="${pic.order}" maxlength="9" data-options="validType:'digits'" />
						</td>
						<td>
							<a href="javascript:;" id="deleteBinImage" class="deleteBinImage">[ 删除 ]</a>
						</td>
					</tr>				
				</c:forEach>
			</table>
		</form>
			<!-- 数字识别特征 -->	
			<table class="easyui-datagrid" id="digitalFeatureTable">
			</table>
			
			<table class="input" id="expertAuditTable" style="display:none;">
				<tr><th> 审核通过：</th><td>
				<select id="passaudit" name="passaudit" style="width: 300px;">
					<option value="false">否</option>
					<option value="true">是</option>
				</select>
				</td></tr>
				<tr><th> 审核意见：</th>
					<td>
						<textarea id="auditadviceeditor" name="auditadvice" style="width: 98%; height:200px ">${catalogIndex.auditadvice}</textarea>
					</td>
				</tr>
				<tr><th> 审核人：</th> <td>${catalogIndex.auditor}</td></tr>
				<tr><th> 审核时间：</th> <td>${catalogIndex.audittime}</td></tr>			
			</table>
			
			<table class="input" id="saveIndex">
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
	</div>
</div>
</body>
</html>