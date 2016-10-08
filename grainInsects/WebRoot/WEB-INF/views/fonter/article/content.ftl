<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>[#if article.seoTitle??]${article.seoTitle}[#elseif seo.title??][@seo.title?interpret /][/#if][#if systemShowPowered][/#if]</title>
[#if article.seoKeywords??]
	<meta name="keywords" content="${article.seoKeywords}" />
[#elseif seo.keywords??]
	<meta name="keywords" content="[@seo.keywords?interpret /]" />
[/#if]
[#if article.seoDescription??]
	<meta name="description" content="${article.seoDescription}" />
[#elseif seo.description??]
	<meta name="description" content="[@seo.description?interpret /]" />
[/#if]
<link href="${base}/resources/shop/css/common2014.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/article.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $hits = $("#hits");

	var $articleSearchForm = $("#articleSearchForm");
	var $keyword = $("#articleSearchForm input");
	var $articleForm = $("#articleForm");
	var $pageNumber = $("#pageNumber");
	var defaultKeyword = "${message("shop.article.keyword")}";
	
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

	$articleSearchForm.submit(function() {
		if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
			return false;
		}
	});
	
	$articleForm.submit(function() {
		if ($pageNumber.val() == "" || $pageNumber.val() == "1") {
			$pageNumber.prop("disabled", true)
		}
	});
	
	$.pageSkip = function(pageNumber) {
		$pageNumber.val(pageNumber);
		$articleForm.submit();
		return false;
	}
	// 查看点击数
	$.ajax({
		url: "${base}/article/hits/${article.id}.jhtml",
		type: "GET",
		success: function(data) {
			$hits.text(data);
		}
	});

});
</script>
</head>
<body>
	[#assign articleCategory = article.articleCategory /]
	[#include "/fonter/include/header.ftl" /]
	
	<!--页面左侧的文章分类列表-->
	<div class="container articleContent">
		<div class="span6">
			<div class="hotArticleCategory">
				<div class="title">${message("shop.article.articleCategory")}</div>
				[@article_category_root_list count = 10]
					[#list articleCategories as category]
						<dl[#if !category_has_next] class="last"[/#if]>
							<dt>
								<a href="${base}${category.path}">${category.name}</a>
							</dt>
							[#list category.children as articleCategory]
								[#if articleCategory_index == 6]
									[#break /]
								[/#if]
								<dd>
									<a href="${base}${articleCategory.path}">${articleCategory.name}</a>
								</dd>
							[/#list]
						</dl>
					[/#list]
				[/@article_category_root_list]
			</div>
			<div class="hotArticle">
				<div class="title">${message("shop.article.hotArticle")}</div>
				<ul>
					[@article_list articleCategoryId = articleCategory.id count = 10 orderBy="hits desc"]
						[#list articles as article]
							<li>
								<a href="${base}${article.path}" title="${article.title}">${abbreviate(article.title, 30)}</a>
							</li>
						[/#list]
					[/@article_list]
				</ul>
			</div>
			<div class="articleSearch">
				<div class="title">${message("shop.article.search")}</div>
				<div class="content">
					<form id="articleSearchForm" action="${base}/article/search.jhtml" method="get">
						<input type="text" name="keyword" value="${message("shop.article.keyword")}" maxlength="30" />
						<button type="submit">${message("shop.article.searchSubmit")}</button>
					</form>
				</div>
			</div>
		</div>
		
		<!--页面右侧的文章内容-->
		<div class="span18 last">
			
			<!--分类路径-->
			<div class="path">
				<ul>
					<li>
						<a href="${base}/">${message("shop.path.home")}</a>
					</li>
					[@article_category_parent_list articleCategoryId = articleCategory.id]
						[#list articleCategories as articleCategory]
							<li>
								<a href="${base}${articleCategory.path}">${articleCategory.name}</a>
							</li>
						[/#list]
					[/@article_category_parent_list]
					<li>
						<a href="${base}${articleCategory.path}">${articleCategory.name}</a>
					</li>
				</ul>
			</div>
			
			<!--文章内容-->
			<div class="main">
				<h1 class="title">${article.title}[#if article.pageNumber > 1] (${article.pageNumber})[/#if]</h1>
				<div class="info">
					${message("shop.article.createDate")}: ${article.createDate?string("yyyy-MM-dd HH:mm:ss")}
					${message("shop.article.author")}: ${article.author}
					${message("shop.article.hits")}: <span id="hits">&nbsp;</span>
				</div>
				<div class="content">${article.content}</div>
			</div>
			[@pagination pageNumber = article.pageNumber totalPages = article.totalPages pattern = "{pageNumber}.html"]
				[#include "/fonter/include/pagination.ftl"]
			[/@pagination]
		</div>
	</div>
	[#include "/fonter/include/footer.ftl" /]
</body>
</html>