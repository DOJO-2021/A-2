package model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Almighty implements Serializable {
	//question
	private String q_id;
	private int to;
	private String q_userId;
	private String q_name;
	private int q_anonymity;
	private String b_category;
	private String s_category;
	private Timestamp q_date;
	private String title;
	private String content;
	private int solution;
	private int metoo;
	private String q_images;
	//answer
	private String a_id;
	private String a_userId;
	private String a_name;
	private int a_anonymity;
	private Timestamp a_date;
	private String answer;
	private String a_images;
	private String a_q_id;


	public String getA_q_id() {
		return a_q_id;
	}
	public void setA_q_id(String a_q_id) {
		this.a_q_id = a_q_id;
	}
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
	public String getQ_userId() {
		return q_userId;
	}
	public void setQ_userId(String q_userId) {
		this.q_userId = q_userId;
	}
	public String getQ_name() {
		return q_name;
	}
	public void setQ_name(String q_name) {
		this.q_name = q_name;
	}
	public int getQ_anonymity() {
		return q_anonymity;
	}
	public void setQ_anonymity(int q_anonymity) {
		this.q_anonymity = q_anonymity;
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
	public Timestamp getQ_date() {
		return q_date;
	}
	public void setQ_date(Timestamp q_date) {
		this.q_date = q_date;
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
	public String getQ_images() {
		return q_images;
	}
	public void setQ_images(String q_images) {
		this.q_images = q_images;
	}
	public String getA_id() {
		return a_id;
	}
	public void setA_id(String a_id) {
		this.a_id = a_id;
	}
	public String getA_userId() {
		return a_userId;
	}
	public void setA_userId(String a_userId) {
		this.a_userId = a_userId;
	}
	public String getA_name() {
		return a_name;
	}
	public void setA_name(String a_name) {
		this.a_name = a_name;
	}
	public int getA_anonymity() {
		return a_anonymity;
	}
	public void setA_anonymity(int a_anonymity) {
		this.a_anonymity = a_anonymity;
	}
	public Timestamp getA_date() {
		return a_date;
	}
	public void setA_date(Timestamp a_date) {
		this.a_date = a_date;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getA_images() {
		return a_images;
	}
	public void setA_images(String a_images) {
		this.a_images = a_images;
	}



}