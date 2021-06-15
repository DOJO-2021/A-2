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
<h2>質問登録</h2>
<form method="POST" name = "subBut" action="/OpenQA/registServlet?mode=question"  enctype="multipart/form-data">
<table>
<tr>
	<th>
		<!-- 回答者を指定する -->
		<select name="to">
			<option value="">回答者を選択</option>
			<option value="0">だれでも</option>
			<option value="1">講師</option>
			<option value="2">受講者</option>
		</select>

		from. ${user.name}

		<input type="hidden" name="anonymity" value="0">
		<input type="checkbox" name="anonymity" value="1">匿名

		<!-- ひとつめのセレクトボックス -->
		<!-- web開発コースは保留  -->
		<select name="b_category" id="b_category" onchange="category()">
			<option value="">カテゴリー</option>
			<option  value="パーソナルスキル">パーソナルスキル</option>
			<option  value="IT基礎">IT基礎コース</option>
			<option  value="java基礎">java基礎コース</option>
			<option  value="その他">その他</option>
		</select>

		<!-- 二つ目のセレクトボックス（連動する） -->
		<select name="s_category">
		</select>
	</th>
</tr>
<tr>
	<td>
	<p>タイトル <input type="text" name="title"></p>
	<p>内容<textarea name="content"></textarea></p>
	<canvas id="preview" style="max-width:200px;"></canvas><br>

	<label>
		<img src="images/insert.jpeg" alt="画像添付">
		<input type="file" name="IMAGE" accept="image/*" onchange="previewImage(this);">
	</label>

	<input type="submit" name="SUBMIT" value="質問投稿">
	</td>
</tr>
</table>

</form>
</body>
<script>
'use strict'

	function previewImage(obj){

		var fileReader = new FileReader();

		// 読み込み後に実行する処理
		fileReader.onload = (function() {

			// canvas にプレビュー画像を表示
			var canvas = document.getElementById('preview');
			var ctx = canvas.getContext('2d');
			var image = new Image();
			image.src = fileReader.result;
			console.log(fileReader.result)

			image.onload = (function () {
				canvas.width = image.width;
				canvas.height = image.height;
				ctx.drawImage(image, 0, 0);
			});
		});
		// 画像読み込み
		fileReader.readAsDataURL(obj.files[0]);
		console.log(fileReader.result);
	}

	// 未入力アラート
	document.getElementById('form').onsumbit = function(event) {
		const title = document.getElementById('form').title.value;
		const content = docuent.getElementById('form').content.value;
		if(title === "" || content === "") {
			window.alert("タイトルおよび内容を入力してください");
		}
	}

	// 投稿した後のアラート
	document.getElementById('form').onsumbit = function(event) {
		const title = document.getElementById('form').title.value;
		const content = docuent.getElementById('form').content.value;
		if(title != "" || content != "") {
		 	if( confirm("投稿してもよろしいですか。") ) {
	        	window.alert("投稿しました。");
	        	// windowを閉じる処理
	   		}
	    	else {
	        	alert("移動をやめました。");
	    	}
	}
</script>

</html>