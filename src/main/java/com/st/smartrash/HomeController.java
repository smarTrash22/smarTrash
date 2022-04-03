package com.st.smartrash;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
	
	@RequestMapping(value = "uploadFile.do", method = RequestMethod.POST)
	@ResponseBody
	public String uploadFile(HttpServletRequest request, Model model,
	    @RequestParam("uploadfile") MultipartFile uploadfile) {
	  
	  try {
		String savePath = request.getSession().getServletContext().getRealPath("resources/trash_upfiles");
		String fileName = uploadfile.getOriginalFilename();
		// 이름바꾸기 처리 : 년월일시분초.확장자
		if(fileName != null && fileName.length() > 0) {
			// 바꿀 파일명에 대한 문자열 만들기
			// 공지글 등록 요청시점의 날짜정보를 이용함
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			// 변경할 파일이름 만들기
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "-";
			Random random = new Random();
			for (int i=0; i<5; i++) {
				renameFileName += Integer.toString(random.nextInt(9));
			}	
			
			// 원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
			renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
			
			// 파일 객체 만들기
			File originFile = new File(savePath + "\\" + fileName);
			File renameFile = new File(savePath + "\\" + renameFileName);
			
			// 업로드 파일 저장시키고, 바로 이름바꾸기 실행함
				uploadfile.transferTo(renameFile);
		} 
	  } catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("message", "전송파일 저장 실패");
				return "common/error";
	  }
	  return "common/main";
	}
}
