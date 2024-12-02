<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Page</title>
<%--     <link rel="stylesheet" href="${pageContext.request.contextPath}/common/mana/style.css"> --%>
    <script src="${pageContext.request.contextPath}/common/mana/main.js"></script>
    <%@ include file="/common/account/head.jsp"%>
    <%@ include file="/common/account/css.jsp"%>
    <style>
        .container {
            margin-top: 80px;
            text-align: center;
        }
        
        .hidetext { 
       	 	-webkit-text-security: disc;
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

        /* Nội dung của mỗi tab */
        .tab-content {
            display: none;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #f8f9fa;
        }

        .tab-content.active {
            display: block;
        }

        /* Form container */
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
        input[type="password"],
        input[type="email"],
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

        /* Table styling */
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

        /* Message styling */
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
        <h2>Users Management</h2>
        <form method="post">
        	<input type="hidden" name="id" value="${user != null ? user.id : ''}">
        	
		    <label>Username:</label> 
		    <input type="text" name="username" value="${user != null ? user.username : ''}"> 
		    
		    <label>Full Name:</label> 
		    <input type="text" name="fullname" value="${user != null ? user.fullname : ''}"> 
		    
		    <label>Password:</label> 
		    <input type="password" name="password" value="${user != null ? user.password : ''}"> 
		    
		    <label>Email:</label> 
		    <input type="email" name="email" value="${user != null ? user.email : ''}"> 
		    
		    <label>Role:</label>
		    <select name="isAdmin">
		        <option value="true" ${user != null && user.isAdmin ? 'selected' : ''}>Admin</option>
		        <option value="false" ${user != null && !user.isAdmin ? 'selected' : ''}>User</option>
		    </select>
		
		    <div class="btn-group">
		    	<button type="submit" class="btn-create" formaction="${pageContext.request.contextPath}/user/management/create">Create</button>
		        <button type="submit" class="btn-update" formaction="${pageContext.request.contextPath}/user/management/update">Update</button>
		        <button type="submit" class="btn-delete" formaction="${pageContext.request.contextPath}/user/management/delete">Delete</button>
		        <button type="submit" class="btn-reset" formaction="${pageContext.request.contextPath}/user/management/reset">Reset</button>
		    </div>
		</form>

    </div>

    <div class="message">
        <p>${message}</p>
    </div>

    <h2>User List</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Password</th>
                <th>Email</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${userList}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td>${user.fullname}</td>
                    <td class="hidetext">${user.password}</td>
                    <td>${user.email}</td>
                    <td>${user.isAdmin ? 'Admin' : 'User'}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/user/management/edit/${user.id}">Edit</a>
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
