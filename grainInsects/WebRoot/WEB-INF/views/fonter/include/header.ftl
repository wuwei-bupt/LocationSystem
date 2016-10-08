<link href="${base}/resources/shop/popwin/css/popwin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/popwin/js/popwin.js"></script>

<script type="text/javascript">
$().ready(function() {

	var $headerLogin = $("#headerLogin");
	var $headerRegister = $("#headerRegister");
	var $headerUsername = $("#headerUsername");
	var $headerLogout = $("#headerLogout");
	var $productSearchForm = $("#productSearchForm");
	var $keyword = $("#productSearchForm input");
	var defaultKeyword = "${message("shop.header.keyword")}";
	
	var username = getCookie("username");
	if (username != null) {
		$headerUsername.text("${message("shop.header.welcome")}, " + username).show();
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
	
	$productSearchForm.submit(function() {
		if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
			return false;
		}
	});
});
</script>

<div class="head_top container">
	<ul class="fl">
		<li><a href="#" onclick="javascript:addFavorite('${base}','绿色储粮综合信息平台');">收藏本站</a></li>	
	</ul>	
	<ul class="fr">
		<li class="fore1" id="headerWelcome" style="display: list-item;">
		       您好，欢迎来到绿色储粮综合信息平台！
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
<div class="container">
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
<div class="container header">
	<div class="span24">
		<ul class="mainNav">
			[@navigation_list position = "middle"]
				[#list navigations as navigation]
					<li[#if navigation.url = url] class="current"[/#if]>
						<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
						[#if navigation_has_next]|[/#if]
					</li>
				[/#list]
			[/@navigation_list]
		</ul>
	</div>
	<div class="span24">
		<div class="tagWrap">
			<ul class="tag">
				[@tag_list type="insect" count = 6]
					[#list tags as tag]
						<li[#if tag.icon??] class="icon" style="background: url(${tag.icon}) right no-repeat;"[/#if]>
							<a href="${base}/catalogIndex/list.jhtml?tagIds=${tag.id}">${tag.name}</a>
						</li>
					[/#list]
				[/@tag_list]
			</ul>

		</div>
	</div>
</div>