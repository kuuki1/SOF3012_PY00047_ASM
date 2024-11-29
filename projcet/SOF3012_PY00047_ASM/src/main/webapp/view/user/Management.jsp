<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Page</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/common/mana/video.css">
<script src="${pageContext.request.contextPath}/common/mana/main.js"></script>
<%@ include file="/common/account/head.jsp"%>
<%@ include file="/common/account/css.jsp"%>
</head>
<body>
    <%@ include file="/common/account/header.jsp"%>
    <br><br><br><br><br>
    <h2>Videos Management</h2>

    <div class="video-form-container">
        <form action="/video/management/update" method="post" enctype="multipart/form-data">
            <h3>${video == null ? "Your Video" : "Edit Video"}</h3>
            <input type="hidden" name="id" value="${video != null ? video.id : ''}">

            <label>Title:</label>
            <input type="text" name="title" value="${video != null ? video.title : ''}">

            <label>Video URL (YouTube/Vimeo):</label>
            <input type="text" name="videoUrl" value="${video != null ? video.videoUrl : ''}" placeholder="https://www.youtube.com/watch?v=example">

            <label>Poster URL:</label>
            <input type="file" name="poster" value="${video != null ? video.poster : ''}" placeholder="URL of poster image">

            <label>Description:</label>
            <textarea name="description" rows="4">${video != null ? video.description : ''}</textarea>

            <div class="btn-group">
					<button type="submit" class="btn-update"
						formaction="${pageContext.request.contextPath}/video/management/update">Update</button>
					<button type="submit" class="btn-delete"
						formaction="${pageContext.request.contextPath}/video/management/delete">Delete</button>
					<button type="submit" class="btn-reset"
					formaction="${pageContext.request.contextPath}/video/management/reset">Reset</button>
				</div>
        </form>
    </div>

    <hr>

    <h2>Uploaded Videos</h2>
    <table>
        <thead>
            <tr>
                <th>Poster</th>
                <th>Title</th>
                <th>Views</th>
                <th>Likes</th>
                <th>Shares</th>
                <th>Comments</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="video" items="${videoList}">
                <tr>
                    <td><img src="<c:url value='/${video.poster}'/>" alt="Poster" width="100"></td>
                    <td>${video.title}</td>
                    <td>${video.viewCount}</td>
                    <td>${video.likeCount}</td>
                    <td>${video.shareCount}</td>
                    <td>${video.commentCount}</td>
                    <td><a href="${pageContext.request.contextPath}/video/management/edit/${video.id}" class="btn-edit">Edit</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
	<%@ include file="/common/account/js.jsp"%>
</body>
</html>
