package com.st.smartrash.trash.model.vo;

import java.sql.Date;

public class Trash implements java.io.Serializable {

	private static final long serialVersionUID = -2168193368861104940L;
	
	private int trash_no; // 쓰레기 번호
	private int user_no;	// 유저 번호
	private int category_no;	// 카테고리 번호
	private String trash_path;	// 쓰레기 이미지 경로
	private Date trash_date;	// 쓰레기 올린날짜
	private char report;	// 신고 여부

	public Trash() {
		super();
	}

	public Trash(int trash_no, int user_no, int category_no, String trash_path, Date trash_date, char report) {
		super();
		this.trash_no = trash_no;
		this.user_no = user_no;
		this.category_no = category_no;
		this.trash_path = trash_path;
		this.trash_date = trash_date;
		this.report = report;
	}

	public int getTrash_no() {
		return trash_no;
	}

	public void setTrash_no(int trash_no) {
		this.trash_no = trash_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getCategory_no() {
		return category_no;
	}

	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}

	public String getTrash_path() {
		return trash_path;
	}

	public void setTrash_path(String trash_path) {
		this.trash_path = trash_path;
	}

	public Date getTrash_date() {
		return trash_date;
	}

	public void setTrash_date(Date trash_date) {
		this.trash_date = trash_date;
	}

	public char getReport() {
		return report;
	}

	public void setReport(char report) {
		this.report = report;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Trash [trash_no=" + trash_no + ", user_no=" + user_no + ", category_no=" + category_no + ", trash_path="
				+ trash_path + ", trash_date=" + trash_date + ", report=" + report + "]";
	}

	public void setOriginal_filepath(String fileName) {
		// TODO Auto-generated method stub
		
	}
	


	public void setRename_filepath(String renameFileName) {
		// TODO Auto-generated method stub
		
	}

}
