<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>検索結果一覧</h1>
<hr>

<c:forEach var="e" items="${QuestionList}" >
<table>
<tr>
<td><c:out value="${list.to}" /></td>
<td><c:if test="${sessionScope.user.type==1}">
	${requestScope.QuestionUser.name}
</c:if>
<c:if test="${sessionScope.user.flg==0}">
	匿名
</c:if></td>
<td><c:out value="${list.title}" /></td>

</tr>
</table>
</c:forEach>
</body>
</html>