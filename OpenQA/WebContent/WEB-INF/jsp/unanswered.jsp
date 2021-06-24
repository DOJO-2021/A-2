<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Q&amp;A System</title>
<link rel="stylesheet" href="/OpenQA/css/common.css">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp"/>
<div class="content">
<h1>未解決質問一覧</h1>


<c:set var="data" value="0" />
			<table class="table">
			<tr>
				<td>
					宛先
				</td>
				<td>
					質問者名
				</td>
				<td>
					質問のタイトル
				</td>
				<td>
					カテゴリー
				</td>
				<td>
					日付
				</td>
			</tr>
				<!-- 自分の質問を表示（詳細を押す前） -->
				<c:forEach items="${question}" var="value" varStatus="status">
					<!-- q_idが一致する質問を取り出す -->
					<c:if test="${data != value.q_id }">
						<tr>
							<td   class="border">
							<c:if test="${value.to == 0}">
								<c:out value="To.全員" />
							</c:if>
							<c:if test="${value.to == 1}">
								<c:out value="To.講師" />
							</c:if>
							<c:if test="${value.to == 2}">
								<c:out value="To.受講者" />
							</c:if>
							</td>
							<td   class="border">
							<c:if test="${sessionScope.user.type==1}">
								<c:out value="From.${value.q_name}" />
								</c:if>
								<c:if test="${sessionScope.user.type==0 and value.q_anonymity== 1 and sessionScope.user.id != value.q_userId}">
																	From:匿名
																</c:if>
								<c:if test="${sessionScope.user.type==0 and value.q_anonymity== 1 and sessionScope.user.id == value.q_userId}">
									<c:out value="From:${value.q_name}"/>
																</c:if>
															<!-- user typeが受講者かつ匿名を希望しない場合 -->
																<c:if test="${sessionScope.user.type==0 and value.q_anonymity== 0 }">
																	<c:out value="From:${value.q_name}"/>
																</c:if>
							</td>
							<td class="testOverflowTest1">
								<c:out value="${value.title}" />
							</td>
							<td>
								<c:out value="${value.b_category}" />
								<c:out value="ｰ${value.s_category}" />
							</td>
							<td>
								<c:out value="${value.q_date}" />
							</td>
							<!--チェックボックス -->
							<td>
								<input type="checkbox" name="ch" value="0" onchange="disp('${status.index}')" id="checkId${status.index}">
								<span class="open" id="detail${status.index}">
								詳細
								</span>
								<span class="close" id="hide${status.index}">
								隠す
								</span>
							</td>
							<!-- status.index→毎ループごとにgoodボタンを隠す -->
							<td>
								<!-- 私もボタン -->
								<div class="open" id="good${status.index}">
									<img src="/OpenQA/images/preMeToo.png" alt="私も">
									<c:out value="${value.metoo}" />
								</div>
								<!-- replyボタン -->
								<div class="close" id="reply${status.index}">
								  <form method="GET" action="/OpenQA/RegistServlet?mode=answer" target="window_name" rel="noopener noreferrer">
								  	<input type="hidden" name="mode" value="answer">
								  	<input type="hidden" name="q_id" value="${value.q_id}">
								  	<input type="SUBMIT" value=":ボールペン:" onClick="wopen('/OpenQA/RegistServlet?mode=answer')">
								  </form>
								</div>
							</td>

						</tr>

						<!-- 質問の詳細を表示 -->

						<tr class="close" id="q_detail${status.index}">

							<td colspan="7">

								タイトル：
								<div style="padding: 10px; border: 1px solid #333333; border-radius: 10px; text-align:left">
								${value.title}
								</div>
								<br>
								内容：
								<div style="padding: 10px; border: 1px solid #333333; border-radius: 10px; text-align:left">
								${value.content}
								</div>
								<br>
								<img src="/OpenQA/images/${value.q_images}" alt="">

							</td>

						</tr>


						<!-- 編集ボタンを押したら以下のデータをUpdateDeleteServletに送る -->

						<tr class="close" id="tq_detail${status.index}">
						<c:if test="${sessionScope.user.id == value.q_userId}">
							<td>
							<div class="border">
								<form style="display: inline" method="GET" action="/OpenQA/UpdateDeleteServlet" target="window_name" rel="noopener noreferrer">
										<input type="hidden" name="mode" value="question">
										<input type="hidden" name="q_id" value="${value.q_id}">
										<input type="hidden" name="to" value="${value.to}">
										<input type="hidden" name="anonymity" value="${value.q_anonymity}">
										<input type="hidden" name="b_category" value="${value.b_category}">
										<input type="hidden" name="s_category" value="${value.s_category}">
										<input type="hidden" name="title" value="${value.title}">
										<input type="hidden" name="content" value="${value.content}">
										<input type="hidden" name="images" value="${value.q_images}">
										<input type="hidden" name="meToo" value="${value.metoo}">
										<input type="hidden" name="solution" value="${value.solution}">
										<input type="hidden" name="so" value="0">
										<input type="hidden" name="meto" value="0">
										<input type="submit" class="button" name="SUBMIT" value="編集" onClick="wopen('/OpenQA/UpdateDeleteServlet')">
									</form>
							</div>
							</td>
								<!-- 削除ボタンを押したら以下のデータをUpdateDeleteServletに送る -->
							<td>
							<div class="border">
								<form method="POST" action="/OpenQA/UpdateDeleteServlet" name="form" onSubmit="return delete1()" >
									<input type="hidden" name="q_id" value="${value.q_id}">
									<input type="hidden" name="meToo" value="${value.metoo}">
									<input type="hidden" name="solution" value="${value.solution}">
									<input type="hidden" name="so" value="0">
									<input type="hidden" name="meto" value="0">
									<input type="hidden" name="mode" value="unans">
								<input type="submit" class="button" name="SUBMIT" value="質問削除">
								</form>
							</div>
							</td>
							<td>
							<div class="border">
								<!-- 解決ボタン -->
								<input type="checkbox" name="solution" id="solution${status.index}"  onchange="solution('${status.index}','${value.q_id}')" <c:if test="${value.solution == 1}">checked</c:if>>
							</div>
							</td>
							</c:if>
							<td colspan="4">
							<div class="border">
								<!-- 私もボタン-->
								<input type="checkbox" name="meToo" value="0" id="meToo${status.index}"  onchange="meToo('${status.index}','${value.q_id}','${value.metoo}')">
								<img src="/OpenQA/images/preMeToo.png"><c:out value="${value.metoo}" />
							</div>
							</td>
						</tr>

					<c:set var="count" value="0" />
					</c:if>

					<c:remove var="data" />
					<c:set var="data" value="${value.q_id}" />
					<c:if test="${data == value.q_id}">
						<c:if test="${count == 0 }">
							<tr class="close" id="answer${status.index}">
								<td colspan="7">
									<table class="a_table" width="900">
									<!-- 回答を取り出すfor文 -->
										<c:forEach items="${question}" var="answer">
											<c:if test="${data == answer.a_q_id }">
												<tr>
														<!-- 回答を質問の下に表示 -->
															<!-- user typeが講師だった場合 -->
															<td  colspan="8">
															<h4 style="margin:0;">回答</h4>
															<hr width="987" align="left" style="margin:0;">

																<c:if test="${sessionScope.user.type==1}">

																<c:out value="From:${answer.a_name}"/>
																</c:if>
															<!-- user typeが受講者かつ匿名希望の場合 -->
																<c:if test="${sessionScope.user.type==0 and value.a_anonymity== 1 and sessionScope.user.id != value.a_userId}">
																	From:匿名
																</c:if>
																<c:if test="${sessionScope.user.type==0 and value.a_anonymity== 1 and sessionScope.user.id == value.a_userId}">
																		<c:out value="From:${value.a_name}"/>
																</c:if>
															<!-- user typeが受講者かつ匿名を希望しない場合 -->
																<c:if test="${sessionScope.user.type==0 and answer.a_anonymity== 0 }">
																	<c:out value="From:${answer.a_name}"/>
																</c:if>

																<c:out value="${answer.a_date}" />

															</td>
												</tr>

												<tr>
															<td colspan="8">
															内容：
															<div style="padding: 10px; border: 1px solid #333333; border-radius: 10px; width: 968px;">
																<c:out value="${answer.answer}" />

															<br>
															</div>
																<img src="/OpenQA/images/${value.a_images}" alt="画像イメージ">
															</td>
												</tr>
												<!-- 編集ボタンを押したら以下のデータをUpdateDeleteServletに送る -->
												<c:if test="${sessionScope.user.id == answer.a_userId}">
												<tr>
															<td style="width:30px;">
															<form style="display: inline" method="GET" action="/OpenQA/UpdateDeleteServlet" target="window_name" rel="noopener noreferrer">
																		<input type="hidden" name="mode" value="answer">
																		<input type="hidden" name="a_id" value="${answer.a_id}">
																		<input type="hidden" name="anonymity" value="${answer.a_anonymity}">
																		<input type="hidden" name="content" value="${answer.answer}">
																		<input type="hidden" name="images" value="${answer.a_images}">

																		<input type="submit" class="button" name="SUBMIT" value="編集" onClick="wopen('/OpenQA/UpdateDeleteServlet')">

																</form>




															<!-- 削除ボタンを押したら以下のデータをUpdateDeleteServletに送る -->

																<form style="display: inline" method="POST" action="/OpenQA/UpdateDeleteServlet" name="form"  onSubmit="return delete1()" >
																		<input type="hidden" name="q_id" value="${answer.q_id}">
																		<input type="hidden" name="meToo" value="${answer.metoo}">
																		<input type="hidden" name="solution" value="${answer.solution}">
																		<input type="hidden" name="so" value="0">
																		<input type="hidden" name="meto" value="0">
																		<input type="hidden" name="mode" value="mypage">
																		<input type="hidden" name="a_id" value="${answer.a_id}">

																		<input type="submit" class="button" name="SUBMIT" value="回答削除">

																</form>

															</td>

													<c:remove var="count" />
													<c:set var="count" value="1" />

												</tr>

												</c:if>
											</c:if>
										</c:forEach>
									</table>
								</td>
							</tr>
						</c:if>
					</c:if>
				</c:forEach>
			</table>
		</div>



