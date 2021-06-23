<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
<style>
.close{display:none}
</style>
<script type="text/javascript" src="/OpenQA/js/common.js"></script>
</head>
<body>
<h2>回答編集</h2>
<form method="POST" name = "subBut" action="/OpenQA/UpdateDeleteServlet" enctype="multipart/form-data">
	<input type="hidden" name="a_id" value="${param.a_id}">
	<input type="hidden" name="q_id" value="${param.q_id}">
	<input type="hidden" name="mode" value="aa">
<table>
  <tr>
	<th>

		from. ${user.name}

		<input type="checkbox" name="anonymity" value="1"  id="anonymity" <c:if test = "${param.anonymity == 1}"> checked </c:if>>匿名

	</th>

	<td>
	<p>回答<textarea name="content">${param.content}</textarea></p>

		<img src="/OpenQA/images/${param.images}" alt = "" id="p1">

	<input type="hidden" name="preImage" value="${param.images}" id="preImage">

	<canvas id="preview" style="max-width:200px;"></canvas><br>

	<input type="button" id="btn1" value="画像削除" onclick="cls();">
	<label>
		<img src="images/insert.jpeg" alt="画像添付">
		<input type="file" name="IMAGE" accept="image/*" onchange="previewImage(this);">
	</label>


	<input type="hidden" name="solution" value="0">
	<input type="hidden" name="meToo" value="0">
	<input type="hidden" name="so" value="0">
	<input type="hidden" name="meto" value="0">

	<input type="submit" name="SUBMIT" value="回答編集">
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

			document.getElementById("p1").style.display ="none";

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
		document.getElementById("p1").style.display ="none";
		//キャンバスの(0,0)～(200,200)の範囲をクリアする
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		 var obj = document.getElementById("image");
		 obj.value = "";
	}

	// 未入力アラート
	function checkForm(){
		var ch = document.getElementById('anonymity');
		if (ch.checked) {
			ch.value = "1";
		} else {
			ch.value = "0";
		}
    	if(document.subBut.content.value == ""){
        	window.alert("内容を入力してください");
			return false;
    	}else{
    		if(confirm('再投稿してもよろしいですか？')) {
    			alert("再投稿しました");
    			// windowを閉じる処理
    			//window.close();
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