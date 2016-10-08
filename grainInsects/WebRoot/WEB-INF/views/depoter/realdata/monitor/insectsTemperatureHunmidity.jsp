<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.print(path);
%>
<html>
<head>
<title>害虫数量、温度、湿度与时间的关系数据</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<jsp:include page="/common/highcharts.jsp"></jsp:include>

<script type="text/javascript">
	var param = {key:'',value:''}; 
	$(function () {	
		function setParam(key, value) {
			param.key = key;
			param.value = value;
		}
		function disableInput(params) {
			params.forEach(function(param) {
				$(param.element).attr('disabled', param.disabled);
				try	{
					if (param.disabled) {
						$(param.element).combobox('disable');
						$(param.element).combobox('clear');
					} else {
						$(param.element).combobox('enable');
					}
				} catch(e) {
					
				}
				
			});
		}
		
		//加载粮仓
		function loadBins() {
			$.getJSON('grainBins', function(result) {
				result.push({
					lcbm:'全部粮仓'
				});
				$('#bin').combobox({
					data:result,
				    valueField:'lcbm',
				    textField:'lcbm',
				    onSelect:function() {
				    	var id = $(this).combobox('getValue');
				    	if (id != '全部粮仓') {
				    		setParam('lcbm', id);
				    		loadDevices(id);
				    		disableInput([{
			    				element:'#device',
				    			disabled:false	
				    			}]);
				    	} else {
				    		setParam('lcbm', '');
				    		disableInput([{
			    				element:'#device',
				    			disabled:true	
				    			}]);
				    	}
				    }
				});
				$('#bin').combobox('select', '全部粮仓');
			});	
		}
		//加载设备
		function loadDevices(id) {
			$.getJSON('grainDevices?lcbm=' + id, function(result) {
				if(result.length != 0) {
					result.push({
						source: '所有设备'
					});
				}
				$('#device').combobox({
					data:result,
				    valueField:'source',
				    textField:'source',
				    multiple:true,
				    onSelect:function() {
				    	var device = $(this);
				    	var ids = device.combobox('getValues');
				    	if(ids.indexOf('所有设备') == -1) {
				    		console.log('selected');
				    		setParam('sources', device.combobox('getValues'));
				    	} else {
				    		var values = [];
				    		device.combobox('getData').forEach(function(value) {
					    		if (value.source != '所有设备') {
					    			values.push(value.source);
					    			device.combobox('unselect', value.source);
					    		}
					    	});
				    		setParam('sources', values);
				    	}
				    },
				    onUnselect: function() {
				    	var device = $(this);
				    	var ids = device.combobox('getValues');
				    	if(ids.indexOf('所有设备') == -1) {
				    		setParam('sources', device.combobox('getValues'));
				    	} else {
				    		setParam('sources', []);
				    	}
				    	if (param.value.length == 0) {
				    		param.key = 'lcbm';
				    		param.value = $('#bin').combobox('getValue');
				    	}
				    	
				    }
				});
			});	
		}
		loadBins();
		
		$.getJSON('catalogIndexNameList', 
				function(result) {
			data = result.rows;
			$('#insects').combobox({
				multiple:true,
				data:data,
			    valueField:'text',
			    textField:'text'
			});
			
		});

		Highcharts.setOptions({
			lang:{
				resetZoom:'重置缩放比例',
				months:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				shortMonths:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				weekdays:['周日','周一','周二','周三','周四','周五','周六']
			}
		});
	    $('#container').highcharts({
	        chart: {
	            zoomType: 'x'
	        },
	        title: {
	            text: '虫种数量与温度、湿度、时间的关系'
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: [{
	            title: {
	                text: '时间'
	            },
	            crosshair: true
	        }],
	        yAxis: [{ // Primary yAxis
	            labels: {
	                format: '{value}只',
	                style: {
	                    color: Highcharts.getOptions().colors[0]
	                }
	            },
	            title: {
	                text: '虫种数量',
	                style: {
	                    color: Highcharts.getOptions().colors[0]
	                }
	            }
	        }, { // Secondary yAxis
	            title: {
	                text: '温度',
	                style: {
	                    color: Highcharts.getOptions().colors[1]
	                }
	            },
	            labels: {
	                format: '{value} °C',
	                style: {
	                    color: Highcharts.getOptions().colors[1]
	                }
	            },
	            opposite: true
	        },{ // Tertiary yAxis
	            title: {
	                text: '湿度',
	                style: {
	                    color: Highcharts.getOptions().colors[2]
	                }
	            },
	            labels: {
	                format: '{value} %',
	                style: {
	                    color: Highcharts.getOptions().colors[2]
	                }
	            },
	            opposite: true
	        }],
	        tooltip: {
	            shared: true
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'left',
	            x: 80,
	            verticalAlign: 'top',
	            y: 55,
	            floating: true,
	            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
	        },
	        series: []
	    });
	});
	
	function listDevices(data) {
		 var html = '<p>';
		 data.forEach(function(device, index) {
			 if (index%4 == 0 && index != 0) {
				 html += '</p><p>';
			 }
			 html += (index+1) + '.设备:' + device.source + '&nbsp x:' + device.x + '&nbsp y:' + device.y + '&nbsp z:'+ device.z + '&nbsp&nbsp&nbsp&nbsp&nbsp'; 
		 });
		 html += '</p>';
		 $('#deviceContainer').html(html);
	}
	
	function doSearch() {
		var insectsTypes = $('#insects').combobox('getValues');
		var type = $('input[name=type]:checked').val();
		var from = $('input[name=from]').val();
		var to = $('input[name=to]').val();
		if (from == undefined || from == '') {
			$.messager.alert('错误','请选择起始时间！');
			return;
		}
		if (to == undefined || to == '') {
			$.messager.alert('错误','请选择结束时间！');
			return;
		}
		if (insectsTypes.length === 0) {
			$.messager.alert('错误','请选择虫种！');
			return;
		}
		parent.$.messager.progress({
			title: '提示',
			text: '数据处理中,请稍后.....'
		});
		queryUrl = '';
		query = {kinds:insectsTypes,
				collectStart:from,
				collectEnd:to};
		if(param.key != 'sources') {
			if (!(param.key == '' && param.value == '-1')) {
				query[param.key] = param.value;
			}
			queryUrl = 'insectsHumidityTemperatureDayNumber';
		} else {
			query[param.key] = param.value;
			queryUrl = 'insectsHumidityTemperatureDeviceNumber';
		}
		var colorIndex = 0;
		function genSeries(data, device) {
			var series = [];
			var tmp = from.split('-');
			var startDate = Date.UTC(tmp[0], --tmp[1], tmp[2]);
			data.insects.forEach(function(insect) {
				series.push({
					name : device ? device + ':' + insect.name:insect.name,
					type: 'spline',
		            yAxis: 0,
		            data: insect.data,
		            pointStart: startDate,
		            pointInterval:  24 * 3600 * 1000,
		            color:Highcharts.getOptions().colors[(colorIndex++) % 9],
		            tooltip: {
		                valueSuffix: ' 只'
		            }
				});
			});
			series.push({
                name: device ? device + ':' + '温度' : '温度',
                type: 'spline',
                yAxis: 1,
                data: data.temperature ,
                pointStart: startDate,
	            pointInterval:  24 * 3600 * 1000,
	            color:Highcharts.getOptions().colors[(colorIndex++) % 9],
                tooltip: {
                    valueSuffix: ' °C'
                }
            });
			series.push({
                name: device ? device + ':' + '湿度' : '湿度' ,
                type: 'spline',
                yAxis: 2,
                data: data.humidity,
                pointStart: startDate,
	            pointInterval:  24 * 3600 * 1000,
	            color:Highcharts.getOptions().colors[(colorIndex++) % 9],
                tooltip: {
                    valueSuffix: ' %'
                }
            });	
			return series;
		}
		$.post(queryUrl, query, function(result) {
				var series = [];
				if (queryUrl == 'insectsHumidityTemperatureDayNumber') {
					series = genSeries(result, 0);
					 $('#deviceContainer').html('');
				} else {
					result.data.forEach(function(data) {
						series = series.concat(genSeries(data, data.source));
					});
					listDevices(result.data);
				}
				$('#container').highcharts({
			        chart: {
			        	marginBottom: 150,
			            zoomType: 'x'
			        },
			        title: {
			            text: '虫种数量与温度、湿度、时间的关系'
			        },
			        subtitle: {
			            text: ''
			        },
			        xAxis: [{
			            title: {
			                text: '时间'
			            },
			            type: 'datetime',
			            maxZoom: 48 * 3600 * 1000
			        }],
			        yAxis: [{ // Primary yAxis
			            labels: {
			                format: '{value}只',
			                style: {
			                    color: Highcharts.getOptions().colors[0]
			                }
			            },
			            title: {
			                text: '虫种数量',
			                style: {
			                    color: Highcharts.getOptions().colors[0]
			                }
			            }
			        }, { // Secondary yAxis
			            title: {
			                text: '温度',
			                style: {
			                    color: Highcharts.getOptions().colors[1]
			                }
			            },
			            labels: {
			                format: '{value} °C',
			                style: {
			                   // color: Highcharts.getOptions().colors[1]
			                }
			            },
			            opposite: true
			        },{ // Tertiary yAxis
			            title: {
			                text: '湿度',
			                style: {
			                   // color: Highcharts.getOptions().colors[2]
			                }
			            },
			            labels: {
			                format: '{value} %',
			                style: {
			                    color: Highcharts.getOptions().colors[2]
			                }
			            },
			            opposite: true
			        }],
			        tooltip: {
			            shared: true
			        },
			        legend: {
			        	borderWidth: 1,
			            layout: 'horizontal',
			            align: 'left',
			            verticalAlign: 'bottom',
			            floating: true,
			            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
			        },
			        series: series
			    });
				parent.$.messager.progress('close');
			});
	}
</script>

<style>
</style>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div region="north" title="监控预报 > 数据监控 > 过滤条件" style="height:100px ;overflow:hidden;">
		<div class="input-group">
			&nbsp
			粮仓:<input id="bin"  value="">
	
			设备:<input id="device" value="" disabled='disabled'>
		</div>
		<div class="input-group">
			&nbsp时间:
			<input name="from" class="easyui-datebox">
			到
			<input name="to" class="easyui-datebox">
			&nbsp
			虫种:<input id="insects" name="insects" value="">
			&nbsp<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a>
		</div>
    </div>
	<div data-options="region:'center',border:false" title="监控预报 > 数据监控" style="">
		<div id="deviceContainer" class="easyui-panel" style="padding:10px;">
		</div>
		<div id="container" style="height:500px"></div>
	</div>
	<div id="toolbar" style="display: none;">
		
	</div>

</body>
</html>