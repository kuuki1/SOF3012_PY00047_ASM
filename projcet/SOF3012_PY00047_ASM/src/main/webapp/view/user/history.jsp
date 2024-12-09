<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Page</title>
<%@ include file="/common/head.jsp" %>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        color: #FFFFFF;
        margin: 0;
        padding: 0;
    }

    .container {
        margin-top: 50px;
        padding: 20px;
    }

    .tm-catalog-item-list {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        justify-content: center;
    }

	.a{
		margin-left: 20px;
	}

    .tm-catalog-item {
        display: flex;
        background-color: #202020;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .tm-catalog-item:hover {
        transform: scale(1.05);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.5);
    }

    .tm-thumbnail-container {
        position: relative;
        flex: 0 0 40%;
        overflow: hidden;
    }

    .tm-catalog-item-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .tm-img-overlay {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 48px;
        color: white;
        opacity: 0;
        transition: opacity 0.3s;
    }

    .tm-thumbnail-container:hover .tm-img-overlay {
        opacity: 1;
    }

    .tm-catalog-item-description {
        padding: 10px 15px;
        flex: 1;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .tm-text-primary {
        font-size: 16px;
        font-weight: bold;
        margin: 0 0 10px;
        color: #FFF;
    }

    .tm-text-gray {
        font-size: 14px;
        color: #AAA;
    }

    .tm-text-gray span {
        display: inline-block;
        margin-right: 10px;
    }

    .tm-text-gray-light {
        color: #777;
    }
</style>

</head>
<body>
	<%@ include file="/common/header.jsp" %>
	<div class="container">
	    <ul class="list-group list-group-flush">
	        <c:forEach items="${videos}" var="video">
	            <li class="list-group-item bg-dark text-light d-flex align-items-start">
	                <div class="tm-thumbnail-container" style="width: 160px;">
	                    <img src="<c:url value='/${video.poster}'/>" alt="${video.title}" class="img-fluid" style="width: 100%; height: auto;">
	                    <a href="<c:url value='/video?action=watch&id=${video.videoUrl}'/>" 
	                       class="tm-img-overlay"
	                       style="z-index: 2;">
	                        <i class="fas fa-play-circle"></i>
	                    </a>
	                </div>
	                <div class = "a">
	                    <h3 class="tm-text-primary mb-4">${video.title}</h3>
		                    <p>${video.description}</p>
		                    <p class="mb-1 tm-text-gray">
	                        <span class="tm-tex-gray-light">${video.shareCount} Share</span> • 
	                        <span>${video.viewCount} Views</span>
	                    </p>
	                </div>
	            </li>
	        </c:forEach>
	    </ul>
	</div>
	<%@ include file="/common/footer.jsp"%>
</body>
</html>