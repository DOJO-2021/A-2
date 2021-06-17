<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<form method="POST" action="/OpenQA/MenuServlet">
		<!-- カテゴリーのプルダウン  -->
		<select name="b_category" id="b_category">
			<option value="">カテゴリー</option>
			<option value="パーソナルスキル">パーソナルスキル</option>
			<option value="IT基礎">IT基礎コース</option>
			<option value="java基礎">java基礎コース</option>
			<option value="その他">その他</option>
		</select> <input type="submit" name="SUBMIT" value="検索">
	</form>

	<div class="tab_wrap">
		<!-- タブの為のラジオボタン -->
		<c:forEach items="${list}" var="s_list">
			<c:forEach items="${s_list}" var="value">
				<input type="radio" id="${value.s_category}" name="tab_btn">
			</c:forEach>
		</c:forEach>

		<!-- タブ -->
		<div class="tab_area">
			<c:forEach items="${list}" var="s_list">
				<c:forEach items="${s_list}" var="value">
					<label class="tab1_label" for="${value.s_category}">${value.s_category}</label>
				</c:forEach>
			</c:forEach>
		</div>

		<div class="panel_area">
			<div id="${value.s_category}+1" class="tab_panel">
			<c:set var="data" value="0" />


				<c:forEach items="${list}" var="s_list">

					<c:forEach items="${s_list}" var="value">

					</c:forEach>
				</c:forEach>

			</div>
		</div>
	</div>
</body>
</html>