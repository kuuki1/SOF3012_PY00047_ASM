<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Users Management</title>
<%@ include file="/common/head.jsp"%>
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

.video-form-container input, .video-form-container select {
	width: 100%;
	padding: 12px;
	margin-bottom: 20px;
	border: 1px solid #ced4da;
	border-radius: 8px;
	font-size: 1rem;
	background-color: #f1f3f5;
	transition: border-color 0.3s ease;
}

.video-form-container input:focus, .video-form-container select:focus {
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

.video-form-container .btn-create {
	background-color: #0d6efd;
}

.video-form-container .btn-create:hover {
	background-color: #0056b3;
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
	background-color: #ffc107;
}

.video-form-container .btn-reset:hover {
	background-color: #e0a800;
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

table .hidetext {
	-webkit-text-security: disc;
}

@media ( max-width : 768px) {
	.video-form-container .btn-group {
		flex-direction: column;
	}
	.video-form-container .btn-group button {
		width: 100%;
	}
}
</style>
</head>
<body>
	<%@ include file="/common/header.jsp"%>

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
		<h2>Users Management</h2>

		<div class="video-form-container">
			<form method="post">
				<h3>${user == null ? "Add New User" : "Edit User"}</h3>
				<input type="hidden" name="id"
					value="${user != null ? user.id : ''}" readonly> <label>Username:</label>
				<input type="text" name="username"
					value="${user != null ? user.username : ''}" readonly> <label>Full
					Name:</label> <input type="text" name="fullname"
					value="${user != null ? user.fullname : ''}"> 
				<input type="hidden" name="password"
					value="${user != null ? user.password : ''}"> <label>Email:</label>
				<input type="email" name="email"
					value="${user != null ? user.email : ''}"> <label>Role:</label>
				<select name="isAdmin">
					<option value="true"
						${user != null && user.isAdmin ? 'selected' : ''}>Admin</option>
					<option value="false"
						${user != null && !user.isAdmin ? 'selected' : ''}>User</option>
				</select>

				<div class="btn-group">
					<button type="submit" class="btn-update"
						formaction="${pageContext.request.contextPath}/user/management/update">Update</button>
					<button type="submit" class="btn-delete"
						formaction="${pageContext.request.contextPath}/user/management/delete">Delete</button>
					<button type="submit" class="btn-reset"
						formaction="${pageContext.request.contextPath}/user/management/reset">Reset</button>
				</div>
			</form>
		</div>
		<br>
		<c:if test="${not empty errorMessage}">
			<div style="color: red; text-align: center; margin-bottom: 20px;">
				${errorMessage}</div>
		</c:if>
		<br>
		<hr>

		<h2>User List</h2>
		<table>
			<thead>
				<tr>
					<th>Username</th>
					<th>Full Name</th>
					<th>Email</th>
					<th>Role</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${userList}">
					<tr>
						<td>${user.username}</td>
						<td>${user.fullname}</td>
						<td>${user.email}</td>
						<td>${user.isAdmin ? 'Admin' : 'User'}</td>
						<td><a
							href="${pageContext.request.contextPath}/user/management/edit/${user.id}"
							class="btn-edit">Edit</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
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
	<%@ include file="/common/footer.jsp"%>
</body>
</html>
