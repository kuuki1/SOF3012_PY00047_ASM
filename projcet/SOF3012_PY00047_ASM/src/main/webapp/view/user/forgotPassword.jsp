<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<!DOCTYPE>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Catalog</title>
    <%@ include file="/common/head.jsp" %>
</head>

<body>
	<%@ include file="/common/header.jsp" %>
	<div class="mx-auto pb-3 tm-about-text-container px-3">
	    <div class="row">
	        <div class="col-lg-12 mb-12">
	        	<br><h2>Forgot Password</h2><br>
	            <form action="${pageContext.request.contextPath}/forgotPassword" method="post">
				    <div>
				        <label for="email">Email:</label>
				        <input type="email" id="email" name="email" required class="form-control rounded-0">
				    </div>
				    <button type="submit" class="btn btn-primary rounded-0 d-block ml-auto mr-0">Send</button>
				</form>   
	        </div>
	    </div>  
	</div>

<%@ include file="/common/footer.jsp" %>
</body>

</html>