package com.st.smartrash;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String mainViewForward() {
		return "common/main";  // 내보낼 뷰파일명 리턴
	}
	
	@RequestMapping(value = "about.do", method = RequestMethod.GET)
	public String aboutViewForward() {
		return "common/about";
	}
	
	@RequestMapping(value = "blog-home.do", method = RequestMethod.GET)
	public String blog_homeViewForward() {
		return "common/blog-home";
	}
	
	@RequestMapping(value = "blog-post.do", method = RequestMethod.GET)
	public String blog_postViewForward() {
		return "common/blog-post";
	}
	
	@RequestMapping(value = "contact.do", method = RequestMethod.GET)
	public String contactViewForward() {
		return "common/contact";
	}
	
	@RequestMapping(value = "faq.do", method = RequestMethod.GET)
	public String faqViewForward() {
		return "common/faq";
	}
	
	@RequestMapping(value = "portfolio-item.do", method = RequestMethod.GET)
	public String portfolio_itemViewForward() {
		return "common/portfolio-item";
	}
	
	@RequestMapping(value = "portfolio-overview.do", method = RequestMethod.GET)
	public String portfolio_overviewViewForward() {
		return "common/portfolio-overview";
	}
	
	
	@RequestMapping(value = "trashInsert.do", method = RequestMethod.GET)
	public String trashInsertViewForward() {
		return "trash/trashInsert";
	}
	
	@RequestMapping(value = "trashMenubar.do", method = RequestMethod.GET)
	public String trashMenubarViewForward() {
		return "trash/trashMenubar";
	}
	
	@RequestMapping(value = "trashListView.do", method = RequestMethod.GET)
	public String trashListViewViewForward() {
		return "trash/trashListView";
	}
}
