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
			/* width: 100%; */
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
			
			var $insectsInfoCollectTable = $("#insectsInfoCollectTable");
			var $addInsectsInfo = $("#addInsectsInfo");
			var $deleteInsectsInfo = $("a.deleteInsectsInfo");
			var insectsInfoIndex = 0;
			
			// 增加虫害采集图片
			$addInsectsCollectImage.click(function() {
					var trHtml = 
					'<tr>' +
						'<td>' +
							'<input type="file" name="insectsCollectPics_file" class="productImageFile" />' + 
						'</td>' + 
						'<td>' +
							'<input type="text" name="insectsCollectPics_title" class="text" maxlength="200" />' +
						'</td>' +
				 		'<td>' +
							'<input type="text" name="insectsCollectPics_order" class="text productImageOrder" maxlength="9" style="width: 50px;"/>'+
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
			
			
			// 增加虫害信息
			$addInsectsInfo.click(function() {
					var trHtml = 
					'<tr>' +
						'<td>' +
							'<input type="text" name="insectsInfoOnFarmers_locCollect"  class="myinput" />' + 
						'</td>' + 
						'<td>' +
							'<input type="text" name="insectsInfoOnFarmers_host" class="myinput" style="width:60px;" maxlength="50" />' +
						'</td>' +
				 		'<td>' +
							'<input type="text" name="insectsInfoOnFarmers_kind" class="myinput" style="width:60px;" maxlength="50" />'+
						'</td>' + 
						'<td>' +
							'<input type="text" name="insectsInfoOnFarmers_stage" class="myinput" style="width:60px;" maxlength="50" />'+
						'</td>' + 
						'<td>' +
							'<input type="text" name="insectsInfoOnFarmers_num" class="myinput" style="width:50px;" maxlength="30" />' + 
						'</td>' + 
						'<td>' +
							'<input type="text" name="insectsInfoOnFarmers_food" class="myinput" style="width:60px;"  maxlength="50" />' +
						'</td>' +
				 		'<td>' +
							'<input type="text" name="insectsInfoOnFarmers_harm" class="myinput" style="width:60px;" maxlength="50" />'+
						'</td>' + 
						'<td>' +
							'<input type="text" name="insectsInfoOnFarmers_protectmeasure" class="myinput" style="width:90px;" maxlength="200" />'+
						'</td>' + 
						'<td> ' +
							'<a href="javascript:;" class="deleteInsectsInfo" style="width:80px;align:right;" >[ 删除 ]</a>' +
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
					//smCollection: "required",
					smFarmer: "required",
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
			
			$('#smFarmer').combogrid({   
			    panelWidth:530, 
			    idField:'smFarmer',
			    textField:'smFarmer',
			    url:'getFarmerInfoList',
			    columns:[[
			        {field:'smFarmer',title:'农户编号',width:120},
			        {field:'nameFarmer',title:'户主名',width:120},
			        {field:'address',title:'地址', width:180},
			        {field:'phone',title:'手机号', width:80}
			    ]]   
			}); 
		})
		
		goback = function(){
			window.history.back();
		}
	</script>
</head>
<body>			

	<div class="path">路径>>添加农户采集记录</div>
	<div class="container" >
		<br/>
		<form id="inputForm"  method="post" enctype="multipart/form-data">
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="粮食信息" />
				</li>
				<li>
					<input type="button" value="粮情信息" />
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
					<th>采集记录编号：</th>
					<td><input name="smCollection" class="myinput" type="text" style="width:200px"readonly="readonly" style="width:200px" value="${smCollection }"/></td>
				</tr>
				<tr>
					<th><span class="requiredField">*</span>用户编码：</th>
					<td>
						<input id="smFarmer" name="smFarmer" style="width:200px"/>
					</td>
				</tr>
				<tr>
					<th>粮种名称\品种号：</th>
					<td><input id="grainname" name="grainname" class="myinput" type="text" style="width:200px"/></td>
				</tr>
				<tr>
					<th>采集日期:</th>
					<td>
						<input type="text" name="dateCollection" class="text Wdate" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'});" />
					</td>
				</tr>
				<tr>
					<th>收获日期:</th>
					<td>
						<input type="text" name="harvestdate" class="text Wdate" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'});" />
					</td>
				</tr>
				<tr>
					<th>干燥方式：</th>
					<td>
						<div id="dryingmethod">
							<input name="dryingmethod" type="radio" value="自然晾晒"/>自然晾晒
							<input name="dryingmethod" type="radio" value="烘干"/>烘干
						</div>
					</td>
				</tr>
				<tr>
					<th>入储日期:</th>
					<td>
						<input type="text" name="entrydate" class="text Wdate" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'});" />
					</td>
				</tr>
				<tr>
					<th>存储期限：</th>
					<td><input name="storeperiod" class="myinput" type="text" style="width:40px"/>个月</td>
				</tr>
				<tr>
					<th>入储数量：</th>
					<td><input id="innum" name="innum" class="myinput" type="text" style="width:60px"/>吨</td>
				</tr>
				<tr>
					<th>用途：</th>
					<td>
						<div id="purpose">
							<input name="purpose" type="radio" value="粮"/>粮
							<input name="purpose" type="radio" value="商品粮	"/>商品粮	
						</div>
					</td>
				</tr>
				<tr>
					<th>储藏技术：</th>
					<td>
						<input name="storetechnology" type="text" class="myinput" style="width:200px;"/>
					</td>
				</tr>
			</table>
			<!-- 粮情信息 -->
			<table class="input tabContent">
				<tr>
					<th>仓型（场所）：</th>
					<td><input name="bintype" class="myinput" type="text" style="width:200px"/></td>
				</tr>
				<tr>
					<th>装具名称：</th>
					<td><input name="container" class="myinput" type="text" style="width:90px"/></td>
				</tr>
				<tr>
					<th>环境温度（℃）：</th>
					<td><input name="temperature" class="myinput" type="text" style="width:60px"/></td>
				</tr>
				<tr>
					<th>环境湿度（％）：</th>
					<td><input name="humidity" class="myinput" type="text" style="width:60px"/></td>
				</tr>
				<tr>
					<th>粮堆水分（％）：</th>
					<td><input name="moisture" class="myinput" type="text" style="width:60px"/></td>
				</tr>
				<tr>
					<th>杂质含量（％）：</th>
					<td>
						<input name="impurity" class="myinput" type="text" style="width:60px"/>
					</td>
				</tr>
				<tr>
					<th>控温措施：</th>
					<td>
						<input name="controltemperaturemeasures" type="text" class="myinput" style="width:150px;"/>
					</td>
				</tr>
				<tr>
					<th>控湿措施：</th>
					<td>
						<input name="controlhumiditymeasures" type="text" class="myinput" style="width:150px;"/>
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