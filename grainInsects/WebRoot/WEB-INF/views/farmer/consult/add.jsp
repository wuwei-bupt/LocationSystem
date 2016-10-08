<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- doctype一定要写在这个位置 -->
<%@ include file="/common/taglibs.jsp"%>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.print(path);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!-- <#assign content="welcome"> -->
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>main - Developed by Logan Von</title>
	<meta name="author" content="Logan Von" />
	<meta name="copyright" content="Logan Von" />
	<link href="<%=base %>resources/admin/css/common.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=base %>resources/easyUI/themes/cupertino/easyui.css"></link>
	<link href="<%= request.getContextPath() %>/resources/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=base %>resources/admin/js/common.js"></script>
	<script type="text/javascript" src="<%=base %>resources/admin/js/list.js"></script>
	<script type="text/javascript" src="<%=base %>resources/admin/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/select2/js/select2.min.js"></script>
	<style type="text/css">
		
		.myinput {
			outline:none;	/*去掉input获得焦点时的外边框*/
			text-align:center;
			border-style:none;
			border-bottom-style:solid;
			border-bottom-width:1px;
			/* background-color:#F2F5F7; */
		}
		table.input {
			width: 100%;
			word-break: break-all;
		}
	</style>
	<script type="text/javascript">
	
		//submit the form
	 	doAdd = function(){
			$("#inputForm").submit();
		} 
		$(function(){
			var $inputForm = $("#inputForm");
			
		
			// 表单验证
			$inputForm.validate({
				rules: {
					//id: "required",
				},
				submitHandler: function() {
					var formData = new FormData($("#inputForm")[0]); 
					$.ajax({
						url : 'addConsult',
						data: formData,
						dataType : 'json',
						/* async: false,  
				        cache: false,  */
						contentType: false,  
				        processData: false,  
						success : function(r) {
							if (r && r.success) {
								parent.$.messager.alert('提示', r.msg); //easyui中的控件messager
								window.history.back();
							} else {
								parent.$.messager.alert('数据更新或插入', r.msg, 'error'); //easyui中的控件messager
							}
						}
					});
				}
			});
			
			var data = [{ id: 0, text: '害虫识别' }, { id: 1, text: '害虫防治' }, { id: 2, text: '其他' }];

			function formatResult(data) {
				if (data.loading) return data.name;
				
				var markup = "<div><h2>" + data.name + "</h2>" +
				"<p>擅长领域：" + (data.specialty || "")  + "</p>" +
				"<p>单位："+ (data.company || "") + "</p>" +
				"<p>职称：" + (data.title || "") + "</p>";
				return markup;
			}
			
			$("#type-select").select2({
			  data: data,
			  minimumResultsForSearch: Infinity
			});
			
			$("#expert-select").select2({
				  ajax: {
				    url: "getExpert",
				    dataType: 'json',
				    delay: 250,
				    type:'post',
				    placeholder: {
				        id: '-1', // the value of the option
				        text: '请选择专家...'
				      },
				    data: function (params) {
				    	if (params.term == null) params.term = "";
				    	if (params.page == null || params.page <= 0) params.page = 1;
				      return {
				        q: params.term, // search term
				        page: params.page,
				        rows: 15
				      };
				    },
				    processResults: function (data, params) {
				      // parse the results into the format expected by Select2
				      // since we are using custom formatting functions we do not need to
				      // alter the remote JSON data, except to indicate that infinite
				      // scrolling can be used
				      var d = $.map(data.rows, function (obj) {
							obj.text = obj.text || obj.name; // replace name with the property used for the text
							obj.id = obj.id || obj.username; // replace username with the property used for the id
							return obj;
						});
				      
				      data.rows = d;

						params.page = params.page || 1;

						return {
							results : data.rows,
							pagination : {
								more : (params.page * 15) < data.total
							}
						};
					},
					cache : true
				},
				
				escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
				templateResult: formatResult,
			
			});
		})
		
		goback = function() {
			window.history.back();
		}
	</script>
</head>
<body>			

	<div class="path">路径>>农户咨询录入</div>
	<div class="container" >
		<br/>
		<form id="inputForm"  method="post" enctype="multipart/form-data">
			
			<table class="input">
				<!-- 粮食信息 -->
				<tr>
					<th><span class="requiredField">*</span>主题：</th>
					<td><input name="title" class="myinput" type="text" style="width:60em"/></td>
				</tr>
				<tr>
					<th>是否公开：</th>
					<td>
						<input name="hasshare" type="radio" value="false" checked="checked"/>不公开&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input name="hasshare" type="radio" value="true" />公开
					</td>
				</tr>
				<tr>
					<th>类型：</th>
					<td><select name="type" id="type-select" class="myinput" style="width:150px"></select></td>
				</tr>
				<tr>
					<th>描述：</th>
					<td><textarea id="editor" name="describle" class="editor" style="width: 98%;"></textarea></td>
				</tr>
				<tr>
					<th>咨询专家:</th>
					<td>
						<select id="expert-select" class="myinput" name="expertuser" style="width:150px"></select>
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
</body>
</html>