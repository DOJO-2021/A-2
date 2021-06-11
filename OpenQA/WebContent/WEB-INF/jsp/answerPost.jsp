<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
<script type="text/javascript" src="/OpenQA/js/common.js"></script>
</head>
<body>
<h2>回答登録</h2>
<form method="POST" name = "subBut" action="/OpenQA/registServlet?mode=answer" ">
<table>
	<th>

		from. ${user.name}

		<input type="hidden" name="anonymity" value="0">
		<input type="checkbox" name="anonymity" value="1">匿名

	</th>

	<td>
	<p>回答<textarea name="content"></textarea></p>

	<label>
		<img src="images/insert.jpeg" alt="画像添付">
		<input type="file" accept="image/*">
	</label>

	<input type="submit" name="SUBMIT" value="回答投稿">
	</td>

</table>

</form>
</body>
</html>