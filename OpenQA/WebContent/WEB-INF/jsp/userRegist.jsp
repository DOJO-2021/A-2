<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
</head>
<body>
<form method="POST" action="/OpenQA/registServlet?mode=userRegist" id="form">

		<p>
			ID<input type="text" name="ID" id="id" placeholder="ID">
		</p>

		<p>
			新しいPW<input type="text" name="pw" id="pw" placeholder="新しいPW">
		</p>
		<p>
			確認用PW<input type="text" name="pw" id="pw2" placeholder="確認用PW">
		</p>
		<p>
			お名前<input type="text" name="name" placeholder="お名前">
		</p>
		<p>
			<input type="radio" name="type"  value="0" checked>受講生
			<input type="radio" name="type"  value="1" checked>講師
		</p>
		<p>
			講師用PW<input type="text" name="ins_pw" id="ins_pw" placeholder="講師用PW">
		</p>
		<input type="submit" name="SUBMIT" value="登録">
	</form>
</body>
<script>
function ceckForm() {
	var id = document.getElementById("id");
	var pw = document.getElementById("pw");
	var ins_pw = document.getElementById("ins_pw");

	if(id.value == ???) {
		window.alert("そのIDは使われています。");
	}

	if(pw.value != pw2.value) {
		window.alert("確認用PWが一致しません。");
	}

	if(ins_pw != "HiguchiIsGod") {
		window.alert("講師用PWが違います。")
	}
}
</script>
</html>