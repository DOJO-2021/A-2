<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<link rel="stylesheet" href="/OpenQA/css/common.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="/OpenQA/js/zdo_drawer_menu.js"></script>
</head>
<body>
	<div class="header">
		<!-- logo and title -->
		<header class="site-header">
		<div class="logos">
			<h1>
				<img src="/OpenQA/images/mainLogo.png" class="sitelogo">

			Open Q&amp;A System</h1>
			</div>

			<div class="headsearch">
			<!-- serch -->
			<form method="POST" action="/OpenQA/SearchServlet">
				<input type="text" style="width: 300px; margin: 50;" name="word" placeholder="キーワード検索"><input
					type="image" src="/OpenQA/images/search.png" alt="送信する"
										name="submit" value="word" style="width:30px">
			</form>
			</div>

			<!-- regist and mypage -->
			<div class="gazo">
			<a href="/OpenQA/RegistServlet?mode=question" target="window_name" rel="noopener noreferrer"  onClick="wopen('/OpenQA/RegistServlet?mode=question')"> <img
				src="/OpenQA/images/post.png" style="width:80px"></a> <a href="/OpenQA/MyPageServlet"><img
				src="/OpenQA/images/myPage.png" style="width:80px"></a>
				</div>

			<!-- serch -->


			<!-- drawer menu -->
			<div class="zdo_drawer_menu" style="margin:2em;">
				<div class="zdo_drawer_bg"></div>
				<button type="button" class="zdo_drawer_button">
					<span class="zdo_drawer_bar zdo_drawer_bar1"></span> <span
						class="zdo_drawer_bar zdo_drawer_bar2"></span> <span
						class="zdo_drawer_bar zdo_drawer_bar3"></span> <span
						class="zdo_drawer_menu_text zdo_drawer_text">MENU</span> <span
						class="zdo_drawer_close zdo_drawer_text">CLOSE</span>
				</button>
				<nav class="zdo_drawer_nav_wrapper">
					<ul class="zdo_drawer_nav">

						<li class="gnav__menu__item"><a
							href="/OpenQA/MenuServlet?mode=unanswered">未解決質問一覧</a></li>


						<li class="gnav__menu__item"><a
							href="/OpenQA/MenuServlet?mode=category">カテゴリー</a></li>

						<li class="gnav__menu__item"><a
							href="/OpenQA/MenuServlet?mode=guide">使用ガイド</a></li>

						<li class="gnav__menu__item"><a
							href="/OpenQA/MenuServlet?mode=logout">ログアウト</a></li>

						<li class="gnav__menu__item"><img
							src="/OpenQA/images/subLogo.png" style="width:270px;"></li>

					</ul>
				</nav>
			</div>
		</header>
	</div>
</body>
<script>
function wopen(url){
	window.open(url, "window_name", "width=500,height=500,scrollbars=yes");
}
</script>
</html>