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
	
	 	doEdit = function(){
			$("#inputForm").submit();
		} 
		$(function(){
		
		
			var $inputForm = $("#inputForm");
			var $insectsCollectImageTable = $("#insectsCollectImageTable");
			var $addInsectsCollectImage = $("#addInsectsCollectImage");
			var $deleteInsectsCollectPic = $("a.deleteInsectsCollectPic");
			var insectsImageIndex = "${picTotal }";   //虫害图片总张数
			
			var $insectsInfoCollectTable = $("#insectsInfoCollectTable");
			var $addInsectsInfo = $("#addInsectsInfo");
			var $deleteInsectsInfo = $("a.deleteInsectsInfo");
			var insectsInfoIndex = "${insectsInfoTotal }";  // 虫害信息总数
			// 增加虫害采集图片
			$addInsectsCollectImage.click(function() {
					var trHtml = 
					'<tr>' +
						'<td>' +
							'<input type="file" name="TInsectpicIndepots[' + insectsImageIndex + '].file" class="productImageFile" />' + 
						'</td>' + 
						'<td>' +
							'<input type="text" name="TInsectpicIndepots[' + insectsImageIndex + '].title" class="text" maxlength="200" />' +
						'</td>' +
				 		'<td>' +
							'<input type="text" name="TInsectpicIndepots[' + insectsImageIndex + '].order" class="text productImageOrder" maxlength="9" style="width: 50px;"/>'+
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
					content: "删除该虫害图片吗？请确认！",
					onOk: function() {
						$this.closest("tr").remove();
					}
				});
			});
			
			
			// 增加虫害信息
			$addInsectsInfo.click(function() {
					var trHtml = 
					'<tr>' +
						'<td>' +
							'<input type="text" name="TInsectsOndepots[' + insectsInfoIndex + '].locCollect"  class="myinput" />' + 
						'</td>' + 
						'<td>' +
							'<input type="text" name="TInsectsOndepots[' + insectsInfoIndex + '].host" class="myinput" style="width:60px;" maxlength="50" />' +
						'</td>' +
				 		'<td>' +
							'<input type="text" name="TInsectsOndepots[' + insectsInfoIndex + '].kind" class="myinput" style="width:60px;" maxlength="50" />'+
						'</td>' + 
						'<td>' +
							'<input type="text" name="TInsectsOndepots[' + insectsInfoIndex + '].stage" class="myinput" style="width:60px;" maxlength="50" />'+
						'</td>' + 
						'<td>' +
							'<input type="text" name="TInsectsOndepots[' + insectsInfoIndex + '].num" class="myinput" style="width:40px;" maxlength="30" />' + 
						'</td>' + 
						'<td>' +
							'<input type="text" name="TInsectsOndepots[' + insectsInfoIndex + '].food" class="myinput" style="width:60px;"  maxlength="50" />' +
						'</td>' +
				 		'<td>' +
							'<input type="text" name="TInsectsOndepots[' + insectsInfoIndex + '].harm" class="myinput" style="width:60px;" maxlength="50" />'+
						'</td>' + 
						'<td>' +
							'<input type="text" name="TInsectsOndepots[' + insectsInfoIndex + '].measureCtrl" class="myinput" style="width:120px;" maxlength="200" />'+
						'</td>' + 
						'<td> ' +
							'<a href="javascript:;" class="deleteInsectsInfo" style="width:50px,align:left" >[ 删除 ]</a>' +
						'</td> ' +
					'</tr>';
				$insectsInfoCollectTable.append(trHtml);
				insectsInfoIndex ++;
			});
			
			// 删除商品图片
			$deleteInsectsInfo.live("click", function() {
				var $this = $(this);
				$.dialog({
					type: "warn",
					content: "删除该虫害信息吗？请确认！",
					onOk: function() {
						$this.closest("tr").remove();
					}
				});
			});
			
			
			// 表单验证
			$inputForm.validate({
				rules: {
					smCollection: "required",
				},
				submitHandler: function() {
					var formData = new FormData($("#inputForm")[0]); 
					$.ajax({
						url : 'recordEdit',
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
			
			$('#lkbm').combogrid({
			    panelWidth:450, 
			    idField:'lkbm',
			    textField:'lkbm',
			    url:'getDepotList',
			    columns:[[
			        {field:'lkbm',title:'粮库编码',width:120},
			        {field:'lkmc',title:'粮库名称',width:120},
			        {field:'lkdz',title:'粮库地址', width:180},
			        {field:'contact',title:'联系人', width:80},
			        {field:'phone',title:'手机号', width:50},
			    ]],
			    onSelect: function(rowIndex, rowData){
			    	$('#lcbm').combogrid({   
					    panelWidth:450, 
					    idField:'lcbm',
					    textField:'lcbm',
					    url:'getBinList',
					    queryParams:{lkbm: rowData.lkbm },
					    columns:[[
					        {field:'lcbm',title:'粮仓编码',width:120},
					        {field:'binname',title:'仓名',width:120},
					        {field:'typebin',title:'仓型', width:100},
					        {field:'orientation',title:'朝向', width:80},
					        {field:'granarynum',title:'廒间数', width:50},
					    ]],
					});
			    },
			});
			$('#lcbm').combogrid({
			    panelWidth:450, 
			    idField:'lcbm',
			    textField:'lcbm',
			    url:'getBinList',
			    queryParams:{lkbm: ${lkbm } },
			    columns:[[
			        {field:'lcbm',title:'粮仓编码',width:120},
			        {field:'binname',title:'仓名',width:120},
			        {field:'typebin',title:'仓型', width:100},
			        {field:'orientation',title:'朝向', width:80},
			        {field:'granarynum',title:'廒间数', width:50},
			    ]],
			});
		})
		goback = function(){
			window.history.back();
		}
	</script>
</head>
<body>			

	<div class="path">路径>>编辑储备库粮仓采集记录</div>
	<div class="container" >
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
				<tr>
					<th><span class="requiredField">*</span>粮库编码：</th>
					<td>
						<input id="lkbm" name="lkbm" style="width:200px" value="${lkbm }"/>
					</td>
				</tr>
				<tr>
					<th><span class="requiredField">*</span>粮仓编码：</th>
					<td>
						<input id="lcbm" name="lcbm" style="width:200px"  value="${lcbm }"/>
					</td>
				</tr>
				<tr>
					<th><span class="requiredField">*</span>采集记录编号：</th>
					<td><input name="smCollection" class="myinput" type="text" readonly="readonly" style="width:200px" value="${depotCollectRecord.smCollection }"/></td>
				</tr>
				<tr>
					<th>采集日期:</th>
					<td>
						<input type="text" name="dateCollection" class="text Wdate" value="${depotCollectRecord.dateCollection }" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'});" />
					</td>
				</tr>
			</table>
			<!-- 虫害信息 -->
			<table id="insectsInfoCollectTable" class="input tabContent">
				<tr>
					<td>
						<a href="javascript:;" id="addInsectsInfo" class="button">增加虫害信息</a>
					</td>
				</tr>
				<tr class="title">
					<td >采集部位</td>
					<td >寄主</td>
					<td >虫种</td>
					<td >虫态</td>
					<td >数量（头/kg）</td>
					<td >食性</td>
					<td >危害性</td>
					<td >防虫措施</td>
					<td >操作</td>
				</tr>
				<c:choose>
				<c:when test="${fn:length(depotCollectRecord.TInsectsOndepots)>=1}">
					<c:forEach var="insectsInfo" items="${depotCollectRecord.TInsectsOndepots }" varStatus="status">
						<tr>
							<td>
								<input type="hidden" name="TInsectsOndepots[${status.index}].id" value="${insectsInfo.id }" />
								<input name="TInsectsOndepots[${status.index}].locCollect" type="text" style="width:60px"  class="myinput" value="${insectsInfo.locCollect }" />
							</td>
							<td>
								<input name="TInsectsOndepots[${status.index}].host" type="text" style="width:60px" class="myinput" value="${insectsInfo.host }" />
							</td>
							<td>
								<input name="TInsectsOndepots[${status.index}].kind" type="text" style="width:60px"  class="myinput" value="${insectsInfo.kind }" />
							</td>
							<td>
								<input name="TInsectsOndepots[${status.index}].stage" type="text" style="width:60px"  class="myinput" value="${insectsInfo.stage }" />
							</td>
							<td>
								<input name="TInsectsOndepots[${status.index}].num" type="text" style="width:40px"  class="myinput" value="${insectsInfo.num }" />
							</td>
							<td>
								<input name="TInsectsOndepots[${status.index}].food" type="text" style="width:60px"  class="myinput" value="${insectsInfo.food }" />
							</td>
							<td>
								<input name="TInsectsOndepots[${status.index}].harm" type="text" style="width:60px"  class="myinput" value="${insectsInfo.harm }" />
							</td>
							<td>
								<input name="TInsectsOndepots[${status.index}].measureCtrl" type="text" style="width:120px"  class="myinput" value="${insectsInfo.measureCtrl }" />
							</td>
							<td>
								<a href="javascript:;" class="deleteInsectsInfo" style="width:20px" >[ 删除 ]</a>
							</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
				
				
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
				<c:choose>
					<c:when test="${fn:length(depotCollectRecord.TInsectpicIndepots)>=1}">
						<c:forEach var="pic" items="${depotCollectRecord.TInsectpicIndepots }" varStatus="status">
							<tr>
								<td>
								<input type="hidden" name="TInsectpicIndepots[${status.index}].id" value="${pic.id}" />
								<input type="hidden" name="TInsectpicIndepots[${status.index}].source" value="${pic.source}" />
								<input type="hidden" name="TInsectpicIndepots[${status.index}].large" value="${pic.large}" />
								<input type="hidden" name="TInsectpicIndepots[${status.index}].medium" value="${pic.medium}" />
								<input type="hidden" name="TInsectpicIndepots[${status.index}].thumbnail" value="${pic.thumbnail}" />
								<input type="file" name="TInsectpicIndepots[${status.index}].file" class="productImageFile ignore" />
									<img src="${pic.thumbnail}"/>
								</td>
								<td><input type="text" name="TInsectpicIndepots[${status.index}].title" class="myinput" value="${pic.title}" /></td>
								<td><input type="text" name="TInsectpicIndepots[${status.index}].order" class="myinput" value="${pic.order}" /></td>
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