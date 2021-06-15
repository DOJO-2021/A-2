package model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Almighty implements Serializable {
	//question
	private String q_id;
	private int to;
	private String id;
	private int anonymity;
	private String b_category;
	private String s_category;
	private Timestamp date;
	private String title;
	private String content;
	private int solution;
	private int metoo;
	private String images;
	//answer
	private String a_id;
	private String answer;
	//user
	private String pw;
	private String name;
	private int type;
	private String ins_pw;




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
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
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
	public String getA_id() {
		return a_id;
	}
	public void setA_id(String a_id) {
		this.a_id = a_id;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
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