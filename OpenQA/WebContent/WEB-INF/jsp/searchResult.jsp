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


	<form method="POST" action="/OpenQA/UpdateDeleteServlet">
		<table>
		<c:set var="data" value="0" />
		<c:forEach items="${questionList}" var="value1"><!-- joinした物の一覧 -->
		<c:if test="${data != value1.q_id}" >
		<!-- 持ってきたQuestion -->
			<tr>
				<td><c:out value="${value1.to}" /></td>
				<td><c:if test="${sessionScope.user.type==1}">
				<c:out value="${value1.Q_name}"/>
				</c:if> <c:if test="${sessionScope.user.type==0 && value.Q_anonymity== 1}">
				匿名
				</c:if>
				<c:if test="${sessionScope.user.type==0 && value.Q_anonymity== 0 }">
				<c:out value="${value1.Q_name}"/>
				</c:if></td>
				<td><c:out value="${value1.title}" /></td>
				<td><c:out value="${value1.b_category}" /></td>
				<td><c:out value="${value1.s_category}" /></td>
				<td><c:out value="${value1.Q_date}" /></td>
				<!-- 私もボタンは押せるようにしなきゃダメ submit? 押されたら画像を変えてmetooの値を1増やす
				　　めっちゃ難しそうなので明日考えます。チェックボックスが押されるまでは私もボタンを表示して
				　　押されたら下のreplyボタンが出るようにする。 -->
				<td><img src="/OpenQA/images/preMeToo.png"><c:out value="${value1.metoo}" /></td>
				<td><a href="/OpenQA/RegistServlet?mode=answer" target="_blank" rel="noopener noreferrer"> <img
				src="/OpenQA/images/reply.png"></a></td>
				<!-- checkbox 押されたらcheckbox以下の内容が出る 上の私もボタンが消える。 -->
				<td><input type="checkbox" name="ch" value="1" onchange="disp('${status.index}')"  id="checkId${status.index}"></td>
				<td><c:out value="${value1.title}" /></td>
				<td><c:out value="${value1.content}" /></td>
				<td><input type="submit" class="button" name="SUBMIT" value="q_update"></td>
				<td><input type="submit" class="button" name="SUBMIT" value="q_delete"></td>
				<!-- jsの文章は後で考えよう -->
				<td><input type="checkbox" name="solution" value="0"></td>
				<td><img src="/OpenQA/images/preMeToo.png"><c:out value="${value1.metoo}" /></td>
			</tr>
			</c:if>
			<c:remove var="data" />
			<c:set var="data" value="${value1.q_id}" />
			<tr>
			<!-- 解答を質問の下に表示 -->
				<c:if test="${data == value1.q_id}" >
				<td><c:if test="${sessionScope.user.type==1}">
				<c:out value="${value1.A_name}"/>
				</c:if> <c:if test="${sessionScope.user.type==0 && value.A_anonymity== 1}">
				匿名
				</c:if>
				<c:if test="${sessionScope.user.type==0 && value.A_anonymity== 0 }">
				<c:out value="${value1.A_name}"/>
				</c:if></td>
				<td><c:out value="${value1.answer}" /></td>
				<td><input type="submit" class="button" name="SUBMIT" value="a_update"></td>
				<td><input type="submit" class="button" name="SUBMIT" value="a_delete"></td>
				</c:if>
			</tr>
			</c:forEach>
		</table>
		</form>
</body>
</html>