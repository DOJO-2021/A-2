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


			<h1>
				<img src="/OpenQA/images/mainLogo.png" class="sitelogo"  width="80" height="80">

			Open Q&amp;A System</h1>
			<hr>


<h2>質問登録</h2>
<form method="POST" name = "subBut" action="/OpenQA/RegistServlet?mode=question"  enctype="multipart/form-data" id="form">
<table>
<tr>
	<th colspan="2" align="left">
		<!-- 回答者を指定する -->
		<select name="to" id="to">
			<option value="">回答者を選択</option>
			<option value="0">だれでも</option>
			<option value="1">講師</option>
			<option value="2">受講者</option>
		</select>

		from. ${user.name}


		<input type="checkbox" name="ch" id="ch">匿名
		<input type="hidden" value="0" name="anonymity" id="anonymity">

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
		<select name="s_category" id="s_category">
		</select>
	</th>
</tr>
<tr>
	<td>
		タイトル
	</td>
	<td>
		<input type="text" name="title" id="title" style="width: 550px;">
	</td>
</tr>
<tr>
	<td style="text-align: center">
		内容
	</td>
	<td>
	<p><textarea name="content" id="content" style="width: 550px; height: 100px"></textarea></p>
	</td>
</tr>
<tr>
	<td colspan="2" align="right">
	<canvas id="preview" style="max-width:200px;"></canvas><br>

	<label>
		<img src="images/insert.jpeg" alt="画像添付">
		<input type="file" name="IMAGE" accept="image/*" onchange="previewImage(this);">
	</label>

	<input type="submit" name="SUBMIT" value="質問投稿" onclick="return checkForm();">
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
/*
	// 未入力アラート
	function checkForm(){
		// 各変数
    	var to = document.getElementById('to');
    	var b_cate = document.getElementById('b_category');
      	var s_cate = document.getElementById('s_category');
      	var title = document.getElementById('title');
      	var content = document.getElementById('content');

        //宛先(To)未入力アラート
    	if(to.value == ""){
        	window.alert("宛先を指定してください");
        	 //カテゴリー未入力アラート
        	if(b_cate.value == "" || s_cate.value == ""){
            	window.alert("カテゴリーを選択してください");
            	// タイトル及び内容未入力アラート
              	if(title.value == "" || content.value == ""){
                	window.alert("タイトルおよび内容を入力してください");
            	}
       		}
        	 return false;
   		} else{
    		if(confirm('投稿してもよろしいですか？')) {
    			alert("投稿しました");
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
*/
	// 未入力アラート
	function checkForm(){
	var ch = document.getElementById('ch');
	var anonymity = document.getElementById('anonymity');
	if (ch.checked) {
		anonymity.value = "1";

	} else {
		anonymity.value = "0";

	}

		var to = document.getElementById('to');
		var b_cate = document.getElementById('b_category');
      	var s_cate = document.getElementById('s_category');
      	var title = document.getElementById('title');
      	var content = document.getElementById('content');

	  	//宛先(To)未入力アラート

    	if(to.value == ""){
        	window.alert("宛先を指定してください");
        	return false;
   		}

        //カテゴリー未入力アラート

    	if(b_cate.value == "" || s_cate.value == ""){
        	window.alert("カテゴリーを選択してください");
        	return false;
   		}


    	if(title.value == "" || content.value == ""){
        	window.alert("タイトルおよび内容を入力してください");
        	return false;

    	}else{
    		if(confirm('投稿してもよろしいですか？')) {
    			alert("投稿しました");
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