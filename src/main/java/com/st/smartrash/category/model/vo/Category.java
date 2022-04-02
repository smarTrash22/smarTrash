package com.st.smartrash.category.model.vo;

public class Category implements java.io.Serializable {
	private static final long serialVersionUID = 1566377265540583572L;
	
	private int category_no;
	private String category_name;
	private String category_name_kor;
	private String category_content;
	private String category_tip;
	
	public Category() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Category(int category_no, String category_name, String category_content, String category_tip) {
		super();
		this.category_no = category_no;
		this.category_name = category_name;
		this.category_content = category_content;
		this.category_tip = category_tip;
	}

	public int getCategory_no() {
		return category_no;
	}

	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public String getCategory_content() {
		return category_content;
	}

	public void setCategory_content(String category_content) {
		this.category_content = category_content;
	}

	public String getCategory_tip() {
		return category_tip;
	}

	public void setCategory_tip(String category_tip) {
		this.category_tip = category_tip;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCategory_name_kor() {
		return category_name_kor;
	}

	public void setCategory_name_kor(String category_name_kor) {
		this.category_name_kor = category_name_kor;
	}

	@Override
	public String toString() {
		return "Category [category_no=" + category_no + ", category_name=" + category_name + ", category_content="
				+ category_content + ", category_tip=" + category_tip + "]";
	}
}
