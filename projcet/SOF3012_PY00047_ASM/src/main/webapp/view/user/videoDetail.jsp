<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Catalog</title>
    <%@ include file="/common/head.jsp" %>
    <style>
        :root {
            --primary-color: #1a73e8;
            --secondary-color: #34a853;
            --background-color: #f4f4f8;
            --text-color: #2c3e50;
            --card-background: #ffffff;
            --border-radius: 12px;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1400px;
            margin: auto;
            padding: 20px;
        }

        .video-content-wrapper {
            display: flex;
            gap: 20px;
        }

        .main-video-section {
            flex: 2;
        }

        .related-videos-section {
            flex: 1;
            max-height: 800px;
            overflow-y: auto;
        }

        .video-player {
            width: 100%;
            height: 500px;
            border-radius: var(--border-radius);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .video-player:hover {
            transform: scale(1.01);
        }

        .video-description {
            background-color: var(--card-background);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .video-description h2 {
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        .List-video .list-group-item {
            background-color: var(--card-background) !important;
            border-radius: var(--border-radius);
            margin-bottom: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
        }

        .List-video .list-group-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }

        .List-video .tm-thumbnail-container {
            width: 160px;
            margin-right: 15px;
            position: relative;
            overflow: hidden;
            border-radius: var(--border-radius);
        }

        .List-video .tm-img-overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(26, 115, 232, 0.8);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .List-video .tm-thumbnail-container:hover .tm-img-overlay {
            opacity: 1;
        }

        .List-video .tm-img-overlay i {
            color: white;
            font-size: 20px;
        }

        .comments-section {
            background-color: var(--card-background);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .comment {
            background-color: var(--background-color);
            border: none;
            border-radius: var(--border-radius);
            padding: 15px;
            margin-bottom: 15px;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .comment-username {
            color: var(--primary-color);
            font-weight: 600;
        }

        .comment-form {
            background-color: var(--background-color);
            border: none;
            border-radius: var(--border-radius);
            padding: 20px;
        }

        .comment-form textarea {
            border-radius: 8px;
            border: 1px solid #e0e0e0;
        }

        #likeButton, #shareButton {
            border-radius: 25px;
            transition: all 0.3s ease;
            margin-right: 10px;
        }

        #likeButton:hover, #shareButton:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .share-buttons {
            display: flex;
            align-items: center;
            margin-top: 15px;
        }

        @media (max-width: 992px) {
            .video-content-wrapper {
                flex-direction: column;
            }

            .main-video-section, 
            .related-videos-section {
                flex: none;
                width: 100%;
            }

            .related-videos-section {
                max-height: none;
                margin-top: 20px;
            }

            .List-video .list-group-item {
                flex-direction: column;
                text-align: center;
            }

            .List-video .tm-thumbnail-container {
                width: 100%;
                margin-right: 0;
                margin-bottom: 15px;
            }
        }
    </style>
</head>

<body>
    <%@ include file="/common/header.jsp" %>
    <main>
        <div class="container">
            <div class="video-content-wrapper">
                <div class="main-video-section">
                    <div class="video-player mb-4">
                        <iframe class="video-player" src="https://www.youtube.com/embed/${video.videoUrl}"
                                frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
                                allowfullscreen id="content">
                        </iframe>
                    </div>

                    <div class="video-description">
                        <h2>${video.title}</h2>
                        <p>${video.description}</p>
                        <div class="d-flex justify-content-between">
                            <span><strong>Views:</strong> ${video.viewCount}</span>
                            <span><strong>Comments:</strong> ${video.commentCount}</span>
                            <c:choose>
								<c:when test="${not empty sessionScope.currentUser}">
									
								</c:when>
								<c:otherwise>
									<span><strong>Like:</strong> ${video.likeCount}</span>
								</c:otherwise>
							</c:choose>
                            
                        </div>
                        <br>

                        <div class="share-buttons">
                            <c:if test="${not empty sessionScope.currentUser}">
                                <button id="likeButton" class="btn ${flagLikeBtn ? 'btn-danger' : 'btn-primary'}"
                                        onclick="toggleLike('${video.videoUrl}')">
                                    <c:choose>
                                        <c:when test="${flagLikeBtn}">
                                            Unlike ${video.likeCount}
                                        </c:when>
                                        <c:otherwise>
                                            Like ${video.likeCount}
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                            
                                <button id="shareButton" class="btn btn-success" onclick="toggleShareForm()">Share</button>
                            </c:if>
                        </div>
                        
                        <div id="shareForm" style="display: none; margin-top: 20px;">
                            <form action="${pageContext.request.contextPath}/share" method="post">
                                <input type="hidden" name="videoHref" value="${video.videoUrl}" />
                                <div class="mb-3">
                                    <label for="email" class="form-label">Recipient Email</label>
                                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required />
                                </div>
                                <button type="submit" class="btn btn-primary">Send</button>
                            </form>
                            <br>
                            <c:if test="${not empty errorMessage}">
								<div style="color: red; text-align: center; margin-bottom: 20px;">
									${errorMessage}</div>
							</c:if>
                        </div>
                    </div>

                    <div class="comments-section">
                        <h4>Comments</h4>
                        <div class="comments-list">
                            <c:forEach var="comment" items="${comments}">
                                <div class="comment">
                                    <div class="comment-header">
                                        <span class="comment-username">${comment.user.username}</span>
                                        <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd" />
                                    </div>
                                    <div class="comment-content">
                                        <p>${comment.content}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <c:if test="${not empty sessionScope.currentUser}">
                            <div class="comment-form">
                                <h5>Add a Comment</h5>
                                <form action="${pageContext.request.contextPath}/comment" method="post">
                                    <input type="hidden" name="videoHref" value="${video.videoUrl}" />
                                    <textarea class="form-control mb-3" name="content" rows="3" placeholder="Write your comment here..."></textarea>
                                    <button type="submit" class="btn btn-primary btn-sm" style="width: auto; padding: 10px 20px; font-size: 16px;">Post Comment</button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="related-videos-section">
                    <div class="List-video">
                        <ul class="list-group list-group-flush">
                            <c:forEach items="${videos}" var="video">
                                <li class="list-group-item">
                                    <div class="tm-thumbnail-container">
                                        <img src="<c:url value='/${video.poster}'/>" alt="${video.title}" class="img-fluid">
                                        <a href="<c:url value='/video?action=watch&id=${video.videoUrl}'/>" 
                                           class="tm-img-overlay">
                                            <i class="fas fa-play-circle"></i>
                                        </a>
                                    </div>
                                    <div>
                                        <h3 class="tm-text-primary mb-2">${video.title}</h3>
                                        <p class="mb-1 tm-text-gray">
                                            <span class="tm-tex-gray-light">${video.shareCount} Share</span> • 
                                            <span>${video.viewCount} Views</span>
                                        </p>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="/common/footer.jsp" %>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function toggleLike(videoHref) {
            const contextPath = '<%= request.getContextPath() %>';
            $.ajax({
                type: "GET",
                url: contextPath + "/video?action=like&id=" + videoHref,
                dataType: "json",
                success: function(response) {
                    if (response.liked) {
                        $("#likeButton").text("Unlike " + response.likeCount + "").removeClass("btn-primary").addClass("btn-danger");
                    } else {
                        $("#likeButton").text("Like " + response.likeCount + "").removeClass("btn-danger").addClass("btn-primary");
                    }
                },
                error: function(xhr, status, error) {
                    alert("Có lỗi xảy ra: " + xhr.responseText);
                }
            });
        }

        function toggleShareForm() {
            const shareForm = document.getElementById('shareForm');
            if (shareForm.style.display === 'none' || shareForm.style.display === '') {
                shareForm.style.display = 'block';
            } else {
                shareForm.style.display = 'none';
            }
        }
    </script>
</body>
</html>