</body>
<style>
	.close{display:none;
	}
	input[type="radio"]{display:none;}
</style>
<script src=https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js></script>
<script>
'use strict'
//チェックボックスのチェックが動作したら動く（質問タブの詳細）
function disp(indexNo){
	//チェックボックスの状態を取得
	var ch =document.getElementById('checkId'+indexNo);
	//隠している部分の情報を取得
		var hide =document.getElementById('hide'+indexNo);
		var q_detail =document.getElementById('q_detail'+indexNo);
		var tq_detail =document.getElementById('tq_detail'+indexNo);
		var answer =document.getElementById('answer'+indexNo);
		var reply =document.getElementById('reply'+indexNo);
	//開いている部分の情報を取得
		var good =document.getElementById('good'+indexNo);
		var detail =document.getElementById('detail'+indexNo);
	//もし、チェックボックスにチェックがついたら
		if(ch.checked){
			//closeを開く
			hide.setAttribute('class','open');
			q_detail.setAttribute('class','open');
			tq_detail.setAttribute('class','open');
			answer.setAttribute('class','open');
			good.setAttribute('class','close');
			detail.setAttribute('class','close');
			reply.setAttribute('class','open');
		}else{
			//openを閉じる
			hide.setAttribute('class','close');
			q_detail.setAttribute('class','close');
			tq_detail.setAttribute('class','close');
			answer.setAttribute('class','close');
			good.setAttribute('class','open');
			detail.setAttribute('class','open');
			reply.setAttribute('class','close');
		}
}
function delete1() {
	if(window.confirm("本当に削除してよろしいですか？")) {
		window.alert("削除しました。");
		return true;
	} else {
		window.alert("キャンセルしました。");
		return false;
	}
}


