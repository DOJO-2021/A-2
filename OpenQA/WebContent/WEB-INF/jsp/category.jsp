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
	#tab0:checked ~ .tab_area .tab0_label{background:#fff; color:#000;}
	#tab0:checked ~ .panel_area #panel0{display:block;}
	#tab1:checked ~ .tab_area .tab1_label{background:#fff; color:#000;}
	#tab1:checked ~ .panel_area #panel1{display:block;}
	#tab2:checked ~ .tab_area .tab2_label{background:#fff; color:#000;}
	#tab2:checked ~ .panel_area #panel2{display:block;}
	#tab3:checked ~ .tab_area .tab3_label{background:#fff; color:#000;}
	#tab3:checked ~ .panel_area #panel3{display:block;}
	#tab4:checked ~ .tab_area .tab4_label{background:#fff; color:#000;}
	#tab4:checked ~ .panel_area #panel4{display:block;}
	#tab5:checked ~ .tab_area .tab5_label{background:#fff; color:#000;}
	#tab5:checked ~ .panel_area #panel5{display:block;}
	#tab6:checked ~ .tab_area .tab6_label{background:#fff; color:#000;}
	#tab6:checked ~ .panel_area #panel6{display:block;}
	#tab7:checked ~ .tab_area .tab7_label{background:#fff; color:#000;}
	#tab7:checked ~ .panel_area #panel7{display:block;}

	table, td, th {
	border: 2px #808080 solid;
	}
</style>
<script src=https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js></script>
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
		</select> <input type="submit" name="SUBMIT" value="カテゴリー検索">
	</form>



	<c:if test="${list != null}">
		<c:set var="data" value="0" />
		<div class="tab_wrap">

		<!-- panelareaのなかにtabareaがあるからおかしい？ -->
		<c:forEach items="${list}" var="s_list" varStatus="listSt">
			<input type="radio" id="tab${listSt.index}" name="tab_btn">
			<span class="tab_area">
				<label class="tab${listSt.index}_label" for="tab${listSt.index}">${s_list.get(0).s_category}</label>
			</span>
		</c:forEach>


		<div class="panel_area">
		<c:forEach items="${list}" var="s_list" varStatus="listSt">




		  <div id="panel${listSt.index}" class="tab_panel">
			<table>
				<tr>
					<td>宛先</td>
					<td>質問者名</td>
					<td>質問のタイトル</td>
					<td>カテゴリー</td>
					<td>日付</td>
				</tr>
				<!-- 自分の質問を表示（詳細を押す前） -->
				<c:forEach items="${s_list}" var="value" varStatus="status">
					<!-- q_idが一致する質問を取り出す -->
					<c:if test="${data != value.q_id }">
						<tr>
							<td><c:if test="${value.to == 0}">
									<c:out value="To.全員" />
								</c:if> <c:if test="${value.to == 1}">
									<c:out value="To.講師" />
								</c:if> <c:if test="${value.to == 2}">
									<c:out value="To.受講者" />
								</c:if></td>
							<td><c:out value="From.${value.q_name}" /></td>
							<td><c:out value="${value.title}" /></td>
							<td><c:out value="${value.b_category}" /> <c:out
									value="ｰ${value.s_category}" /></td>
							<td><c:out value="${value.q_date}" /></td>
							<!--チェックボックス -->
							<td><input type="checkbox" name="ch${listSt.index}" value="0" onchange="disp('${status.index}', '${listSt.index}')" id="checkId${listSt.index}${status.index}">
								<span class="open" id="detail${listSt.index}${status.index}"> 詳細 </span> <span
								class="close" id="hide${listSt.index}${status.index}"> 隠す </span></td>
							<!-- status.index→毎ループごとにgoodボタンを隠す -->
							<td>
								<!-- 私もボタン -->
								<div class="open" id="good${listSt.index}${status.index}">
									<img src="/OpenQA/images/preMeToo.png" alt="私も">
									<c:out value="${value.metoo}" />
								</div> <!-- replyボタン -->
								<div class="close" id="reply${listSt.index}${status.index}">
									<form method="GET" action="/OpenQA/RegistServlet?mode=answer"
										target="_blank" rel="noopener noreferrer">
										<input type="hidden" name="mode" value="answer"> <input
											type="hidden" name="q_id" value="${value.q_id}"> <input
											type="SUBMIT" value=":ボールペン:">
									</form>
								</div>
							</td>
						</tr>

						<!-- 質問の詳細を表示 -->
						<c:if test="${sessionScope.user.id == value.q_userId}">
						<tr class="close" id="q_detail${listSt.index}${status.index}">

							<td colspan="7">
								<c:out value="タイトル：${value.title}" /><br>
								<c:out value="内容：${value.content}" /><br>
								<img src="/OpenQA/images/${value.q_images}" alt="画像イメージ"><br>
								<!-- 編集ボタンを押したら以下のデータをUpdateDeleteServletに送る -->
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
								<!-- 削除ボタンを押したら以下のデータをUpdateDeleteServletに送る -->
								<form method="POST" action="/OpenQA/UpdateDeleteServlet" name="form">
									<input type="hidden" name="q_id" value="${value.q_id}">
									<input type="hidden" name="meToo" value="${value.metoo}">
									<input type="hidden" name="solution" value="${value.solution}">
									<input type="hidden" name="so" value="0">
									<input type="hidden" name="meto" value="0">
									<input type="hidden" name="mode" value="category">
								<input type="submit" class="button" name="SUBMIT" value="質問削除" onclick="delete1();" >
								</form>
								<!-- 解決ボタン -->
								<input type="checkbox" name="solution" id="solution${listSt.index}${status.index}"  onchange="solution('${status.index}','${value.q_id}', '${listSt.index}')" <c:if test="${value.solution == 1}">checked</c:if>>
								<!-- 私もボタン-->
								<input type="checkbox" name="meToo" value="0" id="meToo${listSt.index}${status.index}"  onchange="meToo('${status.index}','${value.q_id}','${value.metoo}', '${listSt.index}')">
								<img src="/OpenQA/images/preMeToo.png"><c:out value="${value.metoo}" />
							</td>
						</tr>
						</c:if>
						<c:set var="count" value="0" />
					</c:if>
					<c:remove var="data" />
					<c:set var="data" value="${value.q_id}" />
					<c:if test="${data == value.q_id}">
						<c:if test="${count == 0 }">
							<tr class="close" id="answer${listSt.index}${status.index}">
								<td colspan="7">
									<table>
										<!-- 回答を取り出すfor文 -->
										<c:forEach items="${question}" var="answer">
											<c:if test="${data == answer.a_q_id }">
												<tr>
													<!-- 回答を質問の下に表示 -->
													<!-- user typeが講師だった場合 -->
													<td><c:if test="${sessionScope.user.type==1}">
															<c:out value="${answer.a_name}" />
														</c:if> <!-- user typeが受講者かつ匿名希望の場合 --> <c:if
															test="${sessionScope.user.type==0 and answer.a_anonymity== 1}">
																	匿名
																</c:if> <!-- user typeが受講者かつ匿名を希望しない場合 --> <c:if
															test="${sessionScope.user.type==0 and answer.a_anonymity== 0 }">
															<c:out value="${answer.a_name}" />
														</c:if></td>
													<td><c:out value="${answer.a_date}" /></td>
												</tr>
												<tr>
													<td colspan="2"><c:out value="内容：${answer.answer}" />
														<br> <img src="/OpenQA/images/${value.a_images}"
														alt="画像イメージ"></td>
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
		</c:forEach>
		</div>
		</div>
	</c:if>
