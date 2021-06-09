package model;

import java.io.Serializable;

public class User implements Serializable {
	// JavaBeansの作成

	// フィールドの作成
	private String id;
	private String pw;
	private String name;
	private int type; // データ型何？
	private String ins_pw;

	// 引数があるコンストラクタ
	public User(String id, String pw, String name, int type, String ins_pw) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.type = type;
		this.ins_pw = ins_pw;
	}

	// 引数がないコンストラクタ
	public User() {
		super();
		this.id = "";
		this.pw = "";
		this.name = "";
		this.type = 0; // デフォルト値設定
		this.ins_pw = "";
	}

	// getter/setterの作成（スコープに入れるとき）
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getIns_pw() {
		return ins_pw;
	}

	public void setIns_pw(String ins_pw) {
		this.ins_pw = ins_pw;
	}

}