//質問タブのsolution Ajax(kari)
function solution(indexNo,q_id){
	var solution =document.getElementById('solution'+indexNo);
	if(solution.checked){
		//var q_id =document.getElementById('q_id');
		$.ajax({
		type:'post',
		url: '/OpenQA/UpdateDeleteServlet',
		data: {	"solution": 1,
				"q_id": q_id,
				"so":"123",
				"meto":"0",
				"meToo":"0"}
	});
	}else{
		$.ajax({
			type:'post',
			url: '/OpenQA/UpdateDeleteServlet',
			data: {	"solution": 0,
					"q_id": q_id,
					"so":"123",
					"meto":"0",
					"meToo":"0"}
		});
	}

}
	let saveCheckbox = document.getElementById('solution');
	saveCheckbox.addEventListener('change', solution);

	//metooは1回押したら1増える
	function meToo(indexNo,q_id,metoo){
		var intMetoo = parseInt(metoo);
		var meToo =document.getElementById('meToo'+indexNo);
		if(meToo.checked){
			intMetoo ++;
			//var q_id =document.getElementById('q_id');
			$.ajax({
			type:'post',
			url: '/OpenQA/UpdateDeleteServlet',
			data: {	"solution": 0,
					"q_id": q_id,
					"so":"0",
					"meto":"999",
					"meToo":intMetoo}
		});
		}/*
		else{
			intMetoo--;
			$.ajax({
				type:'post',
				url: '/OpenQA/UpdateDeleteServlet',
				data: {	"solution": 0,
						"q_id": q_id,
						"so":"0",
						"meto":"999",
						"meToo":intMetoo}
			});
		}*/

	}
		let saveCheckbox1 = document.getElementById('meToo');
		saveCheckbox1.addEventListener('change', meToo);

		function wopen(url){
			window.open(url, "window_name", "width=500,height=500,scrollbars=yes");
		}

</script>
</html>