<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	margin: 0;
	font-family: 'Roboto', sans-serif;
	background-color: #ffffff;
	color: #000;
}

/* Navbar */
.navbar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 10px 20px;
	background-color: #f8f9fa;
	border-bottom: 1px solid #ddd;
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1001; /* Đặt Navbar ở trên cùng */
}

.menu-btn {
	font-size: 24px;
	cursor: pointer;
	color: #000;
}

.navbar-logo {
	display: flex;
	align-items: center;
}

.navbar-logo img {
	height: 24px;
	margin-right: 10px;
}

.navbar-logo span {
	font-size: 18px;
	font-weight: 500;
	color: #000;
}

/* Sidebar */
.sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: 60px;
	height: 100%;
	background-color: #f0f0f0;
	overflow-y: auto;
	transition: width 0.3s;
	z-index: 999;
	border-right: 1px solid #ddd;
	padding-top: 60px; /* Đẩy nội dung xuống dưới Navbar */
	display: flex;
	flex-direction: column;
	align-items: center; /* Căn giữa theo chiều ngang */
}

.sidebar.expanded {
	width: 250px;
}

.sidebar .menu {
	list-style: none;
	padding: 0;
	margin: 0;
	width: 100%;
}

.sidebar .menu li {
	display: flex;
	align-items: center;
	justify-content: center; /* Căn giữa theo chiều ngang */
	padding: 15px 0;
	cursor: pointer;
	border-radius: 10px;
	transition: background 0.2s;
}

.sidebar .menu li:hover {
	background-color: #e0e0e0;
}

.sidebar .menu li i {
	font-size: 24px;
	color: #000;
}

.sidebar .menu li span {
	display: none;
	font-size: 16px;
	color: #000;
	margin-left: 10px;
}

.sidebar.expanded .menu li {
	justify-content: flex-start; /* Căn trái khi Sidebar mở rộng */
	padding-left: 20px;
}

.sidebar.expanded .menu li span {
	display: inline-block;
}

/* Nội dung chính */
#mainContent {
	transition: margin-left 0.3s;
	margin-top: 60px;
	margin-left: 60px;
	padding: 20px;
}

#mainContent.shifted {
	margin-left: 250px;
}
</style>
</head>
<body>

</body>
</html>