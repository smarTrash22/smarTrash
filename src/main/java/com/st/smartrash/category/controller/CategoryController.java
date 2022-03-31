package com.st.smartrash.category.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.st.smartrash.category.model.service.CategoryService;
import com.st.smartrash.category.model.vo.Category;

@Controller
public class CategoryController {
	private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);
	
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping("category.do")
	public String categoryList(Model model) {
		ArrayList<Category> list = categoryService.selectList();
		model.addAttribute("list", list);
		return "category/categoryList";
	}
	
	@RequestMapping("categoryDetail.do")
	public String categoryDetail(@RequestParam("category_no") int category_no, Model model, HttpSession session) {
		Category category = categoryService.selectCategory(category_no);
		
		if(category != null) {
			model.addAttribute("category", category);
			return "category/categoryDetail";
		} else {
			model.addAttribute("message", "카테고리 불러오기 실패");
			return "common/error";
		}
	}
}
