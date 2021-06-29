<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&A System</title>
<link rel="stylesheet" href="/OpenQA/css/common.css">
</head>
<body>
			<h1>
			<img src="/OpenQA/images/mainLogo.png" class="sitelogo"  width="80" height="80">
			Open Q&amp;A System
			</h1>
			<hr>
  <div class="content">
	<h2>
		<c:out value="${result.title}" />
	</h2>


	<!-- welcome　to Open Q&A System～の文を挿入 -->
  <c:if test="${result.message == 'あり'}">
	<table>
	  <tr>
	    <th>
	    	welcome to Open Q&A System
	    </th>
	  </tr>
	   <tr>
	    <th>
	    	使い方
	    </th>
	  </tr>
	  <tr>
	    <td>
	    	・ 質問をする前は、過去に似たような質問がされていないか検索してみましょう！<br>
			・回答することで自分の理解も深めることができます。どんどん回答しよう！ <br>
			・回答することで待ち時間が短縮できるかも！<br>
			・「私もボタン」を押して質問に共感してみ？<br>

	    </td>
	  </tr>
	</table>
  </c:if>
<br>
<br>

<a href="/OpenQA/LoginServlet">ログインページに戻る</a>

</div>

 <!-- わかんない。保留！ -->
</body>
</html>
