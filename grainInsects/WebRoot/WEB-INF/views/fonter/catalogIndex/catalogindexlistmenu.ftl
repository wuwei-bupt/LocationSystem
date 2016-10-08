
	<div class="container productList productContent">
		<!--左侧虫种类别 和 热门虫种-->
		<div class="span6">
			<div class="hotProductCategory">
				[@insect_category_root_list]
					[#list insectCategories as category]
						<dl[#if !category_has_next] class="last"[/#if]>
							<dt>
								<a href="${base}${category.path}">${category.mc}</a>
							</dt>
							[@insect_category_children_list insectCategoryId = category.id count = 4]
								[#list insectCategories as insectCategory]
									<dd>
										<a href="${base}${insectCategory.path}">${insectCategory.mc}</a>
									</dd>
								[/#list]
							[/@insect_category_children_list]
						</dl>
					[/#list]
				[/@insect_category_root_list]
			</div>
			<div class="hotProduct">
				<div class="title">热门害虫</div>
				<ul>
					[#if insectCategory??]
						[@insect_category_children_list insectCategoryId = insectCategory.id count = 10 orderBy="monthHits desc"]
							[#list insectCategories as category]
								<li[#if !category_has_next] class="last"[/#if]>
									<a href="${base}${category.path}" title="${category.mc}">${abbreviate(category.mc, 30)}</a>
								</li>
							[/#list]
						[/@insect_category_children_list]
					[#else]
						[@insect_category_children_list count = 10 orderBy="monthHits desc"]
							[#list insectCategories as category]
								<li[#if !category_has_next] class="last"[/#if]>
									<a href="${base}${category.path}" title="${category.mc}">${abbreviate(category.mc, 30)}</a>
			
								</li>
							[/#list]
						[/@insect_category_children_list]
					[/#if]
				</ul>
			</div>
		</div>