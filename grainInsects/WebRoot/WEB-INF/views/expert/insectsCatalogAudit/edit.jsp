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
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
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
			zylb:{required:true}
		},
 		submitHandler: function() {
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
		
	var editorList = new Array();
	if(typeof(KindEditor) != "undefined") {
		KindEditor.ready(function(K) {
			editorList[0]=K.create("#tzeditor",options);
			editorList[1]=K.create("#shxxeditor",options);
			editorList[2]=K.create("#fbeditor",options);
			editorList[3]=K.create("#wheditor",options);
			editorList[4]=K.create("#mseditor",options);
			editorList[5]=K.create("#auditadviceeditor",options);
		});
	};
	
	$basicInformation.click(function(){
		$(".datagrid").hide();
		$("#saveIndex").hide();
		$("#expertAuditTable").hide();
	});
	
	$diffFeature.click(function(){
		$(".datagrid").hide();
		$("#saveIndex").hide();
		$("#expertAuditTable").hide();
	});
	
	$expertAudit.click(function(){
		$(".datagrid").hide();
		$("#saveIndex").show();
		$("#expertAuditTable").show();
	});
	
	$digitalFeature.click(function(){
		$(".datagrid").show();
		$("#expertAuditTable").hide();
		$("#saveIndex").hide();
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
			$("#insectsIcon").combobox({
			textField:'text',
			valueField:'icon',
			data:[{
				"text":"暗褐郭公虫",
				"icon":"anheguogongchong"
			},{
				"text":"白带圆皮蠹",
				"icon":"baidaiyuanpidu"
			},{
				"text":"白腹皮蠹",
				"icon":"baifupidu"
			},{
				"text":"巴西豆象",
				"icon":"baxidouxiang"
			},{
				"text":"毕氏粉盗",
				"icon":"bishifendao"
			},{
				"text":"波纹毛皮蠹",
				"icon":"bowenmaopidu"
			},{
				"text":"波纹皮蠹",
				"icon":"bowenpidu"
			},{
				"text":"波纹蕈甲",
				"icon":"bowenxunjia"
			},{
				"text":"伯氏嗜木螨",
				"icon":"boshishimuman"
			},{
				"text":"菜豆象",
				"icon":"laidouxiang"
			},{
				"text":"蚕豆象",
				"icon":"candouxiang"
			},{
				"text":"仓储阎虫",
				"icon":"cangchuyanchong"
			},{
				"text":"仓潜",
				"icon":"cangqian"
			},{
				"text":"赤颈郭公虫",
				"icon":"chijingguogongchong"
			},{
				"text":"赤毛皮蠹",
				"icon":"chimaopidu"
			},{
				"text":"赤拟谷盗",
				"icon":"chinigudao"
			},{
				"text":"赤足郭公虫",
				"icon":"chizuguogongchong"
			},{
				"text":"粗脚粉螨",
				"icon":"cujiaofenman"
			},{
				"text":"大谷盗",
				"icon":"dagudao"
			},{
				"text":"大谷蠹",
				"icon":"dagudu"
			},{
				"text":"大理窃蠹",
				"icon":"daliqiedu"
			},{
				"text":"大眼锯谷盗",
				"icon":"dayanjugudao"
			},{
				"text":"大腋露尾甲",
				"icon":"dayeluweijia"
			},{
				"text":"地中海螟",
				"icon":"dingzhonghaiming"
			},{
				"text":"东方薪甲",
				"icon":"dongfangxinjia"
			},{
				"text":"短角露尾甲",
				"icon":"duanjiaoluweijia"
			},{
				"text":"断镰螯螨",
				"icon":"duanlianaoman"
			},{
				"text":"二带黑菌虫",
				"icon":"erdaiheijunchong"
			},{
				"text":"粉斑螟",
				"icon":"fenbanming"
			},{
				"text":"粉尘螨",
				"icon":"fenchenman"
			},{
				"text":"弗氏无爪螨",
				"icon":"fushiwuzhuaman"
			},{
				"text":"腐食酪螨",
				"icon":"fushilaoman"
			},{
				"text":"甘薯小象虫",
				"icon":"ganshuxiaoxiangchong"
			},{
				"text":"干果露尾甲",
				"icon":"ganguoluweijia"
			},{
				"text":"干向酪螨",
				"icon":"ganxianglaoman"
			},{
				"text":"拱殖嗜渣螨",
				"icon":"gongzhishizhaman"
			},{
				"text":"钩纹皮蠹",
				"icon":"gouwenpidu"
			},{
				"text":"谷斑皮蠹",
				"icon":"gubanpidu"
			},{
				"text":"谷蠹",
				"icon":"gudu"
			},{
				"text":"谷蛾",
				"icon":"gue"
			},{
				"text":"谷跗线螨",
				"icon":"gufuxianman"
			},{
				"text":"谷象",
				"icon":"guxiang"
			},{
				"text":"害嗜鳞螨",
				"icon":"haishilinman"
			},{
				"text":"河野脂螨",
				"icon":"heyezhiman"
			},{
				"text":"赫氏蒲螨",
				"icon":"heshipuman"
			},{
				"text":"褐粉蠹",
				"icon":"hefendu"
			},{
				"text":"褐蕈甲",
				"icon":"hexunjia"
			},{
				"text":"褐蛛甲",
				"icon":"hezhujia"
			},{
				"text":"黑矮阎虫",
				"icon":"heiaiyanchong"
			},{
				"text":"黑粉虫",
				"icon":"heifenchong"
			},{
				"text":"黑菌虫",
				"icon":"heijunchong"
			},{
				"text":"黑毛皮蠹",
				"icon":"heimaopidu"
			},{
				"text":"红带皮蠹",
				"icon":"hongdaipidu"
			},{
				"text":"红颈小蕈甲",
				"icon":"hongjingxiaoxunjia"
			},{
				"text":"花斑皮蠹",
				"icon":"huabanpidu"
			},{
				"text":"滑菌甲螨",
				"icon":"huajunjiaman"
			},{
				"text":"黄斑露尾甲",
				"icon":"huangbanluweijia"
			},{
				"text":"黄粉虫",
				"icon":"huangfenchong"
			},{
				"text":"灰豆象",
				"icon":"huidouxiang"
			},{
				"text":"火腿皮蠹",
				"icon":"huotuipidu"
			},{
				"text":"姬粉盗",
				"icon":"jifendao"
			},{
				"text":"脊胸露尾甲",
				"icon":"jixiongluweijia"
			},{
				"text":"家食甜螨",
				"icon":"jiashitianman"
			},{
				"text":"锯谷盗",
				"icon":"jugudao"
			},{
				"text":"菌食嗜菌螨",
				"icon":"junshishijunman"
			},{
				"text":"咖啡豆象",
				"icon":"kafeidouxiang"
			},{
				"text":"阔鼻谷象",
				"icon":"kuobiguxiang"
			},{
				"text":"阔角谷盗",
				"icon":"kuojiaogudao"
			},{
				"text":"酪阳厉螨",
				"icon":"laoyangliman"
			},{
				"text":"鳞翅触足螨",
				"icon":"linchichuzuman"
			},{
				"text":"鳞毛粉蠹",
				"icon":"linmaofendu"
			},{
				"text":"隆胸露尾甲",
				"icon":"longxiongluweijia"
			},{
				"text":"裸蛛甲",
				"icon":"luozhujia"
			},{
				"text":"绿豆象",
				"icon":"lvdouxiang"
			},{
				"text":"马六甲肉食螨",
				"icon":"maliujiaroushiman"
			},{
				"text":"麦蛾",
				"icon":"maie"
			},{
				"text":"毛蕈甲",
				"icon":"maoxunjia"
			},{
				"text":"蒙古沙潜",
				"icon":"menggushaqian"
			},{
				"text":"米扁虫",
				"icon":"mibianchong"
			},{
				"text":"米淡墨虫",
				"icon":"midanmochong"
			},{
				"text":"米蛾",
				"icon":"mie"
			},{
				"text":"米象",
				"icon":"mixiang"
			},{
				"text":"棉兰皱皮螨",
				"icon":"mianlanzhoupiman"
			},{
				"text":"纳氏皱皮螨",
				"icon":"nashizhoupiman"
			},{
				"text":"拟白腹皮蠹",
				"icon":"nibaifupidu"
			},{
				"text":"拟裸蛛甲",
				"icon":"niluozhujia"
			},{
				"text":"鸟翼巨须螨",
				"icon":"niaoyijuxuman"
			},{
				"text":"牛真扇毛螨",
				"icon":"niuzhenshanmaoman"
			},{
				"text":"普通肉食螨",
				"icon":"putongroushiman"
			},{
				"text":"青蓝郭公虫",
				"icon":"qinglanguogongchong"
			},{
				"text":"日本琵琶甲",
				"icon":"ribenpipajia"
			},{
				"text":"日本蛛甲",
				"icon":"ribenzhujia"
			},{
				"text":"沙潜",
				"icon":"shaqian"
			},{
				"text":"深沟粉盗",
				"icon":"shengoufendao"
			},{
				"text":"湿薪甲",
				"icon":"shixinjia"
			},{
				"text":"食虫狭螨",
				"icon":"baxidouxiang"
			},{
				"text":"瘦隐甲",
				"icon":"shouyinjia"
			},{
				"text":"书窃蠹",
				"icon":"shuqiedu"
			},{
				"text":"双齿锯谷盗",
				"icon":"shuangchijugudao"
			},{
				"text":"双齿长蠹",
				"icon":"shuangchichangdu"
			},{
				"text":"水芋根螨",
				"icon":"shuiyugenman"
			},{
				"text":"四点谷蛾",
				"icon":"sidiangue"
			},{
				"text":"四行薪甲",
				"icon":"sixingxinjia"
			},{
				"text":"四纹豆象",
				"icon":"siwendouxiang"
			},{
				"text":"四纹露尾甲",
				"icon":"siwenluweijia"
			},{
				"text":"速生薄口螨",
				"icon":"sushengbokouman"
			},{
				"text":"甜果螨",
				"icon":"tianguoman"
			},{
				"text":"头角薪甲",
				"icon":"toujiaoxinjia"
			},{
				"text":"土耳其扁谷盗",
				"icon":"tuerqibiangudao"
			},{
				"text":"椭圆食粉螨",
				"icon":"tuoyuanshifenman"
			},{
				"text":"椭圆薪甲",
				"icon":"tuoyuanxinjia"
			},{
				"text":"豌豆象",
				"icon":"wandouxaing"
			},{
				"text":"屋尘螨",
				"icon":"wuchenman"
			},{
				"text":"无色书虱",
				"icon":"wuseshushi"
			},{
				"text":"细颈露尾甲",
				"icon":"xijingluweijia"
			},{
				"text":"暹逻谷盗",
				"icon":"xianluogudao"
			},{
				"text":"小斑螟",
				"icon":"xiaobanming"
			},{
				"text":"小粉盗",
				"icon":"xiaofendao"
			},{
				"text":"小菌虫",
				"icon":"xiaojunchong"
			},{
				"text":"小蕈甲",
				"icon":"xiaoxunjia"
			},{
				"text":"小隐甲",
				"icon":"xiaoyinjia"
			},{
				"text":"小圆虫",
				"icon":"xiaoyuanchong"
			},{
				"text":"小圆皮蠹",
				"icon":"xiaoyuanpidu"
			},{
				"text":"锈赤扁谷盗",
				"icon":"xiuchibiangudao"
			},{
				"text":"亚扁粉盗",
				"icon":"yabianfendao"
			},{
				"text":"烟草甲",
				"icon":"yancaojia"
			},{
				"text":"烟草螟",
				"icon":"yancaoming"
			},{
				"text":"阳罩单梳螨",
				"icon":"yangzhaodanshuman"
			},{
				"text":"洋虫",
				"icon":"yangchong"
			},{
				"text":"药材甲",
				"icon":"yaocaijia"
			},{
				"text":"一点谷蛾",
				"icon":"yidiangue"
			},{
				"text":"印度谷螟",
				"icon":"yinduguming"
			},{
				"text":"鹰嘴豆象",
				"icon":"yingzuidouxiang"
			},{
				"text":"玉米象",
				"icon":"yumixiang"
			},{
				"text":"圆锤皮蠹",
				"icon":"yuanzhuipidu"
			},{
				"text":"杂拟谷盗",
				"icon":"zanigudao"
			},{
				"text":"皂荚豆象",
				"icon":"zaojiadouxiang"
			},{
				"text":"长角扁谷盗",
				"icon":"baxidouxiang"
			},{
				"text":"长食酪螨",
				"icon":"baxidouxiang"
			},{
				"text":"长头谷盗",
				"icon":"baxidouxiang"
			},{
				"text":"针吸螨",
				"icon":"zhenximan"
			},{
				"text":"栉角窃蠹",
				"icon":"zhijiaoqiedu"
			},{
				"text":"中华垫甲",
				"icon":"zhonghuadianjia"
			},{
				"text":"中华粉蠹",
				"icon":"zhonghuafendu"
			},{
				"text":"中华龙甲",
				"icon":"zhonghualongjia"
			},{
				"text":"中华真扇毛螨",
				"icon":"zhonghuazhenshanmaoman"
			},{
				"text":"竹蠹",
				"icon":"zhudu"
			},{
				"text":"紫斑谷螟",
				"icon":"zibanguming"
			},{
				"text":"棕脊足螨",
				"icon":"zongjizuman"
			}],
			 formatter:function(row){
			 	//var imageFile = '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/insects/'+ row.icon +'.png';
		        var imageFile = '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/insects/baxidouxiang.png';
		        return '<img class="item-img" src="'+imageFile+'"/><span class="item-text">'+row.text+'</span>';
		    	//return '<a plain="false" class="easyui-linkbutton" href="javascript:void(0)" iconCls="'+imageFile+'">'+row.text+'</a>';
		    }
		});
			var zylb = "${catalogIndex.zylb}";
			$("#zylb").attr("value",zylb);
			
			var passaudit = "${catalogIndex.passaudit}";
			if(passaudit == "" ||passaudit == undefined)
				$("#passaudit").attr("value",false);
			else
				$("#passaudit").attr("value",passaudit);
			
			$("td input,td a,textarea,select").not("#inputForm *").attr("disabled","disabled");
			
});
	
	doAdd = function(){
		$("#inputForm").submit();
	};
	
	goback = function(){
		window.history.back();
	};
	
    //保存数字特征
    function saveItem(index){
    	cancelItem(index);
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
</script>
</head>
<body>
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
				<tr><th> 图标录入：</th><td><input id="insectsIcon" name="iconCls" value="${catalogIndex.iconCls}"/></td></tr>
				<tr><th><span class="requiredField">*</span> 编码：</th><td><input type="text" name="bm" value="${catalogIndex.bm}" maxlength="30" style="width: 200px;" /></td></tr>
				<tr><th><span class="requiredField">*</span> 分类码：</th><td><input type="text" name="flm" value="${catalogIndex.flm}" maxlength="6"/></td></tr>
				<tr><th><span class="requiredField">*</span> 中文名：</th><td><input type="text" name="mc" value="${catalogIndex.mc}" maxlength="60" style="width: 300px;"/></td></tr>
				<tr><th><span class="requiredField">*</span> 英文名：</th><td><input type="text" name="ywm" value="${catalogIndex.ywm}" maxlength="200" style="width: 400px;"/></td></tr>
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
					        <label><input type="checkbox" name="preventprocessIds" value="${ptag.sm}" checked="checked"/>${ptag.proname}</label>
					    </c:when>
					    <c:otherwise>
					        <label><input type="checkbox" name="preventprocessIds" value="${ptag.sm}"/>${ptag.proname}</label>
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
				
				<tr><th> 资料来源：</th><td colspan="3"><input type="text" name="source" value="${catalogIndex.source}" maxlength="100"/></td></tr>
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
							<input type="text" name="TCatalogPics[${status.index}].order" class="text productImageOrder" value="${pic.order}" maxlength="9" style="width: 50px;" />
						</td>
						<td>
							<a href="javascript:;" id="deleteBinImage" class="deleteBinImage">[ 删除 ]</a>
						</td>
					</tr>				
				</c:forEach>
			</table>
		
			<!-- 数字识别特征 -->	
			<table class="easyui-datagrid" id="digitalFeatureTable">
			</table>
			
		<form id="inputForm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${cid}"/>
			<table class="input" id="expertAuditTable" style="display:none;">
				<tr><th> 审核通过：</th><td>
				<select id="passaudit" name="passaudit" style="width: 300px;" value="${catalogIndex.passaudit}">
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
				<tr><th> 审核时间：</th> <td>${catalogIndex.audittime}</td>	</tr>
			</table>
		</form>
			
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

</body>
</html>