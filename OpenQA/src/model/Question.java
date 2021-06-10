package model;

import java.io.Serializable;
import java.util.Date;

public class Question implements Serializable {
	private String q_id;
	private int to;
	private String id;
	private int anonymity;
	private String b_category;
	private String s_category;
	private Date date;
	private String title;
	private String content;
	private int solution;
	private int metoo;
	private String images;


	//コンストラクタ
	public Question(String q_id, int to, String id, int anonymity, String b_category, String s_category, Date date,
			String title, String content, int solution, int metoo, String images) {
		super();
		this.q_id = q_id;
		this.to = to;
		this.id = id;
		this.anonymity = anonymity;
		this.b_category = b_category;
		this.s_category = s_category;
		this.date = date;
		this.title = title;
		this.content = content;
		this.solution = solution;
		this.metoo = metoo;
		this.images = images;
	}

	public Question() {
	}

	//setter getter
	public String getQ_id() {
		return q_id;
	}
	public void setQ_id(String q_id) {
		this.q_id = q_id;
	}
	public int getTo() {
		return to;
	}
	public void setTo(int to) {
		this.to = to;
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
	public String getB_category() {
		return b_category;
	}
	public void setB_category(String b_category) {
		this.b_category = b_category;
	}
	public String getS_category() {
		return s_category;
	}
	public void setS_category(String s_category) {
		this.s_category = s_category;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getSolution() {
		return solution;
	}
	public void setSolution(int solution) {
		this.solution = solution;
	}
	public int getMetoo() {
		return metoo;
	}
	public void setMetoo(int metoo) {
		this.metoo = metoo;
	}
	public String getImages() {
		return images;
	}
	public void setImages(String images) {
		this.images = images;
	}


}
