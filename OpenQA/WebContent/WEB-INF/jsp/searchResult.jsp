<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>検索結果一覧</h1>
	<hr>

	<c:forEach var="e" items="${QuestionList}">
	<form method="POST" action="/OpenQA/UpdateDeleteServlet">
		<table>
			<tr>
				<td><c:out value="${e.to}" /></td>
				<td><c:if test="${sessionScope.user.type==1}">
				${e.name}
				</c:if> <c:if test="${sessionScope.user.type==0 && e.anonymity== 1}">
				匿名
				</c:if>
				<c:if test="${sessionScope.user.type==0 && e.anonymity== 0 }">
				${e.name}
				</c:if></td>
				<td><c:out value="${e.title}" /></td>
				<td><c:out value="${e.b_category}" /></td>
				<td><c:out value="${e.s_category}" /></td>
				<td><c:out value="${e.date}" /></td>
				<!-- 私もボタンは押せるようにしなきゃダメ submit? 押されたら画像を変えてmetooの値を1増やす
				　　めっちゃ難しそうなので明日考えます。 -->
				<td><img src="/OpenQA/images/preMeToo.png"><c:out value="${e.metoo}" /></td>
				<!-- checkbox 押されたらcheckbox以下の内容が出る 上の私もボタンが消える。 -->
				<td><input type="checkbox" name="ch" value="1" onchange="disp('${status.index}')"  id="checkId${status.index}"></td>
				<td><c:out value="${e.title}" /></td>
				<td><c:out value="${e.content}" /></td>
				<td><input type="submit" class="button" name="SUBMIT" value="update"></td>
				<td><input type="submit" class="button" name="SUBMIT" value="delete"></td>
				<!-- jsの文章は後で考えよう -->
				<td><input type="checkbox" name="solution" value="0"></td>
				<td><img src="/OpenQA/images/preMeToo.png"><c:out value="${e.metoo}" /></td>
			</tr>
		</table>
		</form>
	</c:forEach>
</body>
</html>