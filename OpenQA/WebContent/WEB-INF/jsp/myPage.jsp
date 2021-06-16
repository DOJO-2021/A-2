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

<div class="tab_wrap">

<input type="radio" id="tab1" name="tab_btn" checked>
<input type="radio" id="tab2" name="tab_btn">

	<div class="tab_area">
	<label class="tab1_label" for="tab1">質問</label>
	<label class="tab1_label" for="tab1">回答</label>
	</div>

	<!-- 質問タブ -->>
	<div class="panel_area">
		<div id="panel1" class="tab_panel">
			<c:set var="data" value="0" />
			<c:forEach items="${mypageQuestionList}" var="value" varStatus="status">
				<c:if test="${data != value.q_id}">
					<!-- 「マイページ質問」の部分 -->
					<tr>
						<td><c:out value="${value.to}" /></td>
						<td><c:out value="${value.q_name}" /></td>
						<td><c:out value="${value.title}" /></td>
						<td><c:out value="${value.b_category}" /></td>
						<td><c:out value="${value.s_category}" /></td>
						<td><c:out value="${value.date}" /></td>
						<!-- 「わたしもボタン」 -->
						<td class="del" id="del2Id${status.index}"><img src="/OpenQA/images/preMeToo.png"><c:out value="${value1.metoo}" /></td>
						<!-- チェックボックス -->
						<id="delId${status.index}"><input type="checkbox" name="ch" value="1" onchange="disp('${status.index}')"  id="checkId${status.index}">
					</tr>

					<tr class="del" id="delId${status.index}"><br>
						${value.title}<br>
						${value.content}<br>

						<!--  -->
						<td><input type="submit" class="button" name="SUBMIT" value="編集"></td>
						<td><input type="submit" class="button" name="SUBMIT" value="削除"></td>
						<td><input type="checkbox" name="solution" value="0"></td>
						<td><img src="/OpenQA/images/preMeToo.png"><c:out value="${value1.metoo}" /></td>
					</tr>
				</c:if>
					<c:remove var="data" />
					<c:set var="data" value="${value.q_id}" />
					<br>
				<c:if test="${data == value.q_id}">
				${value.a_id} ${value.a_name} ${value.answer} <br>
				</c:if>
			</c:forEach>
		</div>

		<!-- 回答タブ -->
		<div id="panel2" class="tab_panel">

		</div>
	</div>
</div>
</body>
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

}
</script>

</html>