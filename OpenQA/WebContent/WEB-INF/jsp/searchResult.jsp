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
		<c:forEach items="${questionList}" var="value1" varStatus="status"><!-- joinした物の一覧 -->
		<c:if test="${data != value1.q_id}" >
		<!-- 持ってきたQuestion -->
			<tr>
				<td><c:out value="${value1.to}" /></td>
				<td><c:if test="${sessionScope.user.type==1}">
				<c:out value="${value1.q_name}"/>
				</c:if> <c:if test="${sessionScope.user.type==0 && value.q_anonymity== 1}">
				匿名
				</c:if>
				<c:if test="${sessionScope.user.type==0 && value.q_anonymity== 0 }">
				<c:out value="${value1.q_name}"/>
				</c:if></td>
				<td><c:out value="${value1.title}" /></td>
				<td><c:out value="${value1.b_category}" /></td>
				<td><c:out value="${value1.s_category}" /></td>
				<td><c:out value="${value1.q_date}" /></td>
				<!-- 私もボタンはcheackbox! 押されたら画像を変えて(CSS)metooの値を1増やす(yatta)
				　　チェックボックスが押されるまでは私もボタンを表示して
				　　押されたら下のreplyボタンが出るようにする。yatta -->
				<td class="del" id="del2Id${status.index}"><input type="checkbox" name="meToo" value="0" id="meToo"/><c:out value="${value1.metoo}" /></td>
				<td class="del" id="delId${status.index}"><a href="/OpenQA/RegistServlet?mode=answer" target="_blank" rel="noopener noreferrer"> <img
				src="/OpenQA/images/reply.png"></a></td>
				<!-- checkbox 押されたらcheckbox以下の内容が出る 上の私もボタンが消える。解決済 詳細の文字を隠すに変えなきゃ！ -->
				<td class="del" id="delId${status.index}"><input type="checkbox" name="ch" value="1" onchange="disp('${status.index}')"  id="checkId${status.index}">詳細</td>
				<td class="del" id="delId${status.index}"><c:out value="${value1.title}" /></td>
				<td class="del" id="delId${status.index}"><c:out value="${value1.content}" /></td>
				<td class="del" id="delId${status.index}"><input type="submit" class="button" name="SUBMIT" value="q_update"></td>
				<td class="del" id="delId${status.index}"><input type="submit" class="button" name="SUBMIT" value="q_delete"></td>
				<!-- solutionのjsの文章は後で考えよう tabunndekita -->
				<td class="del" id="delId${status.index}"><input type="checkbox" name="solution" value="0" id="solution"></td>
				<td class="del" id="delId${status.index}"><img src="/OpenQA/images/preMeToo.png"><c:out value="${value1.metoo}" /></td>
				<td class="del" id="delId${status.index}"><img src="${value1.q_images} }"></td>
			</tr>
			</c:if>
			<c:remove var="data" />
			<c:set var="data" value="${value1.q_id}" />
			<tr class="del" id="delId${status.index}">
			<!-- 解答を質問の下に表示 -->
				<c:if test="${data == value1.q_id}" >
				<td><c:if test="${sessionScope.user.type==1}">
				<c:out value="${value1.a_name}"/>
				</c:if> <c:if test="${sessionScope.user.type==0 && value.a_anonymity== 1}">
				匿名
				</c:if>
				<c:if test="${sessionScope.user.type==0 && value.a_anonymity== 0 }">
				<c:out value="${value1.a_name}"/>
				</c:if></td>
				<td><c:out value="${value1.a_date}"/></td>
				<td><c:out value="${value1.answer}" /></td>
				<td><img src="${value1.a_images} }"></td>
				<td><input type="submit" class="button" name="SUBMIT" value="a_update"></td>
				<td><input type="submit" class="button" name="SUBMIT" value="a_delete"></td>
				</c:if>
			</tr>
			</c:forEach>
		</table>
		</form>
</body>
<style>
	.del{
		display:none
	}
</style>
<script>
    //チェックボックスのチェックが動作したら動く
	function disp(indexNo){
		//ここは隠している項目を表示する部分-------------------
		//チェックボックスの状態を取得
		var ch =document.getElementById('checkId'+indexNo);
		//隠している部分の情報を取得
		var hide =document.getElementById('delId'+indexNo);
		//私もボタン用のdelId
		var hidden =document.getElementById('del2Id'+indexNo);
		//もし、チェックボックスにチェックがついたら
		if(ch.checked){
			//隠している部分のクラス適用（隠す）を無くす
			hide.setAttribute('class','');
			hidden.setAttribute('class','del');

		}else{
			//隠している部分のクラス適用（隠す）をつける
			hide.setAttribute('class','del');
			hidden.setAttribute('class','');
		}

		//solution Ajax(kari)
		function valueChange(event){
			$.ajax({
				type:'post',
				url: '/OpenQA/UpdateDeleteServlet?mode=solution',
				data: {	"solution": 1}
			});
		}

		let saveCheckbox = document.getElementById('solution');
		saveCheckbox.addEventListener('change', valueChange);
	}

    //meToo ajax(kari)
	function valueChange(event){
		$.ajax({
			type:'post',
			url: '/OpenQA/UpdateDeleteServlet?mode=meToo',
			data: {	"meToo": 1}
		});
	}

	let saveCheckbox = document.getElementById('meToo');
	saveCheckbox.addEventListener('change', valueChange);
}
</script>
</html>