<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<body>
	<script
	src="<c:url value='/templates/user/account/vendor/jquery/jquery.min.js'/>"></script>

<!-- JavaScript cho Sidebar -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const sidebar = document.getElementById('sidebar');
        const menuBtn = document.querySelector('.menu-btn');
        const mainContent = document.getElementById('mainContent');

        // Xử lý khi nhấn nút Toggle
        menuBtn.addEventListener('click', () => {
            sidebar.classList.toggle('expanded');
            mainContent.classList.toggle('shifted');
        });
    });
</script>
</body>