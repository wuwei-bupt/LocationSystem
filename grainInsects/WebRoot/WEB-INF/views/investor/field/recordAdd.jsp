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
	<title>main - Powered By Szy++</title>
	<meta name="author" content="Szy++ Team" />
	<meta name="copyright" content="Szy++" />
	<link href="<%=base %>resources/admin/css/common.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=base %>resources/easyUI/themes/cupertino/easyui.css"></link>
	<script type="text/javascript" src="<%=base %>resources/admin/js/common.js"></script>
	<script type="text/javascript" src="<%=base %>resources/admin/js/list.js"></script>
	<script type="text/javascript" src="<%=base %>resources/admin/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/datePicker/WdatePicker.js"></script>
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
			var $insectsCollectImageTable = $("#insectsCollectImageTable");
			var $addInsectsCollectImage = $("#addInsectsCollectImage");
			var $deleteInsectsCollectPic = $("a.deleteInsectsCollectPic");
			var insectsImageIndex = 0;
			
			// 增加虫害采集图片
			$addInsectsCollectImage.click(function() {
					var trHtml = 
					'<tr>' +
						'<td>' +
							'<input type="file" name="TFieldPics[' + insectsImageIndex + '].file" class="productImageFile" />' + 
						'</td>' + 
						'<td>' +
							'<input type="text" name="TFieldPics[' + insectsImageIndex + '].title" class="text" maxlength="200" />' +
						'</td>' +
				 		'<td>' +
							'<input type="text" name="TFieldPics[' + insectsImageIndex + '].order" class="text productImageOrder" maxlength="9" style="width: 50px;"/>'+
						'</td>' + 
						'<td> ' +
							'<a href="javascript:;" class="deleteInsectsCollectPic" style="width:50px,align:left" >[ 删除 ]</a>' +
						'</td> ' +
					'</tr>';
				$insectsCollectImageTable.append(trHtml);
				insectsImageIndex ++;
			});
			
			// 删除虫害采集图片
			$deleteInsectsCollectPic.live("click", function() {
				var $this = $(this);
				$.dialog({
					type: "warn",
					content: "删除该仓型图片吗？请确认！",
					onOk: function() {
						$this.closest("tr").remove();
					}
				});
			});
			
			// 表单验证
			$inputForm.validate({
				rules: {
					//id: "required",
				},
				submitHandler: function() {
					var formData = new FormData($("#inputForm")[0]); 
					$.ajax({
						url : 'recordAdd',
						data: formData,
						dataType : 'json',
						type: 'POST',
						/* async: false,  
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
		})
		
		goback = function(){
			window.history.back();
		}
	</script>
</head>
<body>			

	<div class="path">路径>>添加野外采集记录</div>
	<div class="container" >
		<br/>
		<form id="inputForm"  method="post" enctype="multipart/form-data">
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="粮食信息" />
				</li>
				<li>
					<input type="button" value="虫害信息" />
				</li>
				<li>
					<input type="button" value="采虫图片" />
				</li>
			</ul>
			<table class="input tabContent">
				<!-- 粮食信息 -->
				<%-- <tr>
					<th><span class="requiredField">*</span>采集记录编号：</th>
					<td><input name="id" class="myinput" type="text" style="width:200px" readonly="readonly" value="${id }"/></td>
				</tr> --%>
				<tr>
					<th>粮食品种：</th>
					<td><input name="grainkind" class="myinput" type="text" style="width:150px"/></td>
				</tr>
				<tr>
					<th>温度：</th>
					<td>
						<input name="temperature" type="text" class="myinput" style="width:200px;"/>℃
					</td>
				</tr>
				<tr>
					<th>湿度：</th>
					<td>
						<input name="humidity" type="text" class="myinput" style="width:200px;"/>％
					</td>
				</tr>
				<tr>
					<th>采集日期:</th>
					<td>
						<input type="text" name="collectdate" class="text Wdate" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'});" />
					</td>
				</tr>
				<tr>
					<th>海拔:</th>
					<td>
						<input name="altitude" class="myinput" type="text" style="width:150px"/>米
					</td>
				</tr>
				<tr>
					<th>GPS：</th>
					<td>
						GPS(E)&nbsp;<input name="longtitude" class="myinput" type="text" style="width:150px"/>&nbsp;、
						GPS(N)&nbsp;<input name="latitude" class="myinput" type="text" style="width:150px"/>&nbsp;
					</td>
				</tr>
			</table>
			<!-- 虫害信息 -->
			<table id="insectsInfoCollectTable" class="input tabContent">
				<tr>
					<th>寄主：</th>
					<td>
						<input name="host" type="text" class="myinput" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<th>虫种：</th>
					<td>
						<input name="kind" type="text" class="myinput" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<th>虫态：</th>
					<td>
						<input name="stage" type="text" class="myinput" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<th>数量（头/kg）：</th>
					<td>
						<input name="num" type="text" class="myinput" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<th>食性：</th>
					<td>
						<input name="food" type="text" class="myinput" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<th>危害性：</th>
					<td>
						<input name="harm" type="text" class="myinput" style="width:200px;"/>
					</td>
				</tr>
			</table>
			<!-- 采虫图片 -->
			<table id="insectsCollectImageTable" class="input tabContent">
				<tr>
					<td>
						<a href="javascript:;" id="addInsectsCollectImage" class="button">增加采虫图片</a>
					</td>
				</tr>
				<tr class="title">
					<td >采虫图片</td>
					<td >标题</td>
					<td >排序</td>
					<td >操作</td>
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