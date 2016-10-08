<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>我国储粮虫螨区系调查与虫情监测预报信息平台</title>
	<link rel="icon" href="${base}/resources/images/fonter-icon.ico" type="image/x-icon" />	
	
	<link href="${base}/resources/shop/css/common2014.css" rel="stylesheet" type="text/css" />
	<link href="${base}/resources/shop/css/product.css" rel="stylesheet" type="text/css" />
	<link href="${base}/resources/shop/css/article.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.lazyload.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.tools.js"></script>
	<script type="text/javascript" src="${base}/resources/shop/js/jquery.jqzoom.js"></script>

	<script type="text/javascript">
		$().ready(function() {
		
		/*------------------------------mark-----------------------------------*/
		
			var $catalogForm = $("#catalogForm");
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
					$catalogForm.submit();
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
					$catalogForm.submit();
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
				$catalogForm.submit();
				return false;
			});
			
			$previousPage.click(function() {
				$pageNumber.val(${page.pageNumber - 1});
				$catalogForm.submit();
				return false;
			});
			
			$nextPage.click(function() {
				$pageNumber.val(${page.pageNumber + 1});
				$catalogForm.submit();
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
				$catalogForm.submit();
			});
			
			$sort.click(function() {
				var $this = $(this);
				if ($this.hasClass("current")) {
					$orderType.val("");
				} else {
					$orderType.val($this.attr("orderType"));
				}
				$pageNumber.val(1);
				$catalogForm.submit();
				return false;
			});
			
			$catalogForm.submit(function() {
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
				$catalogForm.submit();
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
			
			/*------------------------------mark--------------------------------------------*/
			
			var $headerLogin = $("#headerLogin");
			var $headerRegister = $("#headerRegister");
			var $headerUsername = $("#headerUsername");
			var $headerLogout = $("#headerLogout");
			var $catalogForm = $("#catalogForm");
			var $keyword = $("#catalogForm input");
			var defaultKeyword = "商品搜索";
			
			var username = getCookie("username");
			if (username != null) {
				$headerUsername.text("您好, " + username).show();
				$headerLogout.show();
			} else {
				$headerLogin.show();
				$headerRegister.show();
			}
			
			$keyword.focus(function() {
				if ($keyword.val() == defaultKeyword) {
					$keyword.val("");
				}
			});
			
			$keyword.blur(function() {
				if ($keyword.val() == "") {
					$keyword.val(defaultKeyword);
				}
			});
			
			$catalogForm.submit(function() {
				if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
					return false;
				}
			});
			
			
		});
	</script>
</head>
<body>
	[#include "/fonter/include/header.ftl" /]
	<div class="container productList productContent articleList">
		<!--左侧虫种类别 和 热门虫种-->
		[#include "/fonter/catalogindexlistmenu.html" /]
		<!--具体虫种列表-->
		<form id="catalogForm" action="${base}/catalogIndex/search.jhtml" method="get">
			<input type="hidden" name="keyword" value="${catalogIndexKeyword}"/>
			<input type="hidden" id="pageNumber" name="pageNumber" value="${page.pageNumber}" />
			
			<div class="result">
				[#if page.rows?has_content]
					<ul>
						[#list page.rows as catalogIndex]
							<li[#if !catalogIndex_has_next] class="last"[/#if]>
								<a href="${base}${catalogIndex.path}" title="${catalogIndex.mc}">${catalogIndex.mc}</a>
								${catalogIndex.ywm}
								<span>${catalogIndex.zylb}</span>
								<p>${abbreviate(catalogIndex.ms, 220, "...")}</p>
							</li>
						[/#list]
					</ul>
				[#else]
					没有搜索结果，请重新输入虫种关键字！
				[/#if]
			</div>
			[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "javascript: $.pageSkip({pageNumber});"]
				[#include "/fonter/include/pagination.ftl"]
			[/@pagination]
		</form>
		
	</div>
	[#include "/fonter/include/footer.ftl" /]
</body>
</html>