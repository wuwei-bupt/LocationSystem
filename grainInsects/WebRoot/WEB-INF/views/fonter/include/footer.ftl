<div class="container">
	<div class="friendLink-2014">
		<dl>
			<dt>友情链接</dt>
			[@friend_link_list count = 10]
				[#list friendLinks as friendLink]
					<dd>
						<a href="${friendLink.url}" target="_blank">${friendLink.name}</a>
						[#if friendLink_has_next]|[/#if]
					</dd>
				[/#list]
			[/@friend_link_list]
			<!--  mark
			<dd class="more">
				<a href="${base}/friend_link.jhtml">${message("shop.index.more")}</a>
			</dd>
			-->
		</dl>
	</div>
</div>
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