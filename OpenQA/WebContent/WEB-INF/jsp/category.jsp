<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

</style>
</head>
<body>
	<form method="POST" action="/OpenQA/MenuServlet">
		<!-- カテゴリーのプルダウン  -->
		<select name="b_category" id="b_category">
			<option value="">カテゴリー</option>
			<option value="パーソナルスキル">パーソナルスキル</option>
			<option value="IT基礎">IT基礎コース</option>
			<option value="java基礎">java基礎コース</option>
			<option value="その他">その他</option>
		</select> <input type="submit" name="SUBMIT" value="検索">
	</form>

	<div class="tab_wrap">
		<!-- タブの為のラジオボタン -->
		<c:forEach items="${list}" var="s_list">
			<c:forEach items="${s_list}" var="value">
				<input type="radio" id="${value.s_category}" name="tab_btn">
			</c:forEach>
		</c:forEach>

		<!-- タブ -->
		<div class="tab_area">
			<c:forEach items="${list}" var="s_list">
				<c:forEach items="${s_list}" var="value">
					<label class="tab1_label" for="${value.s_category}">${value.s_category}</label>
				</c:forEach>
			</c:forEach>
		</div>

		<div class="panel_area">
			<div id="${value.s_category}+1" class="tab_panel">
				<c:set var="data" value="0" />

				<c:forEach items="${list}" var="s_list">
					<c:forEach items="${s_list}" var="value"  varStatus="status">
						<c:if test="${data != value.q_id}">

							<tr>
								<!-- 各項目 -->
								<td><c:out value="${value.to}" /></td>
								<td><c:out value="${value.q_name}" /></td>
								<td><c:out value="${value.title}" /></td>
								<td><c:out value="${value.b_category}" /></td>
								<td><c:out value="${value.s_category}" /></td>
								<td><c:out value="${value.q_date}" /></td>

								<!-- 「わたしもボタン」 -->
								<td class="" id="good${status.index}">
									<img src="/OpenQA/images/preMeToo.png">
									<c:out value="${value.metoo}" />
								</td>

								<!-- チェックボックス -->
								<td><input type="checkbox" name="ch" value="0"
									onchange="disp('${status.index}')" id="checkId${status.index}">
								<td class="" id="detail${status.index}">詳細</td>
								<td class="del" id="hide${status.index}">隠す</td>
							</tr>

						<!-- 詳細が押されたら以下が表示される -->
						<div class="del" id="details${status.index}">
							<tr>
								<!-- タイトルと内容 -->
								<td><c:out value="${value.title}" /></td>
								<td><c:out value="${value.content}" /></td>

								<!-- 編集/削除ボタン・解決ボタン・わたしもボタン -->
								<td><input type="submit" class="button" name="SUBMIT" value="編集"></td>
								<td><input type="submit" class="button" name="SUBMIT" value="削除" onclick="delete();"></td>
								<td><input type="checkbox" name="solution" value="0"></td>
								<td>
									<img src="/OpenQA/images/preMeToo.png">
									<c:out value="${value.metoo}" />
								</td>
							</tr>
						</c:if>

						<c:remove var="data" />
						<c:set var="data" value="${value.q_id}" />
						<tr>
							<!-- 回答を質問の下に表示 -->
							<c:if test="${data == value.q_id}">

								<!-- user typeが講師だった場合 -->
								<td><c:if test="${sessionScope.user.type==1}">
										<c:out value="${value.a_name}" />
									</c:if>
								</td>
							</c:if>

							<!-- user typeが受講者かつ匿名希望の場合 -->
							<c:if test="${sessionScope.user.type==0 && value.a_anonymity== 1}">
								<td>匿名</td>
							</c:if>

							<!-- user typeが受講者かつ匿名を希望しない場合 -->
							<c:if test="${sessionScope.user.type==0 && value.a_anonymity== 0 }">
								<td><c:out value="${value.a_name}" /></td>
							</c:if>
							<td><c:out value="${value.a_date}" /></td>
							<td><c:out value="${value.answer}" /></td>

							<!-- 画像は保留 -->
							<td><c:out value="${value.q_images}" /></td>
						</div>

					</c:forEach>
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
	//隠す
	var hide =document.getElementById('hide'+indexNo);
	//詳細
	var detail =document.getElementById('detail'+indexNo);
	//「わたしも」ボタン
	var good =document.getElementById('good'+indexNo);
	//詳細ボタンが押されたら表示されるもの
	var details =document.getElementById('details'+indexNo);

	//もし、チェックボックスにチェックがついたら
	if(ch.checked){
		//チェックボックスにチェックが入っていた場合
		//表示されてるのは（隠す、details）
		hide.setAttribute('class','');
		detail.setAttribute('class','del');
		good.setAttribute('class','del');
		details.setAttribute('class','');
	}else{
		//チェックボックスにチェックがされていない場合
		hide.setAttribute('class','del');
		detail.setAttribute('class','');
		good.setAttribute('class','');
		details.setAttribute('class','del');
	}
	var check =document.getElementById('checkId'+indexNo);
	var button = document.getElementById('buttonId'+indexNo);
	if(check.checked){
		//ボタンを活性化
		button.disabled = false;
	}else{
		//ボタンを非活性
		button.disabled = true;
	}
	alert("bb");
}

// 削除確認アラート
function delete2() {
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
	if(confirm("質問を未解決に戻してよろしいですか？")) {
		alert("未解決に戻しました。");
		return true;
	} else {
		alert("キャンセルしました。");
		return false;
	}
}
</script>
</html>