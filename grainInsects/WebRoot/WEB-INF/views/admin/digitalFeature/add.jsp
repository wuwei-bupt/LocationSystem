<%@ page contentType="text/html;charset=utf-8"%>
<div class="easyui-panel">
	<form method="post" id="dfForm">
			<table class="input tabContent" id= "featureTable<%= request.getParameter("index") %>">
				<tr style="text-align:center;">  
                <td colspan="3">  
                        <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem(<%= request.getParameter("index") %>)" id="btnSave">保存</a>  
                        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem(<%= request.getParameter("index") %>)">取消</a>    
                </td>  
            	</tr>
				<tr><th> 特征名称：</th><td colspan="3"><input type="text" name="name" maxlength="100" style="width: 400px;"></td></tr>
				<tr><th> 特征值：</th>
					<td>
						<textarea id="featureeditor<%= request.getParameter("index") %>" name="value" type="text"></textarea>
					</td>
				</tr>
				<tr><th><span class="requiredField">*</span> 识别顺序（数字）：</th><td colspan="3"><input name="indentifyindex" type="digits" ></td></tr>
				<tr><th> 说明：</th>
					<td>
						<textarea id="noteeditor<%= request.getParameter("index") %>" name="note"  ></textarea>
					</td>
				</tr>
				<tr><th> 资料来源：</th><td colspan="3"><input type="text" name="source" maxlength="100" style="width: 400px;" ></textarea></td></tr>
		</table>
	</form>
</div>