package com.st.smartrash.board.model.vo;

import java.sql.Date;

public class Board {
	private int board_no;
	private int board_ref;
	private int trash_no;
	private String board_content;
	private String hashtag;
	private int board_readcount;
	private java.sql.Date board_date;
	private String trash_path;
	private String user_name;
	
	public Board() {
		super();
	}

	public Board(int board_no, int board_ref, int trash_no, String board_content, String hashtag, int board_readcount,
			Date board_date) {
		super();
		this.board_no = board_no;
		this.board_ref = board_ref;
		this.trash_no = trash_no;
		this.board_content = board_content;
		this.hashtag = hashtag;
		this.board_readcount = board_readcount;
		this.board_date = board_date;
	}
	
	public Board(int board_no, int board_ref, int trash_no, String board_content, String hashtag, int board_readcount,
			Date board_date, String trash_path, String user_name) {
		super();
		this.board_no = board_no;
		this.board_ref = board_ref;
		this.trash_no = trash_no;
		this.board_content = board_content;
		this.hashtag = hashtag;
		this.board_readcount = board_readcount;
		this.board_date = board_date;
		this.trash_path = trash_path;
		this.user_name = user_name;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public int getBoard_ref() {
		return board_ref;
	}

	public void setBoard_ref(int board_ref) {
		this.board_ref = board_ref;
	}

	public int getTrash_no() {
		return trash_no;
	}

	public void setTrash_no(int trash_no) {
		this.trash_no = trash_no;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getHashtag() {
		return hashtag;
	}

	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}

	public int getBoard_readcount() {
		return board_readcount;
	}

	public void setBoard_readcount(int board_readcount) {
		this.board_readcount = board_readcount;
	}

	public java.sql.Date getBoard_date() {
		return board_date;
	}

	public void setBoard_date(java.sql.Date board_date) {
		this.board_date = board_date;
	}

	public String getTrash_path() {
		return trash_path;
	}

	public void setTrash_path(String trash_path) {
		this.trash_path = trash_path;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	@Override
	public String toString() {
		return "Board [board_no=" + board_no + ", board_ref=" + board_ref + ", trash_no=" + trash_no
				+ ", board_content=" + board_content + ", hashtag=" + hashtag + ", board_readcount=" + board_readcount
				+ ", board_date=" + board_date + ", trash_path=" + trash_path + ", user_name=" + user_name + "]";
	}
}
