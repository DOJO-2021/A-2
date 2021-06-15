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
	<c:set var="data" value="0" />
	<c:forEach items="${question}" var="value" >
		<c:if test="${data != value.q_id}">
		${value.q_id} ${value.q_name} ${value.title} ${value.content}<br>
		</c:if>
		<c:remove var="data" />
		<c:set var="data" value="${value.q_id}" />
		<br>
		<c:if test="${data == value.q_id}">
		${value.a_id} ${value.a_name} ${value.answer} <br>
		</c:if>
	</c:forEach>



</body>
</html>