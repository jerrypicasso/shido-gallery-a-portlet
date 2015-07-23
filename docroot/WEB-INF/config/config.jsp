<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="com.njshido.component.ShidoGalleryConfigurationAction" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>

<portlet:defineObjects />

<liferay-theme:defineObjects />

<%
	String imgWidth = String.valueOf(request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_IMG_WIDTH));	
	String imgHeight = String.valueOf(request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_IMG_HEIGHT));
	String spacing = String.valueOf(request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_SPACING));
	String background = String.valueOf(request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_BACKGROUND));
	String alignment = String.valueOf(request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_TITLE_ALIGNMENT));
	
	String[] isVideos = (String[]) request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_IS_VIDEO);
	String[] imgUrls = (String[]) request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_IMG_URL);
	String[] links = (String[]) request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_LINK);
	String[] titles = (String[]) request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_TITLE);
	String[] summaries = (String[]) request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_SUMMARY);
	String[] tags = (String[]) request.getAttribute(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_TAG);
%>
<liferay-ui:success key="success" message="your-configuration-was-saved-sucessfully"/>
<form action="<liferay-portlet:actionURL portletConfiguration='true' />" method="post">
	<input type="button" value="添加条目" onclick="addItem();"/>
	<div id="" style="background:#ddd;padding:20px 0px;opacity:0.8">
		<ul>
			<%-- <li>
				<span>画廊宽度(%)：</span>
				<input name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_WIDTH%>" type="number" style="width:30%;" value="<%=width%>"/>
			</li> --%>
			<li>
				<span>图片宽度：</span>
				<input name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_IMG_WIDTH%>" type="number" style="width:30%;"  value="<%=imgWidth%>"/>
			</li>
			<li>
				<span>图片高度：</span>
				<input name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_IMG_HEIGHT%>" type="number" style="width:30%;"  value="<%=imgHeight%>"/>
			</li>
			<li>
				<span>单元间隙：</span>
				<input name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_SPACING%>" type="number" style="width:30%;"  value="<%=spacing%>"/>
			</li>
			<li>
				<span>背景颜色：</span>
				<input name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_BACKGROUND%>" type="text" style="width:30%;"  value="<%=background%>"/>
			</li>
			<li>
				<span>标题对齐方式：</span>
				<select name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_TITLE_ALIGNMENT%>" style="width:30%;">
					<option value="left" <%= "left".equals(alignment) ? "selected":"" %>>居左</option>
					<option value="center" <%= "center".equals(alignment) ? "selected":"" %>>居中</option>
					<option value="right" <%= "right".equals(alignment) ? "selected":"" %>>居右</option>
				</select>
			</li>
		</ul>
	</div>
	
	<div id="<portlet:namespace />itemsConfigurationPanel" style="padding:20px 0px;">
<%
	for(int i = 0; i < imgUrls.length; i++) {
		String isVideo = null;
		if(i < isVideos.length && isVideos[i] != null) {
			isVideo = isVideos[i];
		}
%>
			<ul id="<portlet:namespace/>url_<%= i %>">
			   	<li>
			   		<span>图片地址：</span>
			   		<input type="text" style="width:50%;" value="<%= i < imgUrls.length && imgUrls[i] != null ? imgUrls[i] : StringPool.BLANK%>" 
			   			name="<portlet:namespace/><%= ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_IMG_URL %>"/>
			   	</li>
			   	<li>
			   		<span>标题：</span>
			   		<textarea name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_TITLE%>" 
			   			style="width:50%;"><%= i < titles.length && titles[i] != null ? titles[i] : StringPool.BLANK %></textarea>
			   	</li>
			   	<li>
			   		<span>简介：</span>
			   		<input type="text" style="width:50%;" value="<%= i < summaries.length && summaries[i] != null ? summaries[i] : StringPool.BLANK %>" 
			   			name="<portlet:namespace/><%= ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_SUMMARY %>"/>
			   	</li>
			   	<li>
			   		<span>标签(用逗号隔开)：</span>
			   		<input type="text" style="width:50%;" value="<%= i < tags.length && tags[i] != null ? tags[i] : StringPool.BLANK %>" 
			   			name="<portlet:namespace/><%= ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_TAG %>"/>
			   	</li>
			   	<li>
			   		<span>链接地址：</span>
			   		<input type="text" style="width:50%;" value="<%= i < links.length && links[i] != null ? links[i] : StringPool.BLANK %>" 
			   			name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_LINK%>" required="required"/>
			   	</li>
			   	<li>
			   		<span>视频模式：</span>
			   		<select name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_IS_VIDEO%>" style="width:30%;">
						<option value="true" <%="true".equals(isVideo) ? "selected":"" %> >是</option>
						<option value="false" <%=!"true".equals(isVideo) ? "selected":"" %> >否</option>
					</select>
			   	</li>
			   	<li>
			   		<input type="button" value="删除" onclick="removeItem('<portlet:namespace/>url_<%= i%>')"/>
			   	</li>
		   	</ul>
<%
	}
%>
	</div>
	<input type="submit" value="save"/>
</form>

<script type="text/javascript">
	function addItem() {
		var itemsConfigurationPanel = $('#<portlet:namespace />itemsConfigurationPanel');
		var id = new Date().getTime();
		var section = ['<ul id="'+ id +'">',
	   				   '<li>',
   					   '<span>图片地址：</span>',
   					   '<input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_IMG_URL%>"/>',
   					   '</li>',
   					   '<li>',
   					   '<span>标题：</span>',
   					   '<textarea style="width:50%;" name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_TITLE%>"></textarea>',
   					   '</li>',
   					   '<li>',
   					   '<span>简介：</span>',
   					   '<input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_SUMMARY%>"/>',
   					   '</li>',
   					   '<li>',
   					   '<span>标签(用逗号隔开)：</span>',
   					   '<input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_TAG%>"/>',
   					   '</li>',
   					   '<li>',
   					   '<span>链接地址：</span>',
   					   '<input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_LINK%>"/>',
   					   '</li>',
   					   '<li>',
					   '<span>视频模式：</span>',
					   '<select name="<portlet:namespace/><%=ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_IS_VIDEO%>" style="width:30%;">',
					   '<option value="true">是</option>',
					   '<option value="false" selected >否</option>',
					   '</select>',
					   '</li>',
   					   '<li>',
   			   		   '<input type="button" value="删除" onclick="removeItem('+ id +')"/>',
   			   		   '</li>',
					   '</ul>'];
		itemsConfigurationPanel.append(section.join(''));
	}
	
	function removeItem(id) {
		$('#' + id).remove();
	}
</script>