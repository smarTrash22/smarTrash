package com.st.smartrash.notice.model.vo;

import java.sql.Date;

public class Notice implements java.io.Serializable {
	private static final long serialVersionUID = 1365978153616705231L;

	private int notice_no;
	private String notice_title;
	private java.sql.Date notice_date;
	private String notice_writer;
	
	
	
	public Notice(int notice_no, String notice_title, Date notice_date, String notice_writer) {
		super();
		this.notice_no = notice_no;
		this.notice_title = notice_title;
		this.notice_date = notice_date;
		this.notice_writer = notice_writer;
	}
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public java.sql.Date getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(java.sql.Date notice_date) {
		this.notice_date = notice_date;
	}
	public String getNotice_writer() {
		return notice_writer;
	}
	public void setNotice_writer(String notice_writer) {
		this.notice_writer = notice_writer;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Notice [notice_no=" + notice_no + ", notice_title=" + notice_title + ", notice_date=" + notice_date
				+ ", notice_writer=" + notice_writer + "]";
	}

}