</body>

<script>
'use strict'
//チェックボックスのチェックが動作したら動く（質問タブの詳細）
function disp(indexNo, stIndexNo){
	//チェックボックスの状態を取得
	var ch =document.getElementById('checkId'+ stIndexNo +indexNo);
	//隠している部分の情報を取得
		var hide =document.getElementById('hide'+ stIndexNo +indexNo);
		var q_detail =document.getElementById('q_detail'+ stIndexNo +indexNo);
		var answer =document.getElementById('answer'+ stIndexNo +indexNo);
	//開いている部分の情報を取得
		var good =document.getElementById('good'+ stIndexNo +indexNo);
		var detail =document.getElementById('detail'+ stIndexNo +indexNo);
		var reply =document.getElementById('reply'+ stIndexNo +indexNo);
	//もし、チェックボックスにチェックがついたら
		if(ch.checked){
			//closeを開く
			hide.setAttribute('class','open');
			q_detail.setAttribute('class','open');
			answer.setAttribute('class','open');
			good.setAttribute('class','close');
			detail.setAttribute('class','close');
			reply.setAttribute('class','open');
		}else{
			//openを閉じる
			hide.setAttribute('class','close');
			q_detail.setAttribute('class','close');
			answer.setAttribute('class','close');
			good.setAttribute('class','open');
			detail.setAttribute('class','open');
			reply.setAttribute('class','close');
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
function solution(indexNo, q_id, stIndexNo){
	var solution =document.getElementById('solution' + stIndexNo + indexNo);
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
//	let saveCheckbox = document.getElementById('solution');
//	saveCheckbox.addEventListener('change', solution);

	//metooは1回押したら1増える
	function meToo(indexNo, q_id, metoo, stIndexNo){
		var intMetoo = parseInt(metoo);
		var meToo =document.getElementById('meToo' + stIndexNo + indexNo);
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
//		let saveCheckbox1 = document.getElementById('meToo');
//		saveCheckbox1.addEventListener('change', meToo);
</script>


</html>