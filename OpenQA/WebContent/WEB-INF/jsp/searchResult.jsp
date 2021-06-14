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
<td></td>
</tr>
</table>
</c:forEach>
</body>
</html>