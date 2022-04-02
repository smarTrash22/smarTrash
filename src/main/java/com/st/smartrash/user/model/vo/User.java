package com.st.smartrash.user.model.vo;

import java.sql.Date;

public class User implements java.io.Serializable {
	private static final long serialVersionUID = -4815154232763641388L;
	
	private int user_no;
	private String user_name;
	private String user_email;
	private Date user_date;
	private char user_admin;
	
	public User() {}

	public User(int user_no, String user_name, String user_email, Date user_date, char user_admin) {
		super();
		this.user_no = user_no;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_date = user_date;
		this.user_admin = user_admin;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public Date getUser_date() {
		return user_date;
	}

	public void setUser_date(Date user_date) {
		this.user_date = user_date;
	}

	public char getUser_admin() {
		return user_admin;
	}

	public void setUser_admin(char user_admin) {
		this.user_admin = user_admin;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "User [user_no=" + user_no + ", user_name=" + user_name + ", user_email=" + user_email + ", user_date="
				+ user_date + ", user_admin=" + user_admin + "]";
	}
	
}
