<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Share Management</title>
<%@ include file="/common/account/head.jsp"%>
<%@ include file="/common/account/css.jsp"%>
<style>
/* General styles */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f4f4f9;
    margin: 0;
    padding: 0;
    color: #333;
}

.container {
    max-width: 90%;
    margin: 40px auto;
    margin-top: 80px;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

/* Header section */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.header label {
    font-size: 1.2rem;
    font-weight: bold;
    color: #333;
}

.header select {
    padding: 8px 12px;
    font-size: 1rem;
    width: 60%;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #fff;
    transition: border-color 0.3s;
}

.header select:focus {
    border-color: #007bff;
    outline: none;
}

.btn-search {
    padding: 10px 20px;
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
}

table th, table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

table th {
    background-color: #007bff;
    color: white;
    text-transform: uppercase;
}

table tr:nth-child(even) {
    background-color: #f9f9f9;
}

table tr:hover {
    background-color: #eef3fa;
    transition: background-color 0.3s;
}

/* Responsive design */
@media (max-width: 768px) {
    .header {
        flex-direction: column;
        align-items: flex-start;
    }

    .header select, .btn-search {
        width: 100%;
        margin-top: 10px;
    }
}
</style>
</head>
<body>
<%@ include file="/common/account/header.jsp"%>

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

<%@ include file="/common/account/js.jsp"%>
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
