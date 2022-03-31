package com.st.smartrash.category.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.category.model.vo.Category;

@Repository("categoryDao")
public class CategoryDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public ArrayList<Category> selectList() {
		List<Category> list = session.selectList("categoryMapper.selectList");
		return (ArrayList<Category>)list;
	}
	
	public Category selectCategory(int category_no) {
		return session.selectOne("categoryMapper.selectCategory", category_no);
	}
	
	public int selectListCount() {
		return session.selectOne("categoryMapper.getListCount");
	}
}
