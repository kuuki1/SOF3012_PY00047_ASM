<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Catalog</title>
    <%@ include file="/common/head.jsp" %>
    <style>
        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
        }

        .video-player {
            width: 100%;
            height: 500px;
        }

        .video-description {
            margin-top: 20px;
        }

        .comments-section {
            margin-top: 40px;
        }

        .comments-list {
            margin-top: 20px;
        }

        .comment {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            font-weight: bold;
        }

        .comment-username {
            color: #007bff;
        }

        .comment-content {
            margin-top: 10px;
        }

        .comment-form {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f1f1f1;
        }

        .comment-form textarea {
            width: 100%;
            resize: vertical;
        }

        .comment-form button {
            margin-top: 10px;
            width: 150px;
        }

        .like-button {
            margin-top: 20px;
        }
    </style>
</head>

<body>
    <%@ include file="/common/header.jsp" %>
    <main>
        <div class="container">
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
			    </div>
			    <br>
            </div>

			<c:if test="${not empty video.videoUrl}">
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
			</c:if>
			
			<c:if test="${not empty video.videoUrl}">
			    <button id="shareButton" class="btn btn-success" onclick="toggleShareForm()">Share</button>
			</c:if>
			
			<div id="shareForm" style="display: none; margin-top: 20px;">
			    <form action="${pageContext.request.contextPath}/share" method="post">
			        <input type="hidden" name="videoHref" value="${video.videoUrl}" />
			        <div class="mb-3">
			            <label for="email" class="form-label">Recipient Email</label>
			            <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required />
			        </div>
			        <button type="submit" class="btn btn-primary">Send</button>
			    </form>
			</div>

            <div class="comments-section">
                <h4>Comments</h4>
                <div class="comments-list">
                    <c:forEach var="comment" items="${comments}">
                        <div class="comment">
                            <div class="comment-header">
                                <span class="comment-username">${comment.user.username}</span>
                                <small class="text-muted">${comment.commentDate}</small>
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
	                    // Cập nhật nút với "Unlike" và số lượng like
	                    $("#likeButton").text("Unlike " + response.likeCount + "").removeClass("btn-primary").addClass("btn-danger");
	                } else {
	                    // Cập nhật nút với "Like" và số lượng like
	                    $("#likeButton").text("Like " + response.likeCount + "").removeClass("btn-danger").addClass("btn-primary");
	                }
	                // Cập nhật số lượng like bên ngoài nút
	                $("#likeCount").text(response.likeCount);
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
