<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<title>我国储粮虫螨区系调查与虫情监测预报信息平台</title>
<link rel="icon" href="${base}/resources/images/fonter-icon.ico" type="image/x-icon" />
<link href="${base}/resources/shop/slider/slider.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/common2016.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/slider2/css/css.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/popwin/css/popwin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/menu.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="${base}/resources/shop/slider/slider.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/shop/popwin/js/popwin.js"></script>
<script type="text/javascript" src="${base}/resources/shop/recommend/recommend.js"></script>

<script type="text/javascript">
	
	$().ready(function() {
		//延时显示函数
		;(function(a) { 
			a.fn.hoverDelay = function(c, f, g, b) {
				var g = g || 200,
				b = b || 200,
				f = f || c;
				var e = [],
				d = [];
				return this.each(function(h) {
					a(this).mouseenter(function() {
						var i = this;
						clearTimeout(d[h]);
						e[h] = setTimeout(function() {
							c.apply(i)
						},
					g)
					}).mouseleave(function() {
						var i = this;
						clearTimeout(e[h]);
						d[h] = setTimeout(function() {
							f.apply(i)
						},
						b)
					})
				})
			}
		})(jQuery);
		
		$(".sidebar_item dd").hoverDelay(function() {
			$(this).find("h3").addClass("sidebar_focus");
			document.getElementById("tab1").style.display = "block";clearTimeout(aa);
			$(this).find(".sidebar_popup,.dis1").show(0);
		},
		function() {
			$(this).find("h3").removeClass("sidebar_focus");
			$(this).find(".sidebar_popup,.dis1").hide(0);
		});
		
		
		
		var $slider = $("#slider");

		$slider.nivoSlider({
			effect: "random",
			animSpeed: 1000,
			pauseTime: 6000,
			controlNav: true,
			keyboardNav: false,
			captionOpacity: 0.4
		});

	});
	
	var aa;
	function over1(){
		document.getElementById("tab1").style.display = "block";clearTimeout(aa);
	}
	function out1(){
		aa = setTimeout(hide,100);
	}
	function hide(){
		document.getElementById("tab1").style.display = "none"
	}
	
	
	//收藏本站
	function addFavorite(site_url,site_name)
	{
		var the_pagetitle=site_name;
		var the_pageurl=site_url;
		if(the_pageurl=="")
		{
			the_pageurl=window.location.href;
		}
		if(the_pagetitle=="")
		{	
			the_pagetitle=document.title;
		}
		try
		{
			window.external.addFavorite(the_pageurl,the_pagetitle);
		}
		catch(e)
		{
			try
			{
				window.sidebar.addPanel(the_pagetitle,the_pageurl,"");
			}
			catch(e)
			{
				alert("抱歉，您所使用的浏览器无法完成此操作。\n\n加入收藏失败，请使用Ctrl+D进行添加！");
			}
		}
	}	
