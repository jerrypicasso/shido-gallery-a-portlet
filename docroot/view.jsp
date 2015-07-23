<%@ page pageEncoding="utf-8"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="javax.portlet.PortletPreferences"%>
<%@page import="com.njshido.component.ShidoGalleryConfigurationAction" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<portlet:defineObjects />

<%
	PortletPreferences preferences = renderRequest.getPreferences();
	String imgWidth = preferences.getValue(ShidoGalleryConfigurationAction.SHIDO_GALLERY_IMG_WIDTH, StringPool.BLANK);
	String imgHeight = preferences.getValue(ShidoGalleryConfigurationAction.SHIDO_GALLERY_IMG_HEIGHT, StringPool.BLANK);
	float spacing = Float.parseFloat(preferences.getValue(ShidoGalleryConfigurationAction.SHIDO_GALLERY_SPACING, 
			ShidoGalleryConfigurationAction.SHIDO_GALLERY_SPACING_DEFAULT_VAL));
	String background = preferences.getValue(ShidoGalleryConfigurationAction.SHIDO_GALLERY_BACKGROUND, 
			ShidoGalleryConfigurationAction.SHIDO_GALLERY_BACKGROUND_DEFAULT_VAL);
	String alignment = preferences.getValue(ShidoGalleryConfigurationAction.SHIDO_GALLERY_TITLE_ALIGNMENT, 
			ShidoGalleryConfigurationAction.SHIDO_GALLERY_TITLE_ALIGNMENT_DEFAULT_VAL);
	
	String[] imgUrls = preferences.getValues(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_IMG_URL, StringPool.EMPTY_ARRAY);
	String[] links = preferences.getValues(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_LINK, StringPool.EMPTY_ARRAY);
	String[] titles = preferences.getValues(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_TITLE, StringPool.EMPTY_ARRAY);
	String[] summaries = preferences.getValues(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_SUMMARY, StringPool.EMPTY_ARRAY);
	String[] tags = preferences.getValues(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_TAG, StringPool.EMPTY_ARRAY);
	String[] isVideos = preferences.getValues(ShidoGalleryConfigurationAction.SHIDO_GALLERY_CELL_IS_VIDEO, StringPool.EMPTY_ARRAY);
%>
<div id="<portlet:namespace/>shido-gallery-a" class="shido-gallery-a" style="background-color:<%= background %>">
	<table>
		<tr>
<%
	for(int i = 0; i < imgUrls.length; i++) {
%>
			<td style="padding:0 <%= spacing/2%>px;">
				<div style="width:<%=imgWidth%>px;
							height:<%=imgHeight%>px;
							background-image:url(<%= imgUrls[i]%>);
							background-repeat:no-repeat;
							background-position:center center;
							">
					<div class="mask
<%
		String isVideo = "false";
		if(i < isVideos.length && "true".equals(isVideos[i])) {
			isVideo = "true";
%>
					video-btn
<%
		}
%>
					"
					style="width:<%=imgWidth%>px;
						height:<%=imgHeight%>px;"
<%
		if(i < links.length && links[i] != null && links[i].length() > 0) {
%>
					onclick="display('<%= links[i]%>',<%= isVideo%>)"
<%
		}
%>
				>
					</div>
				</div>
<%
		if(i < titles.length && titles[i] != null && titles[i].length() > 0) {
%>
				<span class="img-title" style="width:<%= imgWidth %>px;text-align:<%= alignment %>"><%= titles[i].replaceAll("\\n", "<br/>")%></span>
<%
		}
		if(i < summaries.length && summaries[i] != null && summaries[i].length() > 0) {
%>
				<span class="img-summary" style="width:<%= imgWidth %>px;"><%= summaries[i] %></span>
<%
		}
%>
			</td>
<%
 	}
%>
		</tr>
		<tr>
<%
	for(int i = 0; i < imgUrls.length; i++) {
%>
			<td style="padding:0 <%= spacing/2 %>px;">
<%
		if(i < tags.length && tags[i] != null && tags[i].length() > 0) {
%>
				<span class="img-tags" onclick="playVideo();" style="width:<%=imgWidth%>px;"><%= tags[i]%></span>
<%
		}
%>				
			</td>
<%
 	}
%>			
		</tr>
	</table>
</div>
<script type="text/javascript">
	
	function display(url,isVideo) {
		if(isVideo) {
			var sUserAgent = navigator.userAgent.toLowerCase();
	        var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
	        var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
	        var bIsMidp = sUserAgent.match(/midp/i) == "midp";
	        var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
	        var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
	        var bIsAndroid = sUserAgent.match(/android/i) == "android";
	        var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
	        var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
	        if (bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM) {
	            window.location.href = url;
	            //"http://beetle.de/static/videos/beetle_cabrio_product_video.mp4"
	            //"http://192.168.1.102:8080/documents/10184/0/test+video/aaba090d-4b63-43fa-acbe-700654a9d756"
	        } else {
	        	$.layer({
	        		type: 1,
	        		title: false,
	        		area: ['800px','600px'],
	        		border: [0],
	        		shade: [0.7, '#000'],
	        		page: {html: '<video preload="auto" autoplay="true" width="800" height="600" controls="controls" src="'+ url +'"></video>'}
	        	});
	        }
		} else {
			window.open(url, '_blank');
		}
    }
</script>
