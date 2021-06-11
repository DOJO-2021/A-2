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
<table>
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
		<select name="b_category">
			<option value="">カテゴリー</option>
			<option id="" value="パーソナルスキル">パーソナルスキル</option>
			<option id="" value="IT基礎">IT基礎コース</option>
			<option id="" value="java基礎">java基礎コース</option>
			<option id="" value="その他">その他</option>
		</select>

		<!-- 二つ目のセレクトボックス（連動する） -->
		<select name="s_category">
		</select>

	</th>


</table>


</body>
</html>