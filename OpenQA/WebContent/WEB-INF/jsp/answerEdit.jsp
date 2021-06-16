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
<input type=hidden name="a_id" value=${answer.a_id}><!-- 保留 -->
<table>
	<th>

		from. ${user.name}

		<input type="hidden" name="anonymity" value="0">
		<input type="checkbox" name="anonymity" value="1" <c:if test = "${question.anonymity == 1}"> checked </c:if>>匿名

	</th>

	<td>
	<p>回答<textarea name="content">${answer.answer}</textarea></p>

	<c:if test = "${answer.images != null}">
		<img src="/OpenQA/images/${answer.images}" alt = "ccc" id="p1">
	</c:if>
	<input type="hidden" value="${answer.images}" id="preImage">

	<canvas id="preview" style="max-width:200px;"></canvas><br>

	<input type="button" id="btn1" value="画像削除" onclick="cls();">
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

	function cls(){
		var image = document.getElementById('preImage');
		image.value = "";
		var canvas = document.getElementById('preview');
		var ctx = canvas.getContext('2d');
		//キャンバスの(0,0)～(200,200)の範囲をクリアする
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		 var obj = document.getElementById("image");
		 obj.value = "";
	}

	// 未入力アラート
	function checkForm(){
    	if(document.subBut.content.value == ""){
        	window.alert("内容を入力してください");
			return false;
    	}else{
    		if(confirm('再投稿してもよろしいですか？')) {
    			alert("再投稿しました");
    			// windowを閉じる処理
    			window.close();
    			return true;
    		}
    		else{
    			alert("キャンセルしました");
    			return false;
    		}
   		}
	}
</script>

</html>