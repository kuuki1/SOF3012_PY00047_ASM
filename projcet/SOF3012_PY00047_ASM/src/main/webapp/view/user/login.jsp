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
        <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .login-container h2 {
            margin-bottom: 20px;
            font-weight: bold;
            text-align: center;
        }
        .btn-google {
            background-color: #db4437;
            color: #fff;
        }
        .btn-google:hover {
            background-color: #c23321;
        }
        .form-group input {
            padding: 10px;
            font-size: 16px;
        }
        .form-group button {
            padding: 10px;
            font-size: 16px;
        }
        .forgot-password {
            text-align: right;
            font-size: 14px;
        }
        .login-options {
            text-align: center;
            margin-top: 20px;
        }
        .login-options p {
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
	<%@ include file="/common/header.jsp" %>
	<div class="login-container">
        <h2>Sign In</h2>
        <form id="contact-form" action="login" method="POST" class="tm-contact-form">
            <div class="form-group">
                <input type="text" name="Username" class="form-control rounded-0" placeholder="Username" required />
            </div>
            <div class="form-group">
                <input type="password" name="Password" class="form-control rounded-0" placeholder="Password" required />
            </div>
            <div class="form-group forgot-password">
                <a href="${pageContext.request.contextPath}/forgotPassword">Forgot Password?</a>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-block rounded-0"><span>Login</span></button>
            </div>
        </form>
        <div class="login-options">
            <p>Or login with</p>
            <a href="${pageContext.request.contextPath}/google-login" class="btn btn-google btn-block rounded-0">
                <i class="fa fa-google"></i> Login with Google
            </a>
        </div>
    </div>

<%@ include file="/common/footer.jsp" %>
</body>

</html>