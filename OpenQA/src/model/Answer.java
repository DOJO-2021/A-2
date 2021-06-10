package model;

import java.io.Serializable;
import java.util.Date;

public class Answer implements Serializable {
	// JavaBeansの作成

	// フィールドの作成
	// DBのanswerテーブルと同じでいいの？？
	private String a_id;
	private String id;
	private int anonymity; // 0か1だからintでいいんだよね？？
	private Date date;
	private String answer;
	private String images; // パスを格納するからStringでいいんだよね？？
	private String q_id;

	// 引数があるコンストラクタ
	public Answer(String a_id, String id, int anonymity, Date date, String answer, String images, String q_id) {
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
		this.a_id = "";
		this.id = "";
		this.anonymity = 0;
		this.date = null;
		this.answer = "";
		this.images = "";
		this.q_id = "";
	}

	// getter/setterの生成
	public String getA_id() {
		return a_id;
	}

	public void setA_id(String a_id) {
		this.a_id = a_id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getAnonymity() {
		return anonymity;
	}

	public void setAnonymity(int anonymity) {
		this.anonymity = anonymity;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
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

	public String getQ_id() {
		return q_id;
	}

	public void setQ_id(String q_id) {
		this.q_id = q_id;
	}



}
