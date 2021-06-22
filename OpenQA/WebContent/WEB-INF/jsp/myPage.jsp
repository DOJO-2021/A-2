<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	..tab_wrap{width:500px; margin:80px auto;}
	input[type="radio"]{display:none;}
	.tab_area{font-size:0; margin:0 10px;}
	.tab_area label{width:150px; margin:0 5px; display:inline-block; padding:12px 0; color:#999; background:#ddd; text-align:center; font-size:13px; cursor:pointer; transition:ease 0.2s opacity;}
	.tab_area label:hover{opacity:0.5;}
	.panel_area{background:#fff;}
	.tab_panel{width:100%; padding:80px 0; display:none;}
	.tab_panel p{font-size:14px; letter-spacing:1px; text-align:center;}
	.close{display:none}
	#tab1:checked ~ .tab_area .tab1_label{background:#fff; color:#000;}
	#tab1:checked ~ .panel_area #panel1{display:block;}
	#tab2:checked ~ .tab_area .tab2_label{background:#fff; color:#000;}
	#tab2:checked ~ .panel_area #panel2{display:block;}
	table, td, th {
	border: 2px #808080 solid;
	}
</style>
<script src=https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js></script>
</head>
<body>
${sessionScope.user.name}さんのマイページ
<h1>過去に登録した投稿</h1>

<div class="tab_wrap">

<input type="radio" id="tab1" name="tab_btn" checked>
<input type="radio" id="tab2" name="tab_btn">

	<div class="tab_area">
	<label class="tab1_label" for="tab1">質問</label>
	<label class="tab2_label" for="tab2">回答</label>
	</div>

	<div class="panel_area">
		<!-- 質問タブ -->
		<div id="panel1" class="tab_panel">
			<c:set var="data" value="0" />
			<table>
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
							<td>
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
							<td>
								<c:out value="From.${value.q_name}" />
							</td>
							<td>
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
								  <form method="GET" action="/OpenQA/RegistServlet?mode=answer" target="_blank" rel="noopener noreferrer">
								  	<input type="hidden" name="mode" value="answer">
								  	<input type="hidden" name="q_id" value="${value.q_id}">
								  	<input type="SUBMIT" value=":ボールペン:">
								  </form>
								</div>
							</td>

						</tr>

						<!-- 質問の詳細を表示 -->
						<tr class="close" id="q_detail${status.index}">

							<td colspan="7">
								<c:out value="タイトル：${value.title}" /><br>
								<c:out value="内容：${value.content}" /><br>
								<img src="/OpenQA/images/${value.q_images}" alt="画像イメージ">
							</td>
						</tr>

						<!-- 編集ボタンを押したら以下のデータをUpdateDeleteServletに送る -->
						<tr class="close" id="q_detail2${status.index}">
							<td>
								<form style="display: inline" method="GET" action="/OpenQA/UpdateDeleteServlet" target="_blank" rel="noopener noreferrer">
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
										<input type="submit" class="button" name="SUBMIT" value="編集">
									</form>
							</td>
								<!-- 削除ボタンを押したら以下のデータをUpdateDeleteServletに送る -->
							<td>
								<form method="POST" action="/OpenQA/UpdateDeleteServlet" name="form">
									<input type="hidden" name="q_id" value="${value.q_id}">
									<input type="hidden" name="meToo" value="${value.metoo}">
									<input type="hidden" name="solution" value="${value.solution}">
									<input type="hidden" name="so" value="0">
									<input type="hidden" name="meto" value="0">
									<input type="hidden" name="mode" value="mypage">
								<input type="submit" class="button" name="SUBMIT" value="質問削除" onclick="delete1();" >
								</form>
							</td>
							<td>
								<!-- 解決ボタン -->
								<input type="checkbox" name="solution" id="solution${status.index}"  onchange="solution('${status.index}','${value.q_id}')" <c:if test="${value.solution == 1}">checked</c:if>>
							</td>
							<td colspan="4">
								<!-- 私もボタン-->
								<input type="checkbox" name="meToo" value="0" id="meToo${status.index}"  onchange="meToo('${status.index}','${value.q_id}','${value.metoo}')">
								<img src="/OpenQA/images/preMeToo.png"><c:out value="${value.metoo}" />
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
									<table>
									<!-- 回答を取り出すfor文 -->
										<c:forEach items="${question}" var="answer">
											<c:if test="${data == answer.a_q_id }">
												<tr>
														<!-- 回答を質問の下に表示 -->
															<!-- user typeが講師だった場合 -->
															<td><c:if test="${sessionScope.user.type==1}">
																<c:out value="${answer.a_name}"/>
																</c:if>
															<!-- user typeが受講者かつ匿名希望の場合 -->
																<c:if test="${sessionScope.user.type==0 and answer.a_anonymity== 1}">
																	匿名
																</c:if>
															<!-- user typeが受講者かつ匿名を希望しない場合 -->
																<c:if test="${sessionScope.user.type==0 and answer.a_anonymity== 0 }">
																	<c:out value="${answer.a_name}"/>
																</c:if>
															</td>
															<td>
																<c:out value="${answer.a_date}" />
															</td>
												</tr>
												<tr>
															<td colspan="2">
																<c:out value="内容：${answer.answer}" />
															<br>
																<img src="/OpenQA/images/${value.a_images}" alt="画像イメージ">
															</td>
													<c:remove var="count" />
													<c:set var="count" value="1" />
												</tr>
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

		<!-- 回答タブ -->
		<div id="panel2" class="tab_panel">
			<c:set var="data" value="0" />
			<table>
			<!-- 各項目 -->
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
				<!-- 自分が回答した質問を表示（詳細を押す前） -->
				<c:forEach items="${answer}" var="value" varStatus="status">

					<!-- q_idが一致する質問を取り出す -->
					<c:if test="${data != value.q_id}">

						<tr>
							<td>
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
							<td>
								<c:out value="From.${value.q_name}" />
							</td>
							<td>
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
								<input type="checkbox" name="a_ch" value="0" onchange="a_disp('${status.index}')" id="a_checkId${status.index}">
								<span class="open" id="a_detail${status.index}">詳細
								</span>
								<span class="close" id="a_hide${status.index}">隠す
								</span>
							</td>
							<!-- status.index→毎ループごとにgoodボタンを隠す -->
							<td>
								<!-- 私もボタン -->
								<div class="open" id="a_good${status.index}">
									<img src="/OpenQA/images/preMeToo.png" alt="私も">
									<c:out value="${value.metoo}" />
								</div>
								<!-- replyボタン -->
								<div class="close" id="a_reply${status.index}">
								  <form method="GET" action="/OpenQA/RegistServlet?mode=answer" target="_blank" rel="noopener noreferrer">
								  	<input type="hidden" name="mode" value="answer">
								  	<input type="hidden" name="q_id" value="${value.q_id}">
								  	<input type="SUBMIT" value=":ボールペン:">
								  </form>
								</div>
							</td>+
						</tr>

						<!-- 自分が回答した質問の詳細を表示 -->
						<tr class="close" id="a_q_detail${status.index}">
							<td colspan="7">
								<c:out value="タイトル：${value.title}" /><br>
								<c:out value="内容：${value.content}" /><br>
								<img src="/OpenQA/images/${value.q_images}" alt="画像イメージ"><br>
								<!-- 私もボタン-->
								<input type="checkbox" name="meToo" value="0" id="meToo${status.index}"  onchange="meToo('${status.index}','${value.q_id}','${value.metoo}')">
								<img src="/OpenQA/images/preMeToo.png"><c:out value="${value.metoo}" />
							</td>
						</tr>
					<c:set var="count" value="0" />
					</c:if>

					<c:remove var="data" />
					<c:set var="data" value="${value.q_id}" />
					<c:if test="${data == value.q_id}">
						<c:if test="${count == 0 }">
							<tr class="close" id="a_answer${status.index}">
								<td colspan="7">
									<table>
									<!-- 回答を取り出すfor文 -->
										<c:forEach items="${answer}" var="answer">
											<c:if test="${data == answer.a_q_id }">
												<!-- 回答を質問の下に表示 -->
													<!-- user typeが講師だった場合 -->
													<tr>
														<td><c:if test="${sessionScope.user.type==1}">
															<c:out value="${answer.a_name}"/>
															</c:if>
														<!-- user typeが受講者かつ匿名希望の場合 -->
															<c:if test="${sessionScope.user.type==0 and answer.a_anonymity== 1}">
																匿名
															</c:if>
														<!-- user typeが受講者かつ匿名を希望しない場合 -->
															<c:if test="${sessionScope.user.type==0 and answer.a_anonymity== 0 }">
																<c:out value="${answer.a_name}"/>
															</c:if>
														</td>
														<td>
															<c:out value="${answer.a_date}" />
														</td>
													</tr>
													<tr>
														<td colspan="2">
																<c:out value="内容：${answer.answer}" />
															<br>
																<img src="/OpenQA/images/${value.a_images}" alt="画像イメージ">
															<br>
													</tr>

													<tr>
														<!-- 編集ボタンを押したら以下のデータをUpdateDeleteServletに送る -->
														<td>
															<form style="display: inline" method="GET" action="/OpenQA/UpdateDeleteServlet" target="_blank" rel="noopener noreferrer">
																	<input type="hidden" name="mode" value="answer">
																	<input type="hidden" name="a_id" value="${value.a_id}">
																	<input type="hidden" name="anonymity" value="${value.a_anonymity}">
																	<input type="hidden" name="content" value="${value.answer}">
																	<input type="hidden" name="images" value="${value.a_images}">
																	<input type="submit" class="button" name="SUBMIT" value="編集">
															</form>
														</td>
														<!-- 削除ボタンを押したら以下のデータをUpdateDeleteServletに送る -->
														<td>
															<form method="POST" action="/OpenQA/UpdateDeleteServlet" name="form">
																	<input type="hidden" name="a_id" value="${value.a_id}">
																	<input type="hidden" name="mode" value="mypage2">
																	<input type="submit" class="button" name="SUBMIT" value="回答削除" onclick="delete1();" >
															</form>
														</td>
													</tr>
											</c:if>
											<c:remove var="count" />
											<c:set var="count" value="1" />
										</c:forEach>
									</table>
								</td>
							</tr>
						</c:if>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
</body>
<!--
hide=隠す（close）
q_detail=質問の詳細(close)
answer=回答(close)
good=私も(open)
detail=(open)
-->


<script>
'use strict'
//チェックボックスのチェックが動作したら動く（質問タブの詳細）
function disp(indexNo){
	//チェックボックスの状態を取得
	var ch =document.getElementById('checkId'+indexNo);
	//隠している部分の情報を取得
		var hide =document.getElementById('hide'+indexNo);
		var q_detail =document.getElementById('q_detail'+indexNo);
		var q_detail2 =document.getElementById('q_detail2'+indexNo);
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
			q_detail2.setAttribute('class','open');
			answer.setAttribute('class','open');
			good.setAttribute('class','close');
			detail.setAttribute('class','close');
			reply.setAttribute('class','open');
		}else{
			//openを閉じる
			hide.setAttribute('class','close');
			q_detail.setAttribute('class','close');
			q_detail2.setAttribute('class','close');
			answer.setAttribute('class','close');
			good.setAttribute('class','open');
			detail.setAttribute('class','open');
			reply.setAttribute('class','close');
		}
}
//チェックボックスのチェックが動作したら動く（回答タブの詳細）
function a_disp(indexNo){
	//チェックボックスの状態を取得
	var a_ch =document.getElementById('a_checkId'+indexNo);
	//隠している部分の情報を取得
	var a_hide =document.getElementById('a_hide'+indexNo);
	var a_q_detail =document.getElementById('a_q_detail'+indexNo);
	var a_answer =document.getElementById('a_answer'+indexNo);
	var a_reply =document.getElementById('a_reply'+indexNo);
	//開いている部分の情報を取得
	var a_good =document.getElementById('a_good'+indexNo);
	var a_detail =document.getElementById('a_detail'+indexNo);
	//もし、チェックボックスにチェックがついたら
	if(a_ch.checked){
		//closeを開く
		a_hide.setAttribute('class','open');
		a_q_detail.setAttribute('class','open');
		a_answer.setAttribute('class','open');
		a_good.setAttribute('class','close');
		a_detail.setAttribute('class','close');
		a_reply.setAttribute('class','open');
	}else{
		//openを閉じる
		a_hide.setAttribute('class','close');
		a_q_detail.setAttribute('class','close');
		a_answer.setAttribute('class','close');
		a_good.setAttribute('class','open');
		a_detail.setAttribute('class','open');
		a_reply.setAttribute('class','close');
	}
}

// 削除確認アラート
function delete1() {
	if(confirm("本当に削除してよろしいですか？")) {
		alert("削除しました。");
		return true;
	} else {
		alert("キャンセルしました。");
		return false;
	}
}


//solution Ajax(kari)
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
</script>

</html>