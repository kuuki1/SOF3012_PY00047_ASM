<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Page</title>
    <%@ include file="/common/account/head.jsp"%>
    <%@ include file="/common/account/css.jsp"%>
    <style>
        .container {
            margin-top: 80px;
            text-align: center;
        }

        #menu {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 20px;
        }

        .menu-button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .menu-button:hover {
            background-color: #0056b3;
        }

        .form-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        select {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            padding: 12px 20px;
            margin: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            opacity: 0.9;
        }

        button.btn-create {
            background-color: #28a745;
            color: white;
        }

        button.btn-update {
            background-color: #007bff;
            color: white;
        }

        button.btn-delete {
            background-color: #dc3545;
            color: white;
        }

        button.btn-reset {
            background-color: #ffc107;
            color: white;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        table th {
            background-color: #007bff;
            color: white;
            padding: 12px;
            text-align: left;
        }

        table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        table td a {
            color: #007bff;
            text-decoration: none;
        }

        table td a:hover {
            text-decoration: underline;
        }

        .message {
            margin-top: 20px;
            text-align: center;
            font-size: 16px;
            color: #28a745;
        }
    </style>
</head>
<body>
    <%@ include file="/common/account/header.jsp"%>
    <div class="container">
        <div id="menu">
            <button class="menu-button" onclick="navigateToVideoManagement()">Video Management</button>
            <button class="menu-button" onclick="navigateToUserManagement()">User Management</button>
            <button class="menu-button" onclick="navigeteToCategoryManagement()">Category Management</button>
            <button class="menu-button" onclick="navigeteToShareManagement()">Share Management</button>
        </div>
    </div>
    <div class="form-container">
        <h2>Categories Management</h2>
        <form method="post">
        	<input type="hidden" name="id" value="${category != null ? category.id : ''}">
        	
            <label>Name:</label>
            <input type="text" name="name" value="${category != null ? category.name : ''}">
            
            <div class="btn-group">
                <button type="submit" class="btn-create" formaction="${pageContext.request.contextPath}/category/management/create">Create</button>
                <button type="submit" class="btn-update" formaction="${pageContext.request.contextPath}/category/management/update">Update</button>
                <button type="submit" class="btn-delete" formaction="${pageContext.request.contextPath}/category/management/delete">Delete</button>
                <button type="submit" class="btn-reset" formaction="${pageContext.request.contextPath}/category/management/reset">Reset</button>
            </div>
        </form>
    </div>
    <div class="message">
        <p>${message}</p>
    </div>
    <h2>Category List</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="category" items="${categories}">
                <tr>
                    <td>${category.id}</td>
                    <td>${category.name}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/category/management/edit/${category.id}">Edit</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
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
