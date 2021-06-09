<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
</head>
<body>
<form method="POST" action="/OpenQA/RegistServlet" id="form">

		<p>
			ID<input type="text" name="ID" placeholder="ID">
		</p>
		<p>
			新しいPW<input type="text" name="pw" placeholder="新しいPW">
		</p>
		<p>
			確認用PW<input type="text" name="pw" placeholder="確認用PW">
		</p>
		<p>
			お名前<input type="text" name="name" placeholder="お名前">
		</p>
		<p>
			<input type="radio" name="student"  value="student" checked>受講生
			<input type="radio" name="teacher"  value="student" checked>講師
		</p>
		<p>
			講師用PW<input type="text" name="ins_pw" placeholder="講師用PW">
		</p>
		<input type="submit" name="regist" value="登録">
	</form>
</body>
</html>