</script>
</head>
<body>
	<div class="head_top">
		<div class="container-2014">
			<ul class="fl">
				<li><a href="#" onclick="javascript:addFavorite('http://220.194.54.81:8080/grainInsects/','绿色储粮综合信息平台');">收藏本站</a></li>	
			</ul>	
			<ul class="fr">
				<li class="fore1" id="headerWelcome" style="display: list-item;">
				       您好，欢迎来到我国储粮虫螨区系调查与虫情检测预报信息平台！
				</li>

				[@navigation_list position = "top"]
					[#list navigations as navigation]
						<li class="menu">
							<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
						</li>
						[#if navigation_has_next]<li class="line">|</li>[/#if]
					[/#list]
				[/@navigation_list]
			</ul>
		</div>
	</div>
	<div class="container-2014">
		<div class="head_top_2">
			<div class="logo">
				<a href="${base}/">	<img src="${base}${setting.logo}" alt="${setting.siteName}" /> </a>
			</div>
			<div id="search-2014">
				<div class="i-search ld">
					<form id="productSearchForm" class="form" action="${base}/catalogIndex/search.jhtml" method="get">
						<input name="keyword" class="text keyword" value="${productKeyword!message("shop.header.keyword")}" maxlength="30" />
						<button class="button" type="submit">搜索</button>
					</form>
				</div>
	
			</div>
		</div>
	</div>
	<!--  mark   -->
	<div class="container-2014">
		<ul class="mainNav">
			[@navigation_list position = "middle"]
				[#assign len = navigations?size]
				[#assign perSize = 100/len]
				[#list navigations as navigation]
					<li[#if navigation.url = url] class="current"[/#if] style="width:${perSize}%">
						<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
					</li>
				[/#list]
			[/@navigation_list]
		</ul>
	</div>
	
	<div class="container-2014">
		<div style="height:10px;"></div>
	</div>
	
	<!-- top-left ad_position -->
	<div class="container-2014 index-2014">
		<!--左侧虫种类别 和 热门虫种-->
		<div class="span6" style="float:left; margin-right:6px;">
			<div class="hotProductCategory">
				[@insect_category_root_list count = 8]
					<dl>
						<dt>
							<a href="#">储粮虫螨数据库</a>
						</dt>
					</dl>
					[#assign itemIndex = 1 /]
					[#list insectCategories as category]
						[#if itemIndex gt 15]
							[#break]
						[/#if]
						<dl[#if !category_has_next] class="last"[/#if]>
							[@insect_category_children_list insectCategoryId = category.id]
								[#assign itemIndex = itemIndex + 1 /]
								[#assign path =  category.path /]
								[#if insectCategories?size gt 4]
									<dt>
										<a href="${base}${category.path}">${category.mc}</a>
										<span style="margin-right:3px;"><a href="${base}${category.path}">更多> </a></span>
									</dt>
								[#else]
									<dt>
										<a href="${base}${category.path}">${category.mc}</a>
									</dt>
								[/#if]
								[#list insectCategories as insectCategory]
									
									<dd>
										<a href="${base}${insectCategory.path}">${insectCategory.mc}</a>
									</dd>
									[#if (insectCategory_index == 0) || (insectCategory_index == 2)]
										[#assign itemIndex = itemIndex + 1 /]
									[/#if]
									[#if insectCategory_index == 3]
										[#break]
									[/#if]
								[/#list]
							[/@insect_category_children_list]
						</dl>
					[/#list]
				[/@insect_category_root_list]
				<dl>
					<dt>
						<a href="${base}${path}">更多</a>
					</dt>
				</dl>
			</div>
		</div>
		<div class="top-left-2014" style="float:left;">
			<div class="jdt-2014">
				[@ad_position id = 3 /]
			</div>
		</div>
		<div class="zxkb-2014">
			[#--[@article_category_root_list count=1]--]
				<div class="title">
					<h3>新闻中心</h3>
					<span><a href="${base}/article/list/10.jhtml" target="_blank">更多新闻&gt;</a></span>
				</div>
				<div class="news">
					[@article_list articleCategoryId = 10 orderBy="createDate desc" count = 10]
							<ul class="con">
								[#list articles as article]
									<li>
										<a href="${base}${article.path}" title="${article.title}" target="_blank">${abbreviate(article.title, 30)}</a>
									</li>
								[/#list]
							</ul>
					[/@article_list]
					[#--[#list articleCategories as articleCategory]
						[@article_list articleCategoryId = articleCategory.id orderBy="createDate desc" count = 10]
							<ul class="con">
								[#list articles as article]
									<li>
										<a href="${base}${article.path}" title="${article.title}" target="_blank">${abbreviate(article.title, 30)}</a>
									</li>
								[/#list]
							</ul>
						[/@article_list]
					[/#list]--]
				</div>
			[#--[/@article_category_root_list]--]
			
            <div class="zxkb-2014">
				<ul class="title">
					<li class="current">
						<a>通知公告</a>
					</li>
					<span class="baojia_m"><a href="${base}/article/list/3.jhtml" target="_blank">查看更多&gt;</a></span>
				</ul>
				<!--以下放通知通告-->
				<div class="news">
					[@article_list articleCategoryId = 3 orderBy="createDate desc" count = 10]
							<ul class="con">
								[#list articles as article]
									<li>
										<a href="${base}${article.path}" title="${article.title}" target="_blank">${abbreviate(article.title, 30)}</a>
									</li>
								[/#list]
							</ul>
					[/@article_list]
				</div>
				<!--	
				<ul class="tabContent" style="display: block;">
					<script type="text/javascript" src="${base}/resources/shop/js/ScrollUp.js"></script>
					<script type="text/javascript">
						$(".offer-link").ScrollUp({rollspeed:150});
					</script>
				</ul>
				-->
			</div>
		</div>
	</div>
	<!--检疫害虫 start -->
	[#--
	<div class="container-2014">
		<div class="catalogue-2014">
			<div class="mt ld">
				<div class="floor">
					<b class="fixpng b b1"></b>
					<b class="fixpng b b2" style="height: 34px; display: block;"></b>
					<b class="b b3">1F</b><b class="fixpng b4"></b>
				</div>
				<h2>
					<a href="#">检疫害虫</a>
				</h2>
			</div>
			<div class="mc">
				<ul class="lh">
				[@insect_category_children_list insectCategoryName = "检疫害虫" count = 4 orderBy="isTop desc"]
					[#list insectCategories as insectCategory]
						<li>
							<a href="${base}${insectCategory.path}">${insectCategory.mc}</a>
						</li>
					[/#list]
				[/@insect_category_children_list]
				</ul>
				<ul class="ad-1f-2014">
					[@ad_position id = 10 /]
				</ul>
			</div>
		</div>
		<div class="product-2014" id="Product1">
				[@insect_category_children_list insectCategoryName = "检疫害虫" count = 4 orderBy="isTop desc"]
					<ul class="title tab">
						[#list insectCategories as insectCategory]
							<li>
								<a href="${base}${insectCategory.path}" target="_blank">${insectCategory.mc}</a>
							</li>
						[/#list]
					</ul>
					[#list insectCategories as insectCategory]
						<ul class="tabContent">
							[@insect_category_children_list insectCategoryId = insectCategory.id count = 4 orderBy="monthHits desc"]
								[#list insectCategories as insectCategory2]
									<dl class="con">
										<dt>
											<a href="${base}${insectCategory2.path}" title="${insectCategory2.mc}" target="_blank"><img alt="${insectCategory2.mc}" src="[#if insectCategory.image??]${insectCategory2.image}[#else]${setting.defaultThumbnailProductImage}[/#if]" data-original="[#if insectCategory2.image??]${insectCategory2.image}[#else]${setting.defaultThumbnailProductImage}[/#if]" /></a>
										</dt>
										<dd>
											<p class="bt"><a href="${base}${insectCategory2.path}" title="${insectCategory2.mc}" target="_blank">${abbreviate(insectCategory2.mc)}</a></p>
										</dd>
									</dl>
								[/#list]
							[/@insect_category_children_list]
						</ul>
					[/#list]
				[/@insect_category_children_list]
		</div>
		<div class="f_ad-2014">
			<ul class="ad_small">
				[@ad_position id = 11 /]
			</ul>
			<ul class="ad_big">
				[@ad_position id = 12 /]
			</ul>
		</div>
	</div>
	<div class="h20-2014"></div>
	--]
	<!--检疫害虫 end -->
	
	<!--蛀食害虫 start -->
	[#--
	<div class="container-2014">
		<div class="catalogue-2014">
			<div class="mt ld">
				<div class="floor">
					<b class="fixpng b b1"></b>
					<b class="fixpng b b2" style="height: 34px; display: block;"></b>
					<b class="b b3">2F</b><b class="fixpng b4"></b>
				</div>
				<h2><a href="${base}/catalogIndex/mainList/蛀食害虫.jhtml" target="_blank">蛀食害虫</a>
					<a href="#">蛀食害虫</a>
				</h2>
			</div>
			<div class="mc">
				<ul class="lh">
				[@insect_category_children_list insectCategoryName = "蛀食害虫" count = 4 orderBy="isTop desc"]
					[#list insectCategories as insectCategory]
						<li>
							<a href="${base}${insectCategory.path}">${insectCategory.mc}</a>
						</li>
					[/#list]
				[/@insect_category_children_list]
				</ul>
				<ul class="ad-1f-2014">
					[@ad_position id = 13 /]
				</ul>
			</div>
		</div>
		<div class="product-2014" id="Product2">
				[@insect_category_children_list insectCategoryName = "蛀食害虫" count = 4 orderBy="isTop desc"]
					<ul class="title tab">
						[#list insectCategories as insectCategory]
							<li>
								<a href="${base}${insectCategory.path}" target="_blank">${insectCategory.mc}</a>
							</li>
						[/#list]
					</ul>
					[#list insectCategories as insectCategory]
						<ul class="tabContent">
							[@insect_category_children_list insectCategoryId = insectCategory.id count = 4 orderBy="monthHits desc"]
								[#list insectCategories as insectCategory2]
									<dl class="con">
										<dt>
											<a href="${base}${insectCategory2.path}" title="${insectCategory2.mc}" target="_blank"><img alt="${insectCategory2.mc}" src="[#if insectCategory.image??]${insectCategory2.image}[#else]${setting.defaultThumbnailProductImage}[/#if]" data-original="[#if insectCategory2.image??]${insectCategory2.image}[#else]${setting.defaultThumbnailProductImage}[/#if]" /></a>
										</dt>
										<dd>
											<p class="bt"><a href="${base}${insectCategory2.path}" title="${insectCategory2.mc}" target="_blank">${abbreviate(insectCategory2.mc)}</a></p>
										</dd>
									</dl>
								[/#list]
							[/@insect_category_children_list]
						</ul>
					[/#list]
				[/@insect_category_children_list]
		</div>
		<div class="f_ad-2014">
			<ul class="ad_small">
					[@ad_position id = 14 /]

			</ul>
			<ul class="ad_big">
					[@ad_position id = 15 /]

			</ul>
		</div>
	</div>
	<div class="h20-2014"></div>
	--]
	<!--蛀食害虫 end -->
	
	<!--粉食类 start -->
	[#--
	<div class="container-2014">
		<div class="catalogue-2014">
			<div class="mt ld">
				<div class="floor">
					<b class="fixpng b b1"></b>
					<b class="fixpng b b2" style="height: 34px; display: block;"></b>
					<b class="b b3">3F</b><b class="fixpng b4"></b>
				</div>
				<h2><<a href="${base}/catalogIndex/mainList/粉食类.jhtml" target="_blank">粉食类</a>
					<a href="#">粉食类</a>
				</h2>
			</div>
			<div class="mc">
				<ul class="lh">
				[@insect_category_children_list insectCategoryName = "粉食类" count = 4 orderBy="isTop desc"]
					[#list insectCategories as insectCategory]
						<li>
							<a href="${base}${insectCategory.path}">${insectCategory.mc}</a>
						</li>
					[/#list]
				[/@insect_category_children_list]
				</ul>
				<ul class="ad-1f-2014">
                	[@ad_position id = 16 /]
				</ul>
			</div>
		</div>
		<div class="product-2014" id="Product3">
				[@insect_category_children_list insectCategoryName = "粉食类" count = 4 orderBy="isTop desc"]
					<ul class="title tab">
						[#list insectCategories as insectCategory]
							<li>
								<a href="${base}${insectCategory.path}" target="_blank">${insectCategory.mc}</a>
							</li>
						[/#list]
					</ul>
					[#list insectCategories as insectCategory]
						<ul class="tabContent">
							[@insect_category_children_list insectCategoryId = insectCategory.id count = 4 orderBy="monthHits desc"]
								[#list insectCategories as insectCategory2]
									<dl class="con">
										<dt>
											<a href="${base}${insectCategory2.path}" title="${insectCategory2.mc}" target="_blank"><img alt="${insectCategory2.mc}" src="[#if insectCategory.image??]${insectCategory2.image}[#else]${setting.defaultThumbnailProductImage}[/#if]" data-original="[#if insectCategory2.image??]${insectCategory2.image}[#else]${setting.defaultThumbnailProductImage}[/#if]" /></a>
										</dt>
										<dd>
											<p class="bt"><a href="${base}${insectCategory2.path}" title="${insectCategory2.mc}" target="_blank">${abbreviate(insectCategory2.mc)}</a></p>
										</dd>
									</dl>
								[/#list]
							[/@insect_category_children_list]
						</ul>
					[/#list]
				[/@insect_category_children_list]
		</div>
		<div class="f_ad-2014">
			<ul class="ad_small">
				[@ad_position id = 17 /]
			</ul>
			<ul class="ad_big">
				[@ad_position id = 18 /]
			</ul>
		</div>
	</div>
	<div class="h20-2014"></div>
	--]
	<!--粉食类 end -->
	
	<!--其他重要害虫 start -->
	[#--
	<div class="container-2014">
		<div class="catalogue-2014">
			<div class="mt ld">
				<div class="floor">
					<b class="fixpng b b1"></b>
					<b class="fixpng b b2" style="height: 34px; display: block;"></b>
					<b class="b b3">4F</b><b class="fixpng b4"></b>
				</div>
				<h2><a href="${base}/catalogIndex/mainList/其他重要害虫.jhtml" target="_blank">其他重要害虫</a>
					<a href="#">其他重要害虫</a>
				</h2>
			</div>
			<div class="mc">
				<ul class="lh">
				[@insect_category_children_list insectCategoryName = "其他重要害虫" count = 4 orderBy="isTop desc"]
					[#list insectCategories as insectCategory]
						<li>
							<a href="${base}${insectCategory.path}">${insectCategory.mc}</a>
						</li>
					[/#list]
				[/@insect_category_children_list]
				</ul>
				<ul class="ad-1f-2014">
					[@ad_position id = 19 /]
				</ul>
			</div>
		</div>
		<div class="product-2014" id="Product4">
			[@insect_category_children_list insectCategoryName = "其他重要害虫" count = 4 orderBy="isTop desc"]
				<ul class="title tab">
					[#list insectCategories as insectCategory]
						<li>
							<a href="${base}${insectCategory.path}" target="_blank">${insectCategory.mc}</a>
						</li>
					[/#list]
				</ul>
				[#list insectCategories as insectCategory]
					<ul class="tabContent">
						[@insect_category_children_list insectCategoryId = insectCategory.id count = 4 orderBy="monthHits desc"]
							[#list insectCategories as insectCategory2]
								<dl class="con">
									<dt>
										<a href="${base}${insectCategory2.path}" title="${insectCategory2.mc}" target="_blank"><img alt="${insectCategory2.mc}" src="[#if insectCategory.image??]${insectCategory2.image}[#else]${setting.defaultThumbnailProductImage}[/#if]" data-original="[#if insectCategory2.image??]${insectCategory2.image}[#else]${setting.defaultThumbnailProductImage}[/#if]" /></a>
									</dt>
									<dd>
										<p class="bt"><a href="${base}${insectCategory2.path}" title="${insectCategory2.mc}" target="_blank">${abbreviate(insectCategory2.mc)}</a></p>
									</dd>
								</dl>
							[/#list]
						[/@insect_category_children_list]
					</ul>
				[/#list]
			[/@insect_category_children_list]
		</div>
		<div class="f_ad-2014">
			<ul class="ad_small">
				[@ad_position id = 20 /]
			</ul>
			<ul class="ad_big">
				[@ad_position id = 21 /]
			</ul>
		</div>
	</div>
	--]
	<!--其他重要害虫 end -->
	
	[#-- <div class="h20-2014"></div>
	<div class="container-2014">
		<div id="service-2014">
			<dl class="fore1">
				<dt><b></b><strong>购物指南</strong></dt>
				<dd>
					[@navigation_list position = "shop"]
						[#list navigations as navigation]
							<div>
								<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
							</div>
						[/#list]
						[/@navigation_list]
				</dd>
			</dl>
			<dl class="fore2">		
				<dt><b></b><strong>配送方式</strong></dt>
				<dd>
					[@navigation_list position = "distribution"]
						[#list navigations as navigation]
							<div>
								<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
							</div>
						[/#list]
					[/@navigation_list]
				</dd>
			</dl>
			<dl class="fore3">
				<dt><b></b><strong>支付方式</strong></dt>
				<dd>
						[@navigation_list position = "payment"]
						[#list navigations as navigation]
							<div>
								<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
							</div>
						[/#list]
						[/@navigation_list]
				</dd>
			</dl>
			<dl class="fore4">		
				<dt><b></b><strong>售后服务</strong></dt>
				<dd>
					[@navigation_list position = "customer"]
						[#list navigations as navigation]
							<div>
								<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
							</div>
						[/#list]
					[/@navigation_list]
				</dd>
			</dl>
			<dl class="fore5">
				<dt><b></b><strong>特色服务</strong></dt>
				<dd>		
					[@navigation_list position = "feature"]	
						[#list navigations as navigation]
							<div>
								<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
							</div>
						[/#list]
					[/@navigation_list]
				</dd>
			</dl>
		</div>
	</div> --]
	
	<div class="container-2014">
		<div class="friendLink-2014">
				<dl>
					<dt>${message("shop.index.friendLink")}</dt>
					[@friend_link_list count = 10]
						[#list friendLinks as friendLink]
							<dd>
								[#if friendLink.type == "image"]
									<a href="${friendLink.url}" target="_blank">
									<img src="${friendLink.logo}"  alt="${friendLink.name}" title="${friendLink.name}" />
									</a>
								[#else]	
								<a href="${friendLink.url}" target="_blank">${friendLink.name}</a>
								[/#if]
								[#if friendLink_has_next]|[/#if]
							</dd>
						[/#list]
					[/@friend_link_list]
					
					<dd class="more">
						<a href="${base}/friend_link.jhtml">${message("shop.index.more")}</a>
					</dd>
					
				</dl>
		</div>
	</div>
	[#--
	<div class="container-2014">
		[@ad_position id = 2 /]
	</div>
	<div class="container-2014">
		<ul class="bottomNav-2014">
			[@navigation_list position = "bottom"]
				[#list navigations as navigation]
					<li>
						<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
						[#if navigation_has_next]|[/#if]
					</li>
				[/#list]
			[/@navigation_list]
		</ul>
	</div> --]
	<!--
	<div class="container-2014">
		<div class="copyright-2014">
			
			玻璃城·玻璃交易平台 版权所有 Copyright©2014-2016 咨询热线：0319-8751133  <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&amp;uin=2868625215&amp;site=qq&amp;menu=yes">业务合作</a>   <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&amp;uin=3239093988&amp;site=qq&amp;menu=yes">物流咨询</a><br>
			河北省电子商务示范企业&nbsp;&nbsp;&nbsp;&nbsp;河北省信息化与工业化融合公共服务示范平台<br>
			河北省电子商务协会理事单位<br>
			冀ICP备 13007106号-4&nbsp;&nbsp;&nbsp;&nbsp;经营许可证编号  冀B2-20130093&nbsp;&nbsp;&nbsp;&nbsp;邢公备 13058202005796<br>
			<img src="${base}/resources/shop/images/2014/bcp_cs.gif" /> 
			
		</div>
	</div>
	-->
	<!--回到顶部 START//-->
	<!--
	<div id="moquu_wxin" class="moquu_wxin"><a href="javascript:void(0)">玻璃交易平台<div class="moquu_wxinh"></div></a></div>
	<div id="moquu_wshare" class="moquu_wshare"><a href="javascript:void(0)">玻璃交易平台<div class="moquu_wshareh"></div></a></div>
	<a id="moquu_top" href="javascript:void(0)"></a>
	-->
	<!--回到顶部 END//-->
	<!--QQ客服START-->
	<!--
	<div class="main-im">
		<div id="open_im" class="open-im">&nbsp;</div>  
		<div class="im_main" id="im_main">
			<div id="close_im" class="close-im"><a href="javascript:void(0);" title="点击关闭">&nbsp;</a></div>
			<a class="im-qq qq-a" title="在线QQ客服">
				<div class="qq-container"></div>
				<div class="qq-hover-c"><img class="img-qq" src="${base}/resources/shop/popwin/images/qq.png"></div>
				<span> QQ在线咨询</span>
			</a>
			<div class="im-tel">
				<div><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2629127460&site=qq&menu=yes">客服1号</a></div>
				<div><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2722738780&site=qq&menu=yes">客服2号</a></div>
				<div><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2692971153&site=qq&menu=yes">客服3号</a></div>
			</div>
			
		</div>
	</div>
	-->
	<!--QQ客服END-->
	
	<!--
	<script type="text/javascript">
		var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
		document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F525b5f892c298e8bc74be7c5c1788c7c' type='text/javascript'%3E%3C/script%3E"));
	</script> -->
	<!-- 后期加上 //-->
	<!--
	<script type="text/javascript">
		var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
		document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fcb333bd3bab2d5f0365f7a76f03ca915' type='text/javascript'%3E%3C/script%3E"));
	</script>
	-->
	
	<div class="container-2014">
		<div class="span24">
			[@ad_position id = 2 /]
		</div>
		<div class="span24">
			<ul class="bottomNav-2014">
				[@navigation_list position = "bottom"]
					[#list navigations as navigation]
						<li>
							<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
							[#if navigation_has_next]|[/#if]
						</li>
					[/#list]
				[/@navigation_list]
			</ul>
		</div>
	</div>
	<div class="container-2014">
		<div class="copyright-2014">
			${message("shop.footer.copyright", setting.siteName)}
		</div>
	</div>
	[#include "/fonter/include/statistics.ftl" /]
</body>
</html>