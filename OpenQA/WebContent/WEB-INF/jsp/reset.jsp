<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
<link rel="stylesheet" href="/OpenQA/css/common.css">
</head>
<body>


			<h1>
				<img src="/OpenQA/images/mainLogo.png" class="sitelogo"  width="80" height="80">

			Open Q&amp;A System</h1>
			<hr>

<form method="POST" action="/OpenQA/RegistServlet?mode=reset" id="form">
		<p>
			ID<input type="text" name="ID" id="id" placeholder="ID">
		</p>
		<p>
			お名前<input type="text" name="name" placeholder="お名前">
		</p>
		<p>
			新しいPW<input type="text" name="pw" id="pw" placeholder="PW">

		</p>
		<p>
			確認用PW<input type="text" name="pw2" placeholder="確認用PW">
		</p>

		<input type="submit" name="reset" value="再設定" onsubmit="return checkForm();">
	</form>
</body>
<script>
	function checkForm(){
			if(document.form.pw1.value != document.form.pw2.value && result == false){
				window.alert("確認用PWが一致しません。IDとお名前が一致しません。");
				return false;
			}else{
				if(document.form.pw1.value != document.form.pw2.value){
		    		window.alert("確認用PWが一致しません。");
					return false;
				} else{
					if(result == false) {
						window.alert("IDとお名前が一致しません。");
						return false;
					} else{
						if(confirm('PWを再設定をしてもよろしいですか？')) {
						return true;
						}
				}
		}
	}
</script>
</html>