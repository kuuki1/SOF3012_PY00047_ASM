<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Video</title>
	<style>
		/* Định dạng chung cho form */
.form-group {
    margin-bottom: 15px;
}

label {
    font-weight: bold;
}

input[type="text"],
input[type="url"],
input[type="file"],
textarea,
select {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
    border-radius: 4px;
    border: 1px solid #ccc;
}

button[type="submit"] {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button[type="submit"]:hover {
    background-color: #45a049;
}
		
	</style>
    <%@ include file="/common/account/head.jsp"%>
    <%@ include file="/common/account/css.jsp"%>
</head>
<body>
    <%@ include file="/common/account/header.jsp"%>

    <div id="mainContent">
        <section class="main-banner">
            <div class="container-fluid">
                <h2>Create New Video</h2>
                <form action="/SOF3012_PY00047_ASM/video/management/create" method="post" enctype="multipart/form-data" >
                    <!-- Video Title -->
                    <div class="form-group">
                        <label for="title">Title:</label>
                        <input type="text" id="title" name="title" class="form-control" placeholder="Enter video title" required>
                    </div>

                    <!-- Video URL -->
                    <div class="form-group">
                        <label for="videoUrl">Video URL (YouTube):</label>
                        <input type="url" id="videoUrl" name="videoUrl" class="form-control" placeholder="Enter video URL" required>
                    </div>

                    <!-- Poster Image -->
                    <div class="form-group">
                        <label for="poster">Poster Image:</label>
                        <input type="file" id="poster" name="poster" class="form-control">
                    </div>

                    <!-- Category -->
                    <div class="form-group">
                        <label>Category:</label>
			            <select name="categoryId">
			                <c:forEach var="category" items="${categoryList}">
			                    <option value="${category.id}" ${video != null && category.id == video.category ? 'selected' : ''}>
								    ${category.name}
								</option>
			                </c:forEach>
			            </select>
                    </div>

                    <!-- Video Description -->
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <textarea id="description" name="description" class="form-control" rows="5" placeholder="Enter video description" required></textarea>
                    </div>

                    <!-- Submit Button -->
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">Create Video</button>
                    </div>
                </form>
            </div>
        </section>
    </div>

    <%@ include file="/common/account/js.jsp"%>
</body>
</html>
