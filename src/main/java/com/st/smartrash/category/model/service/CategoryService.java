package com.st.smartrash.category.model.service;

import java.util.ArrayList;

import com.st.smartrash.category.model.vo.Category;

public interface CategoryService {
	ArrayList<Category> selectList();
	Category selectCategory(int category_no);
	int selectListCount();
	Category selectSearchName(String category_name);
}
