package com.st.smartrash.common;

public class CategoryTranslation {
	public String categoryTranslation(String category_name) {
		switch(category_name) {
		case "can": return "캔";
		case "fluorescent_light": return "형광등";
		case "glass": return "유리";
		case "paper": return "종이";
		case "plastic": return "플라스틱";
		case "polystyrene": return "스티로폼";
		case "vinyl": return "비닐";
		default: return category_name;
		}
	}
}
