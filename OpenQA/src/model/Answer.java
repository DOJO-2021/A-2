package model;

import java.io.Serializable;

public class Answer implements Serializable {
	// JavaBeansの作成

	// フィールドの作成
	// DBのanswerテーブルと同じでいいの？？
	private int a_id;
	private int id;
	private int anonymity; // 0か1だからintでいいんだよね？？
	private String date;
	private String answer;
	private String images; // パスを格納するからStringでいいんだよね？？
	private int q_id;

	// 引数があるコンストラクタ
	public Answer(int a_id, int id, int anonymity, String date, String answer, String images, int q_id) {
		super();
		this.a_id = a_id;
		this.id = id;
		this.anonymity = anonymity;
		this.date = date;
		this.answer = answer;
		this.images = images;
		this.q_id = q_id;
	}

	// 引数がないコンストラクタ
	public Answer() {
		super();
		this.a_id = 0;
		this.id = 0;
		this.anonymity = 0;
		this.date = "";
		this.answer = "";
		this.images = "";
		this.q_id = 0;
	}

	// getter/setterの作成（スコープに入れるとき）
	public int getA_id() {
		return a_id;
	}

	public void setA_id(int a_id) {
		this.a_id = a_id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAnonymity() {
		return anonymity;
	}

	public void setAnonymity(int anonymity) {
		this.anonymity = anonymity;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}

	public int getQ_id() {
		return q_id;
	}

	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}

}
