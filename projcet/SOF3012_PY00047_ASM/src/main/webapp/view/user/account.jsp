<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Page</title>
    
    <%@ include file="/common/account/head.jsp"%>
    <%@ include file="/common/account/css.jsp"%>
    <style>
/* Global Styles */
body {
    background-color: #f9f9f9; /* Màu nền sáng nhẹ */
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    color: #333;
}

/* Main Container */
#mainContent {
    max-width: 900px;
    margin: 50px auto;
    background-color: #ffffff; /* Màu nền trắng */
    color: #333;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

/* Cover Photo */
.cover-photo {
    width: 100%;
    height: 200px;
    background-image: url("<c:url value='/templates/user/img/anh.png'/>");
    background-size: cover;
    background-position: center;
    border-radius: 12px 12px 0 0;
    margin-bottom: 20px;
}

/* Profile Info Section */
.profile-info {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 20px;
}

/* Profile Picture */
.profile-picture {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    border: 4px solid #fff;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.profile-picture img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* Profile Details */
.profile-details {
    flex: 1;
    min-width: 200px;
}

.profile-details h1 {
    font-size: 22px;
    font-weight: bold;
    color: #1e1e1e;
    margin: 0;
}

.profile-details p {
    margin: 8px 0;
    color: #777;
    font-size: 14px;
}

/* Change Password Button */
.change-password button {
    background-color: #0066cc;
    color: white;
    border: none;
    padding: 12px 16px;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.change-password button:hover {
    background-color: #005bb5;
}

/* Share Form */
#shareForm {
    display: none;
    margin-top: 20px;
    background-color: #f9f9f9;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

#shareForm .form-label {
    font-size: 14px;
    color: #555;
    margin-bottom: 6px;
    display: block;
}

#shareForm .form-control {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 6px;
    margin-bottom: 15px;
}

#shareForm .form-control:focus {
    border-color: #0066cc;
    outline: none;
}

#shareForm .btn-primary {
    background-color: #0066cc;
    color: white;
    border: none;
    padding: 10px 16px;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#shareForm .btn-primary:hover {
    background-color: #005bb5;
}

/* Responsive Styles */
@media (max-width: 768px) {
    .profile-info {
        flex-direction: column;
        align-items: center;
        text-align: center;
    }

    .profile-picture {
        margin-bottom: 15px;
    }

    .profile-details {
        margin: 0;
    }

    .change-password {
        width: 100%;
        text-align: center;
    }

    #shareForm {
        padding: 15px;
    }
}
    </style>
</head>
<body>
    <%@ include file="/common/account/header.jsp"%>
    
    <!-- Main Content -->
    <div id="mainContent">
        <!-- Cover Photo -->
        <div class="cover-photo"></div>

        <!-- Profile Info -->
        <div class="profile-info">
            <!-- Profile Picture -->
            <div class="profile-picture">
                <img src="<c:url value='/templates/user/img/WIN_20241110_22_33_24_Pro.jpg'/>" alt="Profile Picture">
            </div>
            
            <!-- Profile Details -->
            <div class="profile-details">
                <h1>${user.fullname}</h1> <!-- Hiển thị fullname -->
                <p>${user.username}</p>   <!-- Hiển thị username -->
                <p>Email: ${user.email}</p> <!-- Hiển thị email -->
            </div>

            <!-- Change Password Button -->
            <div class="change-password">
                <button id="shareButton" onclick="toggleShareForm()">Đổi mật khẩu</button>
            </div>
            
            <div id="shareForm" style="display: none; margin-top: 20px;">
			    <form action="${pageContext.request.contextPath}/account" method="post">
			        <input type="hidden" name="videoHref" value="${video.videoUrl}" />
			        <div class="mb-3">
			            <label for="email" class="form-label">password</label>
			            <input type="password" class="form-control" id="pass" name="pass" placeholder="Password" required />
			            
			            <label for="email" class="form-label">New password</label>
			            <input type="password" class="form-control" id="newPass" name="newPass" placeholder="New password" required />
			            
			            <label for="email" class="form-label">Repeat new password</label>
			            <input type="password" class="form-control" id="RNPass" name="RNPass" placeholder="Repeat new password" required />
			        </div>
			        <button type="submit" class="btn btn-primary">Update</button>
			    </form>
			</div>
            <c:if test="${not empty successMessage}">
	            <div style="color: green; text-align: center; margin-bottom: 20px;">
	                ${successMessage}
	            </div>
	        </c:if>
	
	        <c:if test="${not empty errorMessage}">
	            <div style="color: red; text-align: center; margin-bottom: 20px;">
	                ${errorMessage}
	            </div>
	        </c:if>
        </div>
    </div>
    
    <%@ include file="/common/account/js.jsp"%>
    <script>
	    function toggleShareForm() {
	        const shareForm = document.getElementById('shareForm');
	        if (shareForm.style.display === 'none' || shareForm.style.display === '') {
	            shareForm.style.display = 'block';
	        } else {
	            shareForm.style.display = 'none';
	        }
	    }
    </script>
</body>
</html>
