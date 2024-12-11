<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Favorite statistics</title>
<%@ include file="/common/head.jsp" %>
<style>
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
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    padding: 12px;
    text-align: left;
    border: 1px solid #ddd;
}

th {
    background-color: #007bff;
    color: white;
    font-weight: bold;
}

tr:nth-child(even) {
    background-color: #f2f2f2;
}

tr:hover {
    background-color: #e1e1e1;
}

select {
    padding: 8px 15px;
    font-size: 16px;
    border-radius: 5px;
    border: 1px solid #ccc;
    margin-top: 10px;
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
    
			<table border="1">
			    <tr>
			        <th>Video Title</th>
			        <th>Favorite Count</th>
			        <th>Oldest Date</th>
			        <th>Latest Date</th>
			    </tr>
			    <c:forEach var="stat" items="${stats}">
			        <tr>
			            <td>${stat.title}</td>
			            <td>${stat.favoriteCount}</td>
			            <td><fmt:formatDate value="${stat.oldestDate}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate value="${stat.latestDate}" pattern="yyyy-MM-dd" /></td>
			        </tr>
			    </c:forEach>
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
