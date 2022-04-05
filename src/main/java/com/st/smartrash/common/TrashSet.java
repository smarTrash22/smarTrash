package com.st.smartrash.common;

public class TrashSet implements java.io.Serializable {

	private static final long serialVersionUID = 8862469193930915890L;

	private String trash_path;
	private String category_content;
	private String category_tip;

	public TrashSet() {
		super();
	}

	public TrashSet(String trash_path, String category_content, String category_tip) {
		super();
		this.trash_path = trash_path;
		this.category_content = category_content;
		this.category_tip = category_tip;
	}

	public String getTrash_path() {
		return trash_path;
	}

	public void setTrash_path(String trash_path) {
		this.trash_path = trash_path;
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

	@Override
	public String toString() {
		return "TrashSet [trash_path=" + trash_path + ", category_content=" + category_content + ", category_tip="
				+ category_tip + "]";
	}

}
