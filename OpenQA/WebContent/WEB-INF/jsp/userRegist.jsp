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
<form method="POST" action="/OpenQA/RegistServlet" id="form">

		<div>
			ID<input type="text" name="ID" id="id" placeholder="ID">
			<div class="tooltip">半角英数字で入力してください。</div>
			<p></p>
		</div>
		<div>
			PW<input type="text" name="pw" id="pw" placeholder="PW">
			<div class="tooltip">半角英字と数字を組み合わせた６桁以上で入力してください。</div>
			<p></p>
		</div>
		<div>
			確認用PW<input type="text" name="pw" id="pw2" placeholder="確認用PW">
			<p></p>
		</div>
		<div>
			お名前<input type="text" name="name" placeholder="お名前">
			<p></p>
			</div>
		<div>
			<input type="radio" name="type"  value="0" checked>受講生
			<input type="radio" name="type"  value="1" checked>講師
			<p></p>
		</div>
		<div>
			講師用PW<input type="text" name="ins_pw" id="ins_pw" placeholder="講師用PW">
			<p></p>
		</div>
		<input type="submit" name="SUBMIT" value="登録" onclick="return checkForm();">
	</form>
</body>
<script>
function checkForm() {
	var id = document.getElementById('id');
	var pw = document.getElementById('pw');
	var ins_pw = document.getElementById('ins_pw');
	var type = document.getElementsByName('type');

	if(id.value == "") {
		window.alert("IDを入力してください。");
		return false;
	}
	if(name.value == "") {
		window.alert("名前を入力してください。");
		return false;
	}

	if(pw.value != pw2.value) {
		window.alert("確認用PWが一致しません。");
		return false;
	}

	if(type == 1 && ins_pw != "HiguchiIsGod") {
		window.alert("講師用PWが違います。");
		return false;
	}
}

let elms = document.querySelectorAll('form input[type=text],form textarea');
for (let i = 0; i < elms.length; i++) {
	elms[i].onfocus = function () {
		let = tooltip = this.parentNode.querySelector('.tooltip');
		tooltip.style.display = 'inline-block';
	};
	elms[i].onblur = function () {
		let = tooltip = this.parentNode.querySelector('.tooltip');
		tooltip.style.display = 'none';
	}
}
</script>

<style>
form.div {
	position:relative;
}
.tooltip:before {
	content: '';
	position:absolute;
	top:10px;
	left:-20px;
	border:12px solid transparent;
	border-right:12px solid #60EEEE;
}
.tooltip {
	position:absolute;
	background-color:#60EEEE;
	color:white;
	font-size:0.8em;
	border-radius:0.5em;
	padding:10px;
	margin:-0.8em 0.5em 0 1em;
	display:none;
}
input[type="text"],textarea {
	width:10em;
}
</style>
</html>