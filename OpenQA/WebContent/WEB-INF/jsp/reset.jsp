<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
</head>
<body>
	<form method="POST" action="/OpenQA/UpdateDeleteServlet" id="form">

		<p>
			ID<input type="text" name="ID" placeholder="ID">
		</p>
		<p>
			お名前<input type="text" name="name" placeholder="お名前">
		</p>
		<p>
			新しいPW<input type="text" name="pw" placeholder="新しいPW">
		</p>
		<p>
			確認用PW<input type="text" name="pw" placeholder="確認用PW">
		</p>

		<input type="submit" name="reset" value="再設定">
	</form>
</body>
</html>