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
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/easyUI/datagrid-detailview.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/select2/js/select2.min.js"></script>
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/resources/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
	textarea{
		padding:0 0 0 0px;
		border: 1px solid #cccccc;
	}
</style>
<script type="text/javascript">
$().ready(function() {

	var $binImageTable = $("#binImageTable");
	var $addBinImage = $("#addBinImage");
	var $deleteBinImage = $("#deleteBinImage");
	var binImageIndex = 0;
	
	var $basicInformation = $("#basicInformation");
	var $diffFeature = $("#diffFeature");
	var $digitalFeature = $("#digitalFeature");
	
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
 			$("#digitalFeatureIds").attr("value",dfRowsIds);
 			//$("td[field]").closest("tr").remove();
 			var formData = new FormData($( "#inputForm" )[0]);
			$.ajax({
				url : 'addCatalogIndex',//$("#inputForm").attr("action"),
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
			editorList[0]=K.create("#tzeditor",options);
			editorList[1]=K.create("#shxxeditor",options);
			editorList[2]=K.create("#fbeditor",options);
			editorList[3]=K.create("#wheditor",options);
			editorList[4]=K.create("#mseditor",options);
		});
	};
	
	$basicInformation.click(function(){
		$(".datagrid").hide();
		$("#saveIndex").show();
	});
	
	$diffFeature.click(function(){
		$(".datagrid").hide();
		$("#saveIndex").show();
	});
	
	$digitalFeature.click(function(){
		$("#saveIndex").hide();
	});
	
	// 增加图片
	$addBinImage.click(function() {
			var trHtml = 
			'<tr>' +
				'<td>' +
					'<input type="file" name="TCatalogPics[' + binImageIndex + '].file"  />' + 
				'</td>' + 
				'<td>' +
					'<input type="text" name="TCatalogPics[' + binImageIndex + '].title" class="text" maxlength="200" />' +
				'</td>' +
				'<td>' +
					'<input type="text" name="TCatalogPics[' + binImageIndex + '].fromwhere" class="text" maxlength="8" required="true"/>' +
				'</td>' +
		 		'<td>' +
					'<input type="digits" name="TCatalogPics[' + binImageIndex + '].order" class="text" data-options="validType:\'digits\'"/>'+
				'</td>' + 
				'<td> ' +
					'<a href="javascript:;" id="deleteBinImage" style="width:50px,align:left" >[ 删除 ]</a>' +
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
	
	//2级表：数字特征表
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
            	return '<div id="detailForm-'+index+'" style="line-height:300px;"></div>';  
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
	
	//2级表：数字特征删除按钮触发事件 
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
				templateSelection: formatRepoProvince // omitted for brevity, see the source of this page
			  //minimumInputLength: 1
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
});
	function formatRepoProvince(repo) {
		if (repo.loading) return repo.text;
		var markup = "<div>"+repo.text+"</div>"+"<div hidden=true>"+","+repo.name+"</div>";
		return markup;
	};
    //保存每条数字特征信息
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
	        	if(json.success){
		        	json.isNewRecord = false;
		            $('#digitalFeatureTable').datagrid('collapseRow',index);
		            $('#digitalFeatureTable').datagrid('updateRow',{
		                index: index,
		                row: json.obj,  
		            });
		            row.isNewRecord = false;
		         }else{
		         	parent.$.messager.alert('数据特征数据更新', json.msg); //easyui中的控件messager
		         }
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
        } else 
            $('#digitalFeatureTable').datagrid('collapseRow',index);   
    }; 
    
    //保存分类表表单
    doAdd = function(){
		$("#inputForm").submit();
	};
	
	//返回分类表list
	goback = function(){
		window.history.back();
	};
	
	
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false" title="知识库  > 昆虫类别  > 新增">
		
	<form id="inputForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="parentId" value="${parentId}"/>
		<input type="hidden" id="digitalFeatureIds" name="digitalFeatureIds"/>
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
		</ul>
			<!-- 基本情况 -->		
			<table class="input tabContent">
				<tr><th> 上级 害虫类别：</th><td>${parentMc}</td></tr>
				<tr><th><span class="requiredField">*</span> 编码：</th><td><input  type="text" name="bm" maxlength="30" style="width: 300px;" ></td></tr>
				<tr><th><span class="requiredField">*</span> 分类码：</th><td><input type="text" name="flm" maxlength="6" style="width: 300px;"></td></tr>
				<tr><th><span class="requiredField">*</span> 中文名：</th><td><input  type="text" name="mc" maxlength="60" style="width: 300px;" ></td></tr>
				<tr><th><span class="requiredField">*</span> 英文名：</th><td><input type="text" name="ywm" maxlength="200" style="width: 400px;" ></td></tr>
				<tr><th><span class="requiredField">*</span> 重要储藏害虫：</th><td>
				<select name="zylb" style="width: 300px;">
					<option value="" selected="true">请选择</option>
					<option value="检疫害虫">检疫害虫</option>
					<option value="蛀食害虫">蛀食害虫</option>
					<option value="粉食类">粉食类</option>
					<option value="其他重要害虫">其他重要害虫</option>
				</select>
				</td></tr>
				
				<tr><th> 拉丁学名：</th>
					<td>
						<input type="text" name="ymc" maxlength="100" style="width: 300px;">
					</td>
				</tr>
				
				<tr><th> 特征：</th>
					<td>
						<textarea id="tzeditor" name="tz"  style="width: 98%; height:200px "></textarea>
					</td>	
				</tr>
				<tr><th> 生活习性：</th>
					<td>
						<textarea id="shxxeditor" name="shxx"  style="width: 98%; height:200px "></textarea>
					</td>
				</tr>
				<tr><th> 分布：</th>
					<td>
						<textarea id="fbeditor" name="fb"  style="width: 98%; height:200px "></textarea>
					</td>
				</tr>
				<tr><th> 危害：</th>
					<td>
						<textarea id="wheditor" name="wh"  style="width: 98%; height:200px "></textarea>
					</td>
				</tr>
				
				<tr><th> 标签：</th><td>
				<c:forEach var="tag" items="${tags}" varStatus="status">
                    <label><input type="checkbox" name="tagIds" value="${tag.id}"/>${tag.name}</label>
				</c:forEach></td>
				</tr>
				
				<tr><th> 防治工艺：</th> <td>
				<c:forEach var="preventprocess" items="${preventprocesses}" varStatus="prevent_status">
                    <label><input type="checkbox" name="preventprocessIds" value="${preventprocess.sm}"/><a href="${pageContext.request.contextPath}/admin/process/getPreventprocessDetail?sm=${preventprocess.sm}" target="_blank">${preventprocess.proname}</a></label>
				</c:forEach></td>
				</tr>
				<tr><th> 描述：</th>
					<td>
						<textarea id="mseditor" name="ms"  style="width: 98%; height:200px "></textarea>
					</td>
				</tr>
				<tr><th> 图标录入：</th><td><select style="width:20em;" class="select2 text index jsjgr" ></select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img id="iconImage"></img></td></tr>
				<tr><th> 资料来源：</th><td colspan="3"><input type="text" name="source" maxlength="100"></td></tr>
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
			</table>
			
	</form>
			<!-- 数字识别特征 -->	
			<table class="easyui-datagrid" id="digitalFeatureTable">
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