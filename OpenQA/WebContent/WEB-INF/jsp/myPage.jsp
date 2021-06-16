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

	<div class="panel_area">
		<!-- 質問タブ -->
		<div id="panel1" class="tab_panel">
			<c:set var="data" value="0" />
			<c:forEach items="${mypageQuestionList}" var="value" varStatus="status">
				<c:if test="${data != value.q_id}">
					<!-- 「マイページ質問」の部分 -->
					<tr>
						<!-- 各項目 -->
						<td><c:out value="${value.to}" /></td>
						<td><c:out value="${value.q_name}" /></td>
						<td><c:out value="${value.title}" /></td>
						<td><c:out value="${value.b_category}" /></td>
						<td><c:out value="${value.s_category}" /></td>
						<td><c:out value="${value.date}" /></td>
						<!-- 「わたしもボタン」 -->
						<td class="del" id="del2Id${status.index}"><img src="/OpenQA/images/preMeToo.png"><c:out value="${value1.metoo}" /></td>
						<!-- チェックボックス -->
						<td><input type="checkbox" name="ch" value="1" onchange="disp('${status.index}')"  id="checkId${status.index}"></td>
						<td class="del" id="del2Id${status.index}">詳細</td>
						<td class="del" id="delId${status.index}">隠す</td>
					</tr>

					<!-- 詳細が押されたら以下が表示される -->
					<tr class="del" id="delId${status.index}"><br>
						<!-- タイトルと内容 -->
						<td><c:out value="${value.title}" /></td><br>
						<td><c:out value="${value.content}" /></td><br>

						<!-- 編集/削除ボタン・解決ボタン・わたしもボタン -->
						<td><input type="submit" class="button" name="SUBMIT" value="編集"></td>
						<td><input type="submit" class="button" name="SUBMIT" value="削除" onclick="delete();"></td>
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
			<c:set var="data" value="0" />
			<c:forEach items="${mypageQuestionList}" var="value" varStatus="status">
				<c:if test="${data != value.q_id}">
					<!-- 「マイページ回答」の部分 -->
					<tr>
						<!-- 各項目 -->
						<td><c:out value="${value.to}" /></td>
						<td><c:out value="${value.q_name}" /></td>
						<td><c:out value="${value.title}" /></td>
						<td><c:out value="${value.b_category}" /></td>
						<td><c:out value="${value.s_category}" /></td>
						<td><c:out value="${value.date}" /></td>
						<!-- 「わたしもボタン」 -->
						<td class="del" id="del2Id${status.index}"><img src="/OpenQA/images/preMeToo.png"><c:out value="${value1.metoo}" /></td>
						<!-- チェックボックス -->
						<td><input type="checkbox" name="ch" value="1" onchange="disp('${status.index}')"  id="checkId${status.index}"></td>
						<td class="del" id="del2Id${status.index}">詳細</td>
						<td class="del" id="delId${status.index}">隠す</td> <!-- 場所ちがう？？113行目？？ -->
					</tr>

					<!-- 詳細が押されたら以下が表示される -->
					<tr class="del" id="delId${status.index}"><br>
						<!-- タイトルと内容 -->
						<td><c:out value="${value.title}" /></td><br>
						<td><c:out value="${value.content}" /></td><br>

						<!-- わたしもボタン -->
						<td><img src="/OpenQA/images/preMeToo.png"><c:out value="${value1.metoo}" /></td>
					</tr>
				</c:if>

					<c:remove var="data" />
					<c:set var="data" value="${value.q_id}" />
					<br>

				<!-- 回答詳細 -->
				<c:if test="${data == value.q_id}">
					<!-- 回答各項目 -->
					<tr>
						<td><c:out value="${value.a_id}" /></td>
						<td><c:out value="${value.a_name}" /></td>
						<td><c:out value="${value.date}" /></td>
					</tr>
					<!-- 回答内容 -->
					<tr>
						<td><c:out value="${value.answer}" /></td>
					</tr>
					<!-- 編集/削除ボタン -->
						<td><input type="submit" class="button" name="SUBMIT" value="編集"></td>
						<td><input type="submit" class="button" name="SUBMIT" value="削除" onclick="delete();"></td>
				</c:if>
			</c:forEach>
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

// 削除確認アラート
function delete() {
	if(confirm("本当に削除してよろしいですか？")) {
		alert("削除しました。");
		return true;
	} else {
		alert("キャンセルしました。");
		return false;
	}
}

// 未解決確認アラート
function unanswered() {
	if(confirm("")) {
		alert
	}
}
</script>

</html>