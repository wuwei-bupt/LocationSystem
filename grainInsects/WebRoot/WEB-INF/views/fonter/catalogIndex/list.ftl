<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>我国储粮虫螨区系调查与虫情监测预报信息平台</title>
	<link rel="icon" href="${base}/resources/images/fonter-icon.ico" type="image/x-icon" />	
	
	<link href="${base}/resources/shop/css/common2014.css" rel="stylesheet" type="text/css" />
	<link href="${base}/resources/shop/css/product.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.lazyload.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.tools.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.jqzoom.js"></script>

	<script type="text/javascript">
		$().ready(function() {
		
		/*------------------------------mark-----------------------------------*/
		
			var $productForm = $("#productForm");
			var $brandId = $("#brandId");
			var $promotionId = $("#promotionId");
			var $orderType = $("#orderType");
			var $pageNumber = $("#pageNumber");
			var $pageSize = $("#pageSize");
			var $filter = $("#filter dl");
			var $lastFilter = $("#filter dl:eq(2)");
			var $hiddenFilter = $("#filter dl:gt(2)");
			var $moreOption = $("#filter dd.moreOption");
			var $moreFilter = $("#moreFilter a");
			var $tableType = $("#tableType");
			var $listType = $("#listType");
			var $orderSelect = $("#orderSelect");
			var $brand = $("#filter a.brand");
			var $attribute = $("#filter a.attribute");
			var $previousPage = $("#previousPage");
			var $nextPage = $("#nextPage");
			var $size = $("#layout a.size");
			var $tagIds = $("input[name='tagIds']");
			var $sort = $("#sort a");
			var $startPrice = $("#startPrice");
			var $endPrice = $("#endPrice");
			var $result = $("#result");
			var $productImage = $("#result img");
			
			[#if insectCategory??]
				$filter.each(function() {
					var $this = $(this);
					var height = $this.height();
					if (height > 30) {
						$this.find("dt").height(height);
						if ($this.find("a.current").size() == 0) {
							$this.height(30);
							$this.find(".moreOption").show();
						}
					}
				});
				
				$moreOption.click(function() {
					var $this = $(this);
					if ($this.hasClass("close")) {
						$this.removeClass("close");
						$this.attr("title", "${message("shop.product.moreOption")}");
						$this.parent().height(30);
					} else {
						$this.addClass("close");
						$this.attr("title", "${message("shop.product.closeOption")}");
						$this.parent().height("auto");
					}
				});
				
				$moreFilter.click(function() {
					var $this = $(this);
					if ($this.hasClass("close")) {
						$this.removeClass("close");
						$this.text("${message("shop.product.moreFilter")}");
						$lastFilter.addClass("last");
						$hiddenFilter.hide();
					} else {
						$this.addClass("close");
						$this.text("${message("shop.product.closeFilter")}");
						$lastFilter.removeClass("last");
						$hiddenFilter.show();
					}
				});
				
				$brand.click(function() {
					var $this = $(this);
					if ($this.hasClass("current")) {
						$brandId.val("");
					} else {
						$brandId.val($this.attr("brandId"));
					}
					$pageNumber.val(1);
					$productForm.submit();
					return false;
				});
				
				$attribute.click(function() {
					var $this = $(this);
					if ($this.hasClass("current")) {
						$this.closest("dl").find("input").prop("disabled", true);
					} else {
						$this.closest("dl").find("input").prop("disabled", false).val($this.text());
					}
					$pageNumber.val(1);
					$productForm.submit();
					return false;
				});
			[/#if]
			
			var layoutType = getCookie("layoutType");
			if (layoutType == "listType") {
				$listType.addClass("currentList");
				$result.removeClass("table").addClass("list");
			} else {
				$tableType.addClass("currentTable");
				$result.removeClass("list").addClass("table");
			}
			
			$tableType.click(function() {
				var $this = $(this);
				if (!$this.hasClass("currentTable")) {
					$this.addClass("currentTable");
					$listType.removeClass("currentList");
					$result.removeClass("list").addClass("table");
					addCookie("layoutType", "tableType", {path: "${base}/"});
				}
			});
			
			$listType.click(function() {
				var $this = $(this);
				if (!$this.hasClass("currentList")) {
					$this.addClass("currentList");
					$tableType.removeClass("currentTable");
					$result.removeClass("table").addClass("list");
					addCookie("layoutType", "listType", {path: "${base}/"});
				}
			});
			
			$size.click(function() {
				var $this = $(this);
				$pageNumber.val(1);
				$pageSize.val($this.attr("pageSize"));
				$productForm.submit();
				return false;
			});
			
			$previousPage.click(function() {
				$pageNumber.val(${page.pageNumber - 1});
				$productForm.submit();
				return false;
			});
			
			$nextPage.click(function() {
				$pageNumber.val(${page.pageNumber + 1});
				$productForm.submit();
				return false;
			});
			
			$orderSelect.mouseover(function() {
				var $this = $(this);
				var offset = $this.offset();
				var $menuWrap = $this.closest("div.orderSelect");
				var $popupMenu = $menuWrap.children("div.popupMenu");
				$popupMenu.css({left: offset.left, top: offset.top + $this.height()}).show();
				$menuWrap.mouseleave(function() {
					$popupMenu.hide();
				});
			});
			
			$tagIds.click(function() {
				$pageNumber.val(1);
				$productForm.submit();
			});
			
			$sort.click(function() {
				var $this = $(this);
				if ($this.hasClass("current")) {
					$orderType.val("");
				} else {
					$orderType.val($this.attr("orderType"));
				}
				$pageNumber.val(1);
				$productForm.submit();
				return false;
			});
			
			$productForm.submit(function() {
				if ($promotionId.val() == "") {
					$promotionId.prop("disabled", true)
				}
				if ($orderType.val() == "" || $orderType.val() == "topDesc") {
					$orderType.prop("disabled", true)
				}
				if ($pageNumber.val() == "" || $pageNumber.val() == "1") {
					$pageNumber.prop("disabled", true)
				}
				if ($pageSize.val() == "" || $pageSize.val() == "20") {
					$pageSize.prop("disabled", true)
				}
			});
			
			$productImage.lazyload({
				threshold: 100,
				effect: "fadeIn"
			});
			
			$.pageSkip = function(pageNumber) {
				$pageNumber.val(pageNumber);
				$productForm.submit();
				return false;
			}
			
			/*------------------------------------mark---------------------------------------------*/
			var $historyProduct = $("#historyProduct ul");
			var $zoom = $("#zoom");
			var $scrollable = $("#scrollable");
			var $thumbnail = $("#scrollable a");
			var $specification = $("#specification dl");
			var $specificationTitle = $("#specification div");
			var $specificationValue = $("#specification a");
			var $productNotify = $("#productNotify");
			var $productNotifyEmail = $("#productNotify input");
			var $window = $(window);
			var $tabbar = $("#tabbar ul");
			var $introductionTab = $("#introductionTab");
			var $parameterTab = $("#parameterTab");
			var $reviewTab = $("#reviewTab");
			var $consultationTab = $("#consultationTab");
			var $introduction = $("#introduction");
			var $parameter = $("#parameter");
			var $review = $("#review");
			var $addReview = $("#addReview");
			var $consultation = $("#consultation");
			var $addConsultation = $("#addConsultation");
			var barTop = $tabbar.offset().top;
			var productMap = {};
			productMap[241] = { path: null, specificationValues: [ ] };	
			// 锁定规格值
			lockSpecificationValue();
			
			// 商品图片放大镜
			$zoom.jqzoom({
				zoomWidth: 368,
				zoomHeight: 368,
				title: false,
				showPreload: false,
				preloadImages: false
			});
			
			// 商品缩略图滚动
			$scrollable.scrollable();
			
			$thumbnail.hover(function() {
				var $this = $(this);
				if ($this.hasClass("current")) {
					return false;
				} else {
					$thumbnail.removeClass("current");
					$this.addClass("current").click();
				}
			});
			
			// 规格值选择
			$specificationValue.click(function() {
				var $this = $(this);
				if ($this.hasClass("locked")) {
					return false;
				}
				$this.toggleClass("selected").parent().siblings().children("a").removeClass("selected");
				var selectedIds = new Array();
				$specificationValue.filter(".selected").each(function(i) {
					selectedIds[i] = $(this).attr("val");
				});
				var locked = true;
				$.each(productMap, function(i, product) {
					if (product.specificationValues.length == selectedIds.length && contains(product.specificationValues, selectedIds)) {
						if (product.path != null) {
							location.href = "/shopxx" + product.path;
							locked = false;
						}
						return false;
					}
				});
				if (locked) {
					lockSpecificationValue();
				}
				$specificationTitle.hide();
				return false;
			});
			
			// 锁定规格值
			function lockSpecificationValue() {
				var selectedIds = new Array();
				$specificationValue.filter(".selected").each(function(i) {
					selectedIds[i] = $(this).attr("val");
				});
				$specification.each(function() {
					var $this = $(this);
					var selectedId = $this.find("a.selected").attr("val");
					var otherIds = $.grep(selectedIds, function(n, i) {
						return n != selectedId;
					});
					$this.find("a").each(function() {
						var $this = $(this);
						otherIds.push($this.attr("val"));
						var locked = true;
						$.each(productMap, function(i, product) {
							if (contains(product.specificationValues, otherIds)) {
								locked = false;
								return false;
							}
						});
						if (locked) {
							$this.addClass("locked");
						} else {
							$this.removeClass("locked");
						}
						otherIds.pop();
					});
				});
			}
			
			// 判断是否包含
			function contains(array, values) {
				var contains = true;
				for(i in values) {
					if ($.inArray(values[i], array) < 0) {
						contains = false;
						break;
					}
				}
				return contains;
			}
			
			
			$window.scroll(function() {
				var scrollTop = $(this).scrollTop();
				if (scrollTop > barTop) {
					if (window.XMLHttpRequest) {
						$tabbar.css({position: "fixed", top: 0});
					} else {
						$tabbar.css({top: scrollTop});
					}
					var introductionTop = $introduction.size() > 0 ? $introduction.offset().top - 36 : null;
					var parameterTop = $parameter.size() > 0 ? $parameter.offset().top - 36 : null;
					var reviewTop = $review.size() > 0 ? $review.offset().top - 36 : null;
					var consultationTop = $consultation.size() > 0 ? $consultation.offset().top - 36 : null;
					if (consultationTop != null && scrollTop >= consultationTop) {
						$tabbar.find("li").removeClass("current");
						$consultationTab.addClass("current");
					} else if (reviewTop != null && scrollTop >= reviewTop) {
						$tabbar.find("li").removeClass("current");
						$reviewTab.addClass("current");
					} else if (parameterTop != null && scrollTop >= parameterTop) {
						$tabbar.find("li").removeClass("current");
						$parameterTab.addClass("current");
					} else if (introductionTop != null && scrollTop >= introductionTop) {
						$tabbar.find("li").removeClass("current");
						$introductionTab.addClass("current");
					}
				} else {
					$tabbar.find("li").removeClass("current");
					$tabbar.css({position: "absolute", top: barTop});
				}
			});
		});
	</script>
</head>
<body>
	[#include "/fonter/include/header.ftl" /]
	<div class="container productList productContent">
		<!--左侧虫种类别 和 热门虫种-->
		[#include "/fonter/catalogindexlistmenu.html" /]
		
		<!--右侧虫种的筛选和显示-->
		<div class="span18 last">
			<!--顶部虫种路径-->
			<div class="path">
				<ul>
					<li>
						<a href="${base}/fonter/index">${message("shop.path.home")}</a>
					</li>
					[#if insectCategory??]
						[@insect_category_parent_list insectCategoryId = insectCategory.id]
							[#list insectCategories as insectCategory]
								<li>
									<a href="${base}${insectCategory.path}">${insectCategory.mc}</a>
								</li>
							[/#list]
						[/@insect_category_parent_list]
						<li class="last">${insectCategory.mc}</li>
					[#else]
						<li class="last">${message("shop.product.title")}</li>
					[/#if]
				</ul>
			</div>
			
			
			<!--虫种图片-->
			<div class="productImage">
				[#if insectCategory.TCatalogPics?has_content]
					<a id="zoom" href="${insectCategory.TCatalogPics[0].large}" rel="gallery">
						<img class="medium" src="${insectCategory.TCatalogPics[0].medium}" />
					</a>
				[#else]
					<a id="zoom" href="${base}${setting.defaultLargeProductImage}" rel="gallery">
						<img class="medium" src="${base}${setting.defaultMediumProductImage}" />
					</a>
				[/#if]
				<a href="javascript:;" class="prev"></a>
				<div id="scrollable" class="scrollable">
					<div class="items">
						[#if insectCategory.TCatalogPics?has_content]
							[#list insectCategory.TCatalogPics as insectImage]
								<a[#if insectImage_index == 0] class="current"[/#if] href="javascript:;" rel="{gallery: 'gallery', smallimage: '${insectImage.medium}', largeimage: '${insectImage.large}'}"><img src="${insectImage.thumbnail}" title="${insectImage.title}" /></a>
							[/#list]
						[#else]
							<a class="current" href="javascript:;"><img src="${base}${setting.defaultThumbnailProductImage}" /></a>
						[/#if]
					</div>
				</div>
				<a href="javascript:;" class="next"></a>
			</div>
			
			<!-- 虫种信息介绍 -->
			<div class="name">${insectCategory.mc}-${insectCategory.ywm}[${insectCategory.ymc}]</div>
			<div class="sn">
				<div>重要害虫类别: ${insectCategory.zylb}</div>
			</div>
			<div class="info">
				<dl>
					<dt>关键词:</dt>
					<dd>
						<strong>${insectCategory.keywords}</strong>
					</dd>
				</dl>
				<dl>
					<dt>资料来源:</dt>
					<dd>${insectCategory.source}</dd>
					<dt>危害对象:</dt>
					<dd>${insectCategory.whdx}</dd>
				</dl>
			</div>
			
			<!--虫种的参数展示-->
			[#if insectCategory.tz?has_content || insectCategory.shxx?has_content 
					|| insectCategory.fb?has_content || insectCategory.wh?has_content 
					|| insectCategory.ms?has_content || insectCategory.TCatalogPics?has_content 
					|| insectCategory.TDigitalFeatures?has_content || insectCategory.TPreventprocesses?has_content]
				<div id="tabbar" class="tabbar">
					<ul>
						<!--特征-->
						[#if insectCategory.tz?has_content]
							<li id="introductionTab">
								<a href="#tz">虫种特征</a>
							</li>
						[/#if]
						<!--生活习性-->
						[#if insectCategory.shxx?has_content]
							<li id="introductionTab">
								<a href="#shxx">生活习性</a>
							</li>
						[/#if]
						<!--分布-->
						[#if insectCategory.fb?has_content]
							<li id="introductionTab">
								<a href="#fb">虫种分布</a>
							</li>
						[/#if]
						<!--危害-->
						[#if insectCategory.wh?has_content]
							<li id="introductionTab">
								<a href="#wh">主要危害</a>
							</li>
						[/#if]
						
						<!--虫种描述-->
						[#if insectCategory.ms?has_content]
							<li id="introductionTab">
								<a href="#introduction">虫种描述</a>
							</li>
						[/#if]
						<!--虫种分类特征图片-->
						[#if insectCategory.TCatalogPics?has_content]
							<li id="parameterTab">
								<a href="#catalogPics">虫种图片</a>
							</li>
						[/#if]
						<!--虫种数字特征图片-->
						[#if insectCategory.TDigitalFeatures?has_content]
							<li id="reviewTab">
								<a href="#digitalFeatures">数字特征</a>
							</li>
						[/#if]
						<!--防治工艺-->
						[#if insectCategory.tPreventprocesses?has_content]
							<li id="consultationTab">
								<a href="#preventprocesses">防治工艺</a>
							</li>
						[/#if]
					</ul>
				</div>
			[/#if]
			
			
			<!--虫种特征-->
			[#if insectCategory.tz?has_content]
				<div id="tz" name="introduction" class="introduction">
					<div class="title">
						<strong>虫种特征</strong>
					</div>
					<div>
						${insectCategory.tz}
					</div>
				</div>
			[/#if]
			<!--生活习性-->
			[#if insectCategory.shxx?has_content]
				<div id="shxx" name="introduction" class="introduction">
					<div class="title">
						<strong>生活习性</strong>
					</div>
					<div>
						${insectCategory.shxx}
					</div>
				</div>
			[/#if]
			<!--虫种分布-->
			[#if insectCategory.fb?has_content]
				<div id="fb" name="introduction" class="introduction">
					<div class="title">
						<strong>虫种分布</strong>
					</div>
					<div>
						${insectCategory.fb}
					</div>
				</div>
			[/#if]
			<!--主要危害-->
			[#if insectCategory.wh?has_content]
				<div id="wh" name="introduction" class="introduction">
					<div class="title">
						<strong>主要危害</strong>
					</div>
					<div>
						${insectCategory.wh}
					</div>
				</div>
			[/#if]
			
			<!--虫种描述-->
			[#if insectCategory.ms?has_content]
				<div id="introduction" name="introduction" class="introduction">
					<div class="title">
						<strong>虫种描述</strong>
					</div>
					<div>
						${insectCategory.ms}
					</div>
				</div>
			[/#if]
			
			<!--虫种图片-->
			[#if insectCategory.TCatalogPics?has_content]
				<div id="catalogPics" name="parameter" class="parameter">
					<div class="title">
						<strong>虫种图片</strong>
					</div>
					
					<div align="center">
					[#list insectCategory.TCatalogPics as tCatalogPics]
						<p><br><img alt="" src="${tCatalogPics.medium}"></p>
					[/#list]
					</div>
				</div>
			[/#if]
			
			<!--数字特征-->
			[#if insectCategory.TDigitalFeatures?has_content]
				<div id="digitalFeatures" name="review" class="review">
					<div class="title">数字特征</div>
					<div align="center">
						<table>
						[#list insectCategory.TDigitalFeatures as tDigitalFeature]
							[#if tDigitalFeature?has_content]
								<tr>
									<th>${tDigitalFeature.name}</th>
									<td>${tDigitalFeature.value}</td>
								</tr>
							[/#if]
						[/#list]
						</table>
					</div>
				</div>
			[/#if]
			
			<!--防治工艺表-->
			[#if insectCategory.tPreventprocesses?has_content]
				<div id="preventprocesses" name="preventprocesses" class="review">
					<div class="title">防治工艺</div>
					<div align="center">
						<table>
						[#list insectCategory.tPreventprocesses as tPreventprocesses]
							[#if tPreventprocesses?has_content]
								<tr>
									<th>工艺名称</th>
									<td>${tPreventprocesses.proname}</td>
								</tr>
								<tr>
									<th>工艺类型</th>
									<td>${tPreventprocesses.TProctype.fullName}</td>
								</tr>
							[/#if]
						[/#list]
						</table>
					</div>
				</div>
			[/#if]
			
			
			<div class="h20-2014"></div><!--这个对下面样式的控制很重要！！！！-->
			
			<!--虫种筛选条件-->
			[#if insectCategory?? && insectCategory.children?has_content]
				<form id="productForm" action="${base}${(insectCategory.path)!"/catalogIndex/list.jhtml"}" method="get">
					<input type="hidden" id="orderType" name="orderType" value="${orderType}" />
					<input type="hidden" id="pageNumber" name="pageNumber" value="${page.pageNumber}" />
					<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize}" />
					
					<!--过滤虫种条件-->
					<div class="bar">
						<div id="layout" class="layout">
							<label>${message("shop.product.layout")}:</label>
							<a href="javascript:;" id="tableType" class="tableType">
								<span>&nbsp;</span>
							</a>
							<a href="javascript:;" id="listType" class="listType">
								<span>&nbsp;</span>
							</a>
							<label>${message("shop.product.pageSize")}:</label>
							<a href="javascript:;" class="size[#if page.pageSize == 4] current[/#if]" pageSize="4">
								<span>4</span>
							</a>
							<a href="javascript:;" class="size[#if page.pageSize == 8] current[/#if]" pageSize="8">
								<span>8</span>
							</a>
							<span class="page">
								<label>${message("shop.product.totalCount", page.total)} ${page.pageNumber}/[#if page.totalPages > 0]${page.totalPages}[#else]1[/#if]</label>
								[#if page.totalPages > 0]
									[#if page.pageNumber != 1]
										<a href="javascript:;" id="previousPage" class="previousPage">
											<span>${message("shop.product.previousPage")}</span>
										</a>
									[/#if]
									[#if page.pageNumber != page.totalPages]
										<a href="javascript:;" id="nextPage" class="nextPage">
											<span>${message("shop.product.nextPage")}</span>
										</a>
									[/#if]
								[/#if]
							</span>
						</div>
						<div id="sort" class="sort">
							<div id="orderSelect" class="orderSelect">
								[#if orderType??]
									<span>${message("Product.OrderType." + orderType)}</span>
								[#else]
									<span>${message("Product.OrderType." + orderTypes[0])}</span>
								[/#if]
								<div class="popupMenu">
									<ul>
										[#list orderTypes as ot]
											<li>
												<a href="javascript:;"[#if ot == orderType] class="current" title="${message("shop.product.cancel")}"[/#if] orderType="${ot}">${message("Product.OrderType." + ot)}</a>
											</li>
										[/#list]
									</ul>
								</div>
							</div>
							<a href="javascript:;"[#if orderType == "monthHitsDesc"] class="currentAsc current" title="${message("shop.product.cancel")}"[#else] class="asc"[/#if] orderType="monthHitsDesc">点击数</a>
							[#--
							<a href="javascript:;"[#if orderType == "salesDesc"] class="currentDesc current" title="${message("shop.product.cancel")}"[#else] class="desc"[/#if] orderType="salesDesc">${message("shop.product.salesDesc")}</a>
							<a href="javascript:;"[#if orderType == "scoreDesc"] class="currentDesc current" title="${message("shop.product.cancel")}"[#else] class="desc"[/#if] orderType="scoreDesc">${message("shop.product.scoreDesc")}</a>
							--]
							<input type="text" id="startPrice" name="startPrice" class="startPrice" value="${startPrice}" maxlength="16" title="${message("shop.product.startPrice")}" onpaste="return false" />-<input type="text" id="endPrice" name="endPrice" class="endPrice" value="${endPrice}" maxlength="16" title="${message("shop.product.endPrice")}" onpaste="return false" />
							<button type="submit">${message("shop.product.submit")}</button>
						</div>
						<div class="tag">
							<label>${message("shop.product.tag")}:</label>
							[#assign tagList = tags /]
							[@tag_list type = "insect"]
								[#list tags as tag]
									<label>
										<input type="checkbox" name="tagIds" value="${tag.id}"[#if tagList?seq_contains(tag)] checked="checked"[/#if] />${tag.name}
									</label>
								[/#list]
							[/@tag_list]
						</div>
					</div>
					
					<!--筛选虫种-->
					[#if insectCategory?? && (insectCategory.children?has_content || insectCategory.attributes?has_content)]
						<div id="filter" class="filter">
							<div class="title">筛选虫种</div>
							<div class="content">
								[#assign rows = 0 /]
								[#if insectCategory.children?has_content]
									[#assign rows = rows + 1 /]
									<dl[#if !insectCategory.attributes?has_content] class="last"[/#if]>
										<dt>${message("shop.product.productCategory")}:</dt>
										[#list insectCategory.children as category]
											<dd>
												<a href="${base}${category.path}">${category.mc}</a>
											</dd>
										[/#list]
										<dd class="moreOption" title="${message("shop.product.moreOption")}">&nbsp;</dd>
									</dl>
								[/#if]
								[#list insectCategory.attributes as attribute]
									[#assign rows = rows + 1 /]
									<dl[#if rows == 3 || !attribute_has_next] class="last"[/#if][#if rows > 3 && !attributeValue?keys?seq_contains(attribute)] style="display: none;"[/#if]>
										<dt>
											<input type="hidden" name="attribute_${attribute.id}"[#if attributeValue?keys?seq_contains(attribute)] value="${attributeValue.get(attribute)}"[#else] disabled="disabled"[/#if] />
											<span title="${attribute.name}">${abbreviate(attribute.name, 12)}:</span>
										</dt>
										[#list attribute.options as option]
											<dd>
												<a href="javascript:;"[#if attributeValue.get(attribute) == option] class="attribute current" title="${message("shop.product.cancel")}"[#else] class="attribute"[/#if]>${option}</a>
											</dd>
										[/#list]
										<dd class="moreOption" title="${message("shop.product.moreOption")}">&nbsp;</dd>
									</dl>
								[/#list]
							</div>
							<div id="moreFilter" class="moreFilter">
								[#if rows > 3]
									<a href="javascript:;">${message("shop.product.moreFilter")}</a>
								[#else]
									&nbsp;
								[/#if]
							</div>
						</div>
					[/#if]
					
					<!--显示筛选的虫种列表-->
					<div id="result" class="result table clearfix">
						[#if page.rows?has_content]
							<ul>
								[#list page.rows?chunk(4) as row]  <!--chunk(4)四个一换行-->
									[#list row as product]
										<li[#if !row_has_next] class="last"[/#if]>
											<a href="${base}${product.path}">
												<img src="${base}/upload/image/blank.gif" width="170" height="170" data-original="[#if product.thumbnail??]${product.thumbnail}[#else]${base}${setting.defaultThumbnailProductImage}[/#if]" />
										
												<span title="${product.mc}">${abbreviate(product.mc, 60)}</span>
											</a>
										</li>
									[/#list]
								[/#list]
							</ul>
						[#else]
							${message("shop.product.noListResult")}
						[/#if]
					</div>
					
					<!--底部分页信息-->
					[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "javascript: $.pageSkip({pageNumber});"]
						[#include "/fonter/include/pagination.ftl"]
					[/@pagination]
				</form>
			[#else]
				<!--${message("shop.product.noListResult")}-->
				<div class="h20-2014">
					<strong>该虫种没有子类！</strong>
				</div>
			[/#if]
		</div>
	</div>
	[#include "/fonter/include/footer.ftl" /]
</body>
</html>