<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	<style type="text/css">
		
		.myinput {
			outline:none;	/*去掉input获得焦点时的外边框*/
			text-align:center;
			border-style:none;
			border-bottom-style:solid;
			border-bottom-width:1px;
			/* background-color:#F2F5F7; */
		}
		.big_title {
			padding-left: 5px;
			background-color: #D7E8F1; /*E8F2FE  D7E8F1*/
		}
		tr:hover td.big_title {
			background-color: #f1f8ff;
		}
		table.input {
			width: 100%;
			word-break: break-all;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			$("#farmerInfoForm").validate({
					rules: {
						/*农户状况*/
						//smFarmer: "required",
						nameFamer: "required",
						postcode: {
							digits: true
						},
						phone: {
							required: true,
							digits: true
						},
						population: "digits", // 整数
						/*地理信息*/
						altitude: "number",  //小数
						longitude: "number",
						latitude: "number",
					},
					messages: {
						/*农户状况*/
						//smFarmer: "请输入农户编码",
						nameFamer: "请输入户主姓名",
						postcode:{
							digits: "邮编必须为数字"	
						},
						phone: {
							required: "请输入手机号",
							digits: "手机号必须为数字"
						},
						population: "人口必须为数字",
						
						/*地理信息*/
						altitude: "海拔必须为数字",
						longitude: "经度必须为数字",
						latitude: "维度必须为数字"
					}
				
				});
				
				
			});
			
		function doAdd(){
			var smFarmer = $("#smFarmer").val();
			var address = $("#address").val();
			var province = $("#province").val();
			var city = $("#city").val();
			var district = $("#district").val();
			var town = $("#town").val();
			var village = $("#village").val();
			var group = $("#group").val();
			
			var nameFamer = $("#nameFamer").val();
			var postcode = $("#postcode").val();
			var phone = $("#phone").val();
			var population = $("#population").val();
			var economic = $("input[name='economic']:checked").val();
			var traffic = $("input[name='traffic']:checked").val();
			var geography = $("input[name='geography']:checked").val();
			var altitude = $("#altitude").val();
			var longitude = $("#longitude").val();
			var latitude = $("#latitude").val();
			
			$.post("saveFarmer", {
				smFarmer: smFarmer,
				address: address,
				nameFamer: nameFamer,
				postcode: postcode,
				phone: phone,
				population: population,
				economic: economic,
				traffic: traffic,
				geography: geography,
				altitude: altitude,
				longitude: longitude,
				latitude: latitude
			}, function(data){
				if (data == "ok") {
					$.messager.alert('', '操作成功', "info");
				} else {
					$.messager.alert('', '操作失败', "error");
				}
			}, "text")	
		}
		goback = function(){
			window.history.back();
		}
	</script>
</head>
<body>			
	<div class="path">路径>>添加农户</div>
	<form id="farmerInfoForm">
		<table class="input">
			<tr>
				<th><span class="requiredField">*</span>农户编号：</th>
				<td><input id="smFarmer" name="smFarmer" class="myinput" type="text" readonly="readonly" style="width:200px" value="${smFarmer }"/></td>
			</tr>
			<tr>
				<th><span class="requiredField">*</span>户主姓名：</th>
				<td><input id="nameFamer" type="text" name="nameFamer" class="myinput" maxlength="20" style="width:90px;"/></td>
			</tr>
			<tr>
				<th>地址：</th>
				<td><input id="address" name="address" class="myinput" type="text" style="width:200px"/></td>
			</tr>
			<tr>
				<th>邮编：</th>
				<td><input id="postcode" type="text" name="postcode" class="myinput" maxlength="10" style="width:90px;"/></td>
			</tr>
			<tr>
				<th><span class="requiredField">*</span>电话：</th>
				<td><input id="phone" name="phone" class="myinput" type="text" style="width:200px"/></td>
			</tr>
			<tr>
				<th>家庭人口：</th>
				<td><input id="population" name="population" class="myinput" type="text" style="width:90px"/>人</td>
			</tr>
			<tr>
				<th>经济状况:</th>
				<td>
					<input id="good" name="economic" type="radio" value="好"/>好
					<input id="common" name="economic" type="radio" value="一般"/>一般
					<input id="bad" name="economic" type="radio" value="差"/>差
				</td>
			</tr>
			<tr>
				<th>交通状况:</th>
				<td>
					<input id="good2" name="traffic" type="radio" value="好"/>好&nbsp;
					<input id="common2" name="traffic" type="radio" value="一般"/>一般&nbsp;
					<input id="bad2" name="traffic" type="radio" value="差"/>差
				</td>
			</tr>
			<tr>
				<th>地理环境:</th>
				<td>
					<input id="plain" name="geography" type="radio" value="平原"/>平原&nbsp;
					<input id="river_zone" name="geography" type="radio" value="滨湖河流地带"/>滨湖河流地带&nbsp;
					<input id="moutain_area" name="geography" type="radio" value="山区"/>山区&nbsp;
					<input id="moutain_basin" name="geography" type="radio" value="山区盆地"/>山区盆地&nbsp;
					<input id="foothill" name="geography" type="radio" value="丘陵地带"/>丘陵地带
				</td>
			</tr>
			<tr>
				<!-- <td class="big_title" rowspan="2" style="width:5%;">
					<div>
						地理信息
					</div>
				</td> -->
				<th>海拔高度:</th>
				<td><input id="altitude" name="altitude" class="myinput" type="text" style="width:150px"/>米</td>
			</tr>
			<tr>
				<th>GPS:</th>
				<td>GPS(E)<input id="longitude" name="longitude" class="myinput" type="text" style="width:150px"/>、
					GPS(N)<input id="latitude" name="latitude" class="myinput" type="text" style="width:150px"/>
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<!-- <input type="submit" class="button" value="确认"  /> -->
					<input type="button" class="button" value="确认" onclick="doAdd()" />
					<input type="button" class="button" onclick="goback()" value="返回" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>