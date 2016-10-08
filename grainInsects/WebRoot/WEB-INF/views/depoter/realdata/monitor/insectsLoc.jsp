<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.print(path);
%>
<html>
<head>
<title>害虫分布数据</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.3.6/proj4.js"></script>
<script src="https://code.highcharts.com/maps/highmaps.js"></script>
<script src="https://code.highcharts.com/maps/modules/exporting.js"></script>
<script src="https://code.highcharts.com/mapdata/countries/cn/custom/cn-all-sar-taiwan.js"></script>
<script type="text/javascript">
	var chart, H, map;
    $(function () {
    	$.getJSON('${path}/grainInsects/depoter/realdatacollect/catalogIndexNameList', 
				function(result) {
			data = result.rows;
			$('#cc').combobox({
				multiple:true,
				data:data,
			    valueField:'text',
			    textField:'text'
			});
			
		});
    	
        H = Highcharts;
        map = H.maps['countries/cn/custom/cn-all-sar-taiwan'];
        drawMap([{
            name: 'Basemap',
            mapData: map,
            borderColor: '#606060',
            nullColor: 'rgba(200, 200, 200, 0.2)',
            showInLegend: false
        }, {
            name: 'Separators',
            type: 'mapline',
            data: H.geojson(map, 'mapline'),
            color: '#101010',
            enableMouseTracking: false,
            showInLegend: false
        }]);
    });
    
    function drawMap(series) {
    	$('#container').highcharts('Map', {

            title: {
                text: '害虫分布'
            },
            mapNavigation: {
                enabled: true,
                enableDoubleClickZoomTo: true
            },

            tooltip: {
                pointFormat:'纬度: {point.lat}<br>' +
                    '经度: {point.lon}<br>' +
                    '数量: {point.amount}'
            },

            xAxis: {
                crosshair: {
                    zIndex: 5,
                    dashStyle: 'dot',
                    snap: false,
                    color: 'gray'
                }
            },

            yAxis: {
                crosshair: {
                    zIndex: 5,
                    dashStyle: 'dot',
                    snap: false,
                    color: 'gray'
                }
            },

            series: series
        });
		$('#container').mousemove(function (e) {
            var position;

            if (chart) {
                if (!chart.lab) {
                    chart.lab = chart.renderer.text('', 0, 0)
                        .attr({
                            zIndex: 5
                        })
                        .css({
                            color: '#505050'
                        })
                        .add();
                }

                e = chart.pointer.normalize(e);
                position = chart.fromPointToLatLon({
                    x: chart.xAxis[0].toValue(e.chartX),
                    y: chart.yAxis[0].toValue(e.chartY)
                });

                chart.lab.attr({
                    x: e.chartX + 5,
                    y: e.chartY - 22,
                    text: '纬度: ' + position.lat.toFixed(2) + '<br>经度: ' + position.lon.toFixed(2)
                });
            }
        });

        $('#container').mouseout(function () {
            if (chart && chart.lab) {
                chart.lab.destroy();
                chart.lab = null;
            }
        });
    }
    function doSearch() {
    	var insectsTypes = $('#cc').combobox('getValues');
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
		$.post('/grainInsects/depoter/realdatacollect/insectsLocationNumber', 
				{kinds:insectsTypes,collectStart:from,collectEnd:to}, 
				function(result) {
					var series = [{
	                    name: 'Basemap',
	                    mapData: map,
	                    borderColor: '#606060',
	                    nullColor: 'rgba(200, 200, 200, 0.2)',
	                    showInLegend: false
	                }, {
	                    name: 'Separators',
	                    type: 'mapline',
	                    data: H.geojson(map, 'mapline'),
	                    color: '#101010',
	                    enableMouseTracking: false,
	                    showInLegend: false
	                }];
					result.insects.forEach(function(insect, index){
						var data = [];
						insect.data.forEach(function(dot) {
							data.push({
			                    "type": insect.name,
			                    "lat": dot.latitude,
			                    "lon": dot.longtitude,
			                    "amount": dot.number,
			                    'z': dot.number
			                  });
						});
						series.push({
							type: 'mapbubble',
		                    dataLabels: {
		                        enabled: false,
		                        format: ''
		                    },
		                    name: insect.name,
		                    data: data,
		                    maxSize: '12%',
		                    color: H.getOptions().colors[index]
						});
					});
					drawMap(series);
					parent.$.messager.progress('close');
				});
    }
</script>

</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div region="north" title="监控预报 > 害虫分布 > 过滤条件" style="height:60px ;overflow:hidden;">
		<div class="input-group">

			&nbsp时间：
			<input name="from" class="easyui-datebox">
			到
			<input name="to" class="easyui-datebox">
			&nbsp
			虫种:<input id="cc" name="insects" value="">
			<!-- &nbsp显示方式:
			<input type="radio" name="type" value="dayly" checked>按天
			<input type="radio" name="type" value="monthly">按月
			<input type="radio" name="type" value="yearly">按年 -->
			&nbsp<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a>
		</div>
    </div>
	<div data-options="region:'center',border:false" title="监控预报 > 害虫分布" style="overflow: hidden;">
		<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
	</div>
	<div id="toolbar" style="display: none;">
		
	</div>

</body>
</html>