<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
</head>
<body>
	<img src="images/mainLogo.png" alt="">

	<form method="POST" action="/OpenQA/LoginServlet" id="form">
		<p>
		    <!-- IDとPWは外に表記？それともプレイスホルダーのみ？ -->
			<input type="text" name="ID" placeholder="ID">
		</p>
		<p>
			<input type="password" name="PW" placeholder="PW">
		</p>
		${errMsg}<!-- 「※IDかPWが間違えています。」のエラーをここで出す。 -->
		<p>
			<input type="submit" name="LOGIN" value="ログイン">
		</p>
	</form>

	<a href="/OpenQA/RegistServlet?mode=userRegist">新規会員登録はこちら</a>
	<br>
	<a href="/OpenQA/UpdateDeleteServlet">PW再設定はこちら</a>

</body>
</html>