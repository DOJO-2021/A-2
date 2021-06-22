<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
<script type="text/javascript" src="/OpenQA/js/common.js"></script>
</head>
<body>
<h2>質問編集</h2>
<form method="POST" name = "subBut" action="/OpenQA/UpdateDeleteServlet"  enctype="multipart/form-data">
<input type="hidden" name="p_id" value="${param.q_id} ">
<table>
<tr>
	<th>
		<!-- 回答者を指定する -->
		<select name="to">
			<option value="" >回答者を選択</option>
			<option value="0" <c:if test = "${param.to == 0}"> selected </c:if>>だれでも</option>
			<option value="1" <c:if test = "${param.to == 1}"> selected </c:if>>講師</option>
			<option value="2" <c:if test = "${param.to == 2}"> selected </c:if>>受講者</option>
		</select>

		from. ${question.name}

		<input type="hidden" name="anonymity" value="0">
		<input type="checkbox" name="anonymity" value="1" <c:if test = "${param.anonymity == 1}"> checked </c:if>>匿名

		<!-- ひとつめのセレクトボックス -->
		<!-- web開発コースは保留  -->
		<select name="b_category" id="b_category" onchange="category()">
			<option value="">カテゴリー</option>
			<option  value="パーソナルスキル" <c:if test = "${param.b_category == パーソナルスキル}"> selected </c:if> >パーソナルスキル</option>
			<option  value="IT基礎" <c:if test = "${param.b_category == IT基礎}"> selected </c:if>>IT基礎コース</option>
			<option  value="java基礎" <c:if test = "${param.b_category == java基礎}"> selected </c:if>>java基礎コース</option>
			<option  value="その他" <c:if test = "${param.b_category == その他}"> selected </c:if>>その他</option>
		</select>

		<input type="hidden" id="s_category" value="${param.s_category}">
		<!-- 二つ目のセレクトボックス（連動する） -->
		<select name="s_category">
		</select>
	</th>
</tr>
<tr>
	<td>
	<p>タイトル <input type="text" name="title" value="${param.title}"></p>
	<p>内容<textarea name="content">${param.content}</textarea></p>
	<c:if test = "${param.images != null}">
		<img src="/OpenQA/images/${param.images}" alt = "ccc" id="p1">
	</c:if>
	<input type="hidden" value="${param.images}" name="preImage" id="preImage">
	<canvas id="preview" style="max-width:200px;"></canvas><br>

	<input type="button" id="btn1" value="画像削除" onclick="cls();">
	<label>
		<img src="images/insert.jpeg" alt="画像添付">
		<input type="file" name="IMAGE" accept="image/*" onchange="previewImage(this);">
	</label>

	<input type="hidden" name="q_id" value="${param.q_id}">
	<input type="hidden" name="solution" value="${param.solution}">
	<input type="text" name="meToo" value="${param.meToo}">
	<input type="hidden" name="so" value="0">
	<input type="hidden" name="meto" value="0">


	<input type="submit" name="SUBMIT" value="質問編集">
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
    	if(document.subBut.title.value == "" || document.subBut.content.value == ""){
        	window.alert("タイトルおよび内容を入力してください");
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
			return true;
   		}
	}

</script>

</html>