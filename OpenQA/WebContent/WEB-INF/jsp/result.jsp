<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
</head>
<body>
	<h1>
		<c:out value="${result.title}" />
	</h1>
	<hr>
	<p>
		<c:out value="${result.message}" />
	</p>

	<!-- welcome　to Open Q&A System～の文を挿入 -->

	<input type="submit" name="back_login" value="ログインページに戻る">
	<!--
<a href="${result.back_login}">ログインページに戻る</a>
 -->

 <!-- わかんない。保留！ -->
</body>
</html>
