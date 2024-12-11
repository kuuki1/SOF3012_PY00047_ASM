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
	        	<br><h2>Sign up</h2><br>
	            <form id="contact-form" action="register" method="POST" class="tm-contact-form">
	              <div class="form-group">
	                <input type="text" name="Username" class="form-control rounded-0" placeholder="Username" required="" />
	              </div>
	              <div class="form-group">
	                <input type="text" name="Fullname" class="form-control rounded-0" placeholder="Fullname" required="" />
	              </div>
	              <div class="form-group">
	                <input type="password" name="Password" class="form-control rounded-0" placeholder="Password" required="" />
	              </div>
	              <div class="form-group">
	                <input type="password" name="cfmPass" class="form-control rounded-0" placeholder="Confirm Password" required="" />
	              </div>
	              <div class="form-group">
	                <input type="email" name="Email" class="form-control rounded-0" placeholder="Email" required="" />
	              </div>
	
	              <div class="form-group mb-0">
	                <button type="submit" class="btn btn-primary rounded-0 d-block ml-auto mr-0"><span>Send</span></button>
	              </div> 
	            </form>    
	        </div>
	    </div>  
	</div>
	
	<c:if test="${not empty errorMessage}">
		<div style="color: red; text-align: center; margin-bottom: 20px;">
			${errorMessage}</div>
	</c:if>
<%@ include file="/common/footer.jsp" %>
</body>

</html>