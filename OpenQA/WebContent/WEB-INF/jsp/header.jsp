<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="header">
	<!-- logo and title -->
	<header class="site-header">
	<h1 class="site-logo"><img src="/OpenQA/WebContent/images/mainLogo.png"></h1>
	<h1>Open Q&amp;A System</h1>

	<!-- serch -->
	<form method="POST" action="/OpenQA/SearchServlet">
	<input type="text" style="width:150px;" name="search"><input type="image" src="/OpenQA/WebContent/images/search.png" alt="送信する"name="submit" value="Search">
	</form>

	<!-- search and mypage -->
	<a href="/OpenQA/RegistServlet?mode=question"><img src="/OpenQA/images/post.png"></a>
	<a href="/OpenQA/MyPageServlet"><img src="/OpenQA/images/myPage.png"></a>

	<!-- drawer menu -->>
	<nav class="gnav">
	  <ul class="gnav__menu">
	    <li class="gnav__menu__item"><a href="/OpenQA/MenuServlet?mode=unanswered">未解決質問一覧</a></li>
	    <li class="gnav__menu__item"><a href="/OpenQA/MenuServlet?mode=category">カテゴリー</a></li>
	    <li class="gnav__menu__item"><a href="/OpenQA/MenuServlet?mode=guide">使用ガイド</a></li>
	    <li class="gnav__menu__item"><a href="/OpenQA/MenuServlet?mode=logout">ログアウト</a></li>
	    <li class="gnav__menu__item"><img src="/OpenQA/images/subLogo.png"></li>
	  </ul>
	</nav>
	</header>
	</div>>
</body>
</html>