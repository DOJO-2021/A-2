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
<form method="POST" name = "subBut" action="/OpenQA/registServlet?mode=answer" enctype="multipart/form-data">
<table>
	<th>

		from. ${user.name}

		<input type="hidden" name="anonymity" value="0">
		<input type="checkbox" name="anonymity" value="1">匿名

	</th>

	<td>
	<p>回答<textarea name="content"></textarea></p>

	<canvas id="preview" style="max-width:200px;"></canvas><br>

	<label>
		<img src="images/insert.jpeg" alt="画像添付">
		<input type="file" accept="image/*" onchange="previewImage(this);">
	</label>

	<input type="submit" name="SUBMIT" value="回答投稿">
	</td>

</table>

</form>
</body>

<script>
	function previewImage(obj){

		var fileReader = new FileReader();

		// 読み込み後に実行する処理
		fileReader.onload = (function() {

			// canvas にプレビュー画像を表示
			var canvas = document.getElementById('preview');
			var ctx = canvas.getContext('2d');
			var image = new Image();
			image.src = fileReader.result;
			console.log(fileReader.result) // ← (確認用)

			image.onload = (function () {
				canvas.width = image.width;
				canvas.height = image.height;
				ctx.drawImage(image, 0, 0);
			});
		});
		// 画像読み込み
		fileReader.readAsDataURL(obj.files[0]);
		console.log(fileReader.result) // ← (確認用)null
	}
</script>

</html>