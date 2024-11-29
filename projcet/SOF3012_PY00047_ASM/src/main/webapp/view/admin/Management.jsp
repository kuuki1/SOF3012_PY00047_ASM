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
