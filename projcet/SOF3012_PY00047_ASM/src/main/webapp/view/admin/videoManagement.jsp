<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Page</title>
<%@ include file="/common/head.jsp" %>
<style>
body {
    font-family: 'Roboto', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
    color: #495057;
}

.container {
    max-width: 1200px;
    margin: 40px auto;
    padding: 20px;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.header label {
    font-size: 1.2rem;
    font-weight: bold;
    color: #333;
}

.header select {
    padding: 10px 15px;
    font-size: 1rem;
    width: 70%;
    border: 1px solid #ced4da;
    border-radius: 5px;
    background-color: #fff;
    transition: border-color 0.3s;
}

.header select:focus {
    border-color: #007bff;
    outline: none;
}

.btn-search {
    padding: 12px 20px;
    font-size: 1rem;
    color: #fff;
    background-color: #007bff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn-search:hover {
    background-color: #0056b3;
}

/* Form styles */
.video-form-container form {
    background-color: #ffffff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    margin-top: 30px;
}

.video-form-container label {
    display: block;
    margin-bottom: 8px;
    font-size: 1.1rem;
    color: #495057;
}

.video-form-container input,
.video-form-container textarea {
    width: 100%;
    padding: 12px;
    margin-bottom: 20px;
    border: 1px solid #ced4da;
    border-radius: 8px;
    font-size: 1rem;
    background-color: #f1f3f5;
    transition: border-color 0.3s ease;
}

.video-form-container input:focus,
.video-form-container textarea:focus {
    border-color: #007bff;
    outline: none;
}

.video-form-container .btn-group {
    display: flex;
    gap: 15px;
    justify-content: space-between;
}

.video-form-container .btn-group button {
    padding: 12px 25px;
    font-size: 1rem;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    width: 32%;
}

.video-form-container .btn-update {
    background-color: #28a745;
}

.video-form-container .btn-update:hover {
    background-color: #218838;
}

.video-form-container .btn-delete {
    background-color: #dc3545;
}

.video-form-container .btn-delete:hover {
    background-color: #c82333;
}

.video-form-container .btn-reset {
    background-color: #6c757d;
}

.video-form-container .btn-reset:hover {
    background-color: #5a6268;
}

/* Table styles */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

table th, table td {
    padding: 18px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

table th {
    background-color: #007bff;
    color: white;
    text-transform: uppercase;
    font-size: 1rem;
}

table tr:nth-child(even) {
    background-color: #f9f9f9;
}

table tr:hover {
    background-color: #eef3fa;
    transition: background-color 0.3s;
}

.menu {
    margin-bottom: 20px;
}

.menu-button {
    padding: 12px 25px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
    margin-right: 10px;
    font-size: 1rem;
}

.menu-button:hover {
    background-color: #0056b3;
}

/* Responsive design */
@media (max-width: 768px) {
    .header {
        flex-direction: column;
        align-items: flex-start;
    }

    .header select,
    .btn-search {
        width: 100%;
        margin-top: 10px;
    }

    .menu-button {
        width: 100%;
        margin-bottom: 10px;
    }
}
</style>



</head>
<body>
    <%@ include file="/common/header.jsp" %>

    <div class="container">
        <div id="menu">
            <button class="menu-button" onclick="navigateToVideoManagement()">Video Management</button>
            <button class="menu-button" onclick="navigateToUserManagement()">User Management</button>
            <button class="menu-button" onclick="navigeteToCategoryManagement()">Category Management</button>
            <button class="menu-button" onclick="navigeteToShareManagement()">Share Management</button>
        </div>
    

    <h2>Videos Management</h2>

    <div class="video-form-container">
        <form action="/video/management/update" method="post" enctype="multipart/form-data">
            <h3>${video == null ? "Add New Video" : "Edit Video"}</h3>
            <input type="hidden" name="id" value="${video != null ? video.id : ''}">

            <label>Title:</label>
            <input type="text" name="title" value="${video != null ? video.title : ''}">

            <label>Video URL (YouTube/Vimeo):</label>
            <input type="text" name="videoUrl" value="${video != null ? video.videoUrl : ''}" placeholder="https://www.youtube.com/watch?v=example" readonly>

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
    </div>
    <%@ include file="/common/footer.jsp"%>
    <script>
        function navigateToUserManagement() {
            window.location.href = '/SOF3012_PY00047_ASM/user/management';
        }
        function navigateToVideoManagement() {
            window.location.href = '/SOF3012_PY00047_ASM/video/management';
        }
        function navigeteToCategoryManagement() {
        	window.location.href = '/SOF3012_PY00047_ASM/category/management';	
        }
        function navigeteToShareManagement() {
        	window.location.href = '/SOF3012_PY00047_ASM/share/management';	
        }
    </script>
</body>
</html>
