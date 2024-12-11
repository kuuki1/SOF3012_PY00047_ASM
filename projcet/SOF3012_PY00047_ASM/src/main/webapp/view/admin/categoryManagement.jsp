<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Categories Management</title>
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
		
        .category-form-container form {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }

        .category-form-container label {
            display: block;
            margin-bottom: 8px;
            font-size: 1.1rem;
            color: #495057;
        }

        .category-form-container input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            font-size: 1rem;
            background-color: #f1f3f5;
            transition: border-color 0.3s ease;
        }

        .category-form-container input:focus {
            border-color: #007bff;
            outline: none;
        }

        .category-form-container .btn-group {
            display: flex;
            gap: 15px;
            justify-content: space-between;
        }

        .category-form-container .btn-group button {
            padding: 12px 25px;
            font-size: 1rem;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 32%;
        }

        .btn-create {
            background-color: #0d6efd;
        }

        .btn-create:hover {
            background-color: #0056b3;
        }

        .btn-update {
            background-color: #28a745;
        }

        .btn-update:hover {
            background-color: #218838;
        }

        .btn-delete {
            background-color: #dc3545;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }

        .btn-reset {
            background-color: #ffc107;
        }

        .btn-reset:hover {
            background-color: #e0a800;
        }

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
    </style>
</head>
<body>
    <%@ include file="/common/header.jsp" %>

    <div class="container">
        <div id="menu">
            <button class="menu-button" onclick="navigateToVideoManagement()">Video Management</button>
            <button class="menu-button" onclick="navigateToUserManagement()">User Management</button>
            <button class="menu-button" onclick="navigeteToCategoryManagement()">Category Management</button>
            <button class="menu-button" onclick="navigeteToShareManagement()">Share Statistics</button>
            <button class="menu-button" onclick="navigeteToFavoriteStatistics()">Favorites Statistics</button>
            <button class="menu-button" onclick="navigeteToFavoriteUsers()">Favorites Users Statistics</button>
        </div>
        
        <br></br>
        <h2>Categories Management</h2>

        <div class="category-form-container">
            <form method="post">
                <h3>${category == null ? "Add New Category" : "Edit Category"}</h3>
                <input type="hidden" name="id" value="${category != null ? category.id : ''}">

                <label>Category Name:</label>
                <input type="text" name="name" value="${category != null ? category.name : ''}">

                <div class="btn-group">
                    <button type="submit" class="btn-create" formaction="${pageContext.request.contextPath}/category/management/create">Create</button>
                    <button type="submit" class="btn-update" formaction="${pageContext.request.contextPath}/category/management/update">Update</button>
                    <button type="submit" class="btn-delete" formaction="${pageContext.request.contextPath}/category/management/delete">Delete</button>
                    <button type="submit" class="btn-reset" formaction="${pageContext.request.contextPath}/category/management/reset">Reset</button>
                </div>
            </form>
        </div>

        <hr>

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
                        <td><a href="${pageContext.request.contextPath}/category/management/edit/${category.id}" class="btn-edit">Edit</a></td>
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
        function navigeteToFavoriteStatistics() {
        	window.location.href = '/SOF3012_PY00047_ASM/favorite/statistics';	
        }
        function navigeteToFavoriteUsers() {
        	window.location.href = '/SOF3012_PY00047_ASM/favorite/user/statistics?videoId=1';	
        }
    </script>
</body>
</html>
