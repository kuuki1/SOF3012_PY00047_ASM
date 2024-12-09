<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Share Management</title>
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
    <!-- Header Section -->
    <div id="menu">
        <button class="menu-button" onclick="navigateToVideoManagement()">Video Management</button>
        <button class="menu-button" onclick="navigateToUserManagement()">User Management</button>
        <button class="menu-button" onclick="navigeteToCategoryManagement()">Category Management</button>
        <button class="menu-button" onclick="navigeteToShareManagement()">Share Management</button>
    </div>
    <div class="header">
        <form action="${pageContext.request.contextPath}/share/management" method="POST">
            <label for="videoTitle">Select Video Title:</label>
            <select name="videoId" required>
                <c:forEach var="video" items="${videoList}">
                    <option value="${video.id}">${video.title}</option>
                </c:forEach>
            </select>
            <button type="submit" class="btn-search">Search</button>
        </form>
    </div>

    <!-- Table Section -->
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>User</th>
                <th>Video URL</th>
                <th>Share Date</th>
                <th>Share Email</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="share" items="${shareList}">
                <tr>
                    <td>${share.id}</td>
                    <td>${share.user.username}</td> <!-- Display user name -->
                    <td>${share.video.videoUrl}</td> <!-- Link to video -->
                    <td>
		                <fmt:formatDate value="${share.shareDate}" pattern="yyyy-MM-dd" />
		            </td>
                    <td>${share.shareEmail}</td>
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
