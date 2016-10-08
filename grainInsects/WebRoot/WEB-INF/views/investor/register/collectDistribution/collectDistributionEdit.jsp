<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- doctype一定要写在这个位置 -->
<%@ include file="/common/taglibs.jsp"%>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
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
	
	 	doEdit = function(){
			$("#inputForm").submit();
		} 
		$(function(){
			var $inputForm = $("#inputForm");
			var $distributionRecordImageTable = $("#distributionRecordImageTable");
			var $addDistributionRecordImage = $("#addDistributionRecordImage");
			var $deleteInsectsCollectPic = $("a.deleteInsectsCollectPic");
			var insectsImageIndex = "${recordTotal }";   //昆虫采集分布信息总数
			
			// 增加昆虫采集分布信息
			$addDistributionRecordImage.click(function() {
					var trHtml = 
					'<tr>' +
						'<td>' +
							'<input type="text" name="TInsectsdistributions[' + insectsImageIndex + '].company" class="myinput"  style="width: 200px;"/>' + 
						'</td>' + 
						'<td>' +
							'<input type="text" name="TInsectsdistributions[' + insectsImageIndex + '].num" class="myinput" style="width: 50px;"/>' +
						'</td>' +
				 		'<td>' +
							'<input type="text" name="TInsectsdistributions[' + insectsImageIndex + '].collectyear" class="myinput"  style="width:50px;"/>' +
						'</td>' +
				 		'<td>' +
							'<input type="text" name="TInsectsdistributions[' + insectsImageIndex + '].collectmonth" class="myinput" style="width: 50px;"/>'+
						'</td>' + 
						'<td> ' +
							'<a href="javascript:;" class="deleteInsectsCollectPic" style="width:50px,align:left" >[ 删除 ]</a>' +
						'</td> ' +
					'</tr>';
				$distributionRecordImageTable.append(trHtml);
				insectsImageIndex ++;
			});
			
			// 删除昆虫采集分布信息
			$deleteInsectsCollectPic.live("click", function() {
				var $this = $(this);
				$.dialog({
					type: "warn",
					content: "删除该昆虫采集分布信息吗？请确认！",
					onOk: function() {
						$this.closest("tr").remove();
					}
				});
			});
			
			// 表单验证
			$inputForm.validate({
				rules: {
					smInsects: "required",
				},
				submitHandler: function() {
					var formData = new FormData($("#inputForm")[0]); 
					$.ajax({
						url : 'collectDistributionEdit',
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

	<div class="path">路径>>编辑野外采集记录</div>
	<div class="container" >
		<form id="inputForm"  method="post" enctype="multipart/form-data">
			<input type="hidden" name="smInsects" value="${smInsects }"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="昆虫采集分布信息" />
				</li>
				<li>
					<input type="button" value="分布记录信息" />
				</li>
			</ul>
			<table class="input tabContent">
				<!-- 昆虫采集分布信息 -->
				<tr>
					<th><span class="requiredField">*</span>昆虫编码：</th>
					<td>${insectsCollectDistribution.smInsects }</td>
				</tr>
				<tr>
					<th>虫种名称：</th>
					<td><input name="name" class="myinput" type="text" style="width:150px" value="${insectsCollectDistribution.name }"/></td>
				</tr>
			</table>
			<!-- 分布记录信息 -->
			<table id="distributionRecordImageTable" class="input tabContent">
				<tr>
					<td>
						<a href="javascript:;" id="addDistributionRecordImage" class="button">增加分布记录信息</a>
					</td>
				</tr>
				<tr class="title">
					<td >单位</td>
					<td >数量</td>
					<td >采集年</td>
					<td >采集月</td>
					<td>操作</td>
				</tr>
				<c:choose>
					<c:when test="${fn:length(insectsCollectDistribution.TInsectsdistributions)>=1}">
						<c:forEach var="record" items="${insectsCollectDistribution.TInsectsdistributions }" varStatus="status">
							<tr>
								<td>
									<input type="hidden" name="TInsectsdistributions[${status.index}].id" value="${record.id}" />
									<input type="text" name="TInsectsdistributions[${status.index}].company" class="myinput" value="${record.company}"  style="width:200px;"/>
								</td>
								<td>
									<input type="text" name="TInsectsdistributions[${status.index}].num" class="myinput" value="${record.num}" style="width:50px;"/>
								</td>
								<td>
									<input type="text" name="TInsectsdistributions[${status.index}].collectyear" class="myinput" value="${record.collectyear}" style="width:50px;"/>
								</td>
								<td>
									<input type="text" name="TInsectsdistributions[${status.index}].collectmonth" class="myinput" value="${record.collectmonth}" style="width:50px;"/>
								</td>
								<td>
									<a href="javascript:;" class="deleteInsectsCollectPic">[ 删除 ]</a>
								</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>
			</table>
			<table class="input">
				<tr><th>&nbsp;</th>
				<td >
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="doEdit()" iconCls="icon-save">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="goback()" iconCls="icon-back">返回</a>
				</td>
				</tr>	
			</table>		
		</form>
	</div>
</body>
</html>