'use strict'

//ここから変数宣言-----------------------------------------------------------------

	//配列の宣言
	let s_categoryArray = new Array();
	//配列の初期値の設定
	s_categoryArray[''] = new Array('小カテゴリー');

	//ひとつめの配列が選択された後、選択肢によって下記のどれかが設定される
	s_categoryArray['パーソナルスキル'] = new Array('ビジネスマナー', 'ビジネス文書', 'Word', 'Excel', 'タイピング');
	s_categoryArray['IT基礎'] = new Array('プログラミングの基本', 'アルゴリズム', 'ネットワークの基本', 'HTML', 'CSS', 'JavaScript', 'データベース', 'SQL');
	s_categoryArray['java基礎'] = new Array('Javaの基本', 'オブジェクト指向', 'Servlet', 'JSP','DAO', 'Javaドリル', 'SQLドリル', '名刺管理アプリ');
	s_categoryArray['その他'] = new Array('機器トラブル');


	//ここから関数-----------------------------------------------------------------
	//ひとつめの配列の値が変更されたときに動く関数
	document.getElementsByName('b_category')[0].onchange = function () {
		let input = document.getElementsByName('b_category');
		let b_category = input.children.getAttribute('value');
		let elm = document.getElementsByName('s_category')[0];
		elm.options.length = 0;
		for (let i = 0; i < s_categoryArray[b_category].length; i++) {
			let op = document.createElement('option');
			op.value = s_categoryArray[b_category][i];
			op.textContent = s_categoryArray[b_category][i];
			elm.appendChild(op);
		}
	};

	//JSPの画面が読み込まれたときに実行される関数
	window.onload = function () {
	document.getElementsByName('b_category')[0].onchange();
	};