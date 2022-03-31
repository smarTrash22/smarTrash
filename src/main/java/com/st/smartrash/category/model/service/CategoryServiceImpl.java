package com.st.smartrash.category.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;

import com.st.smartrash.category.model.dao.CategoryDao;
import com.st.smartrash.category.model.vo.Category;

public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Override
	public ArrayList<Category> selectList() {
		return categoryDao.selectList();
	}

	@Override
	public Category selectCategory(int category_no) {
		return categoryDao.selectCategory(category_no);
	}

	@Override
	public int selectListCount() {
		return categoryDao.selectListCount();
	}

}
