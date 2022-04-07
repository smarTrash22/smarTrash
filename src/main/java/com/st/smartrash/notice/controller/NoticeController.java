package com.st.smartrash.notice.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.st.smartrash.common.Paging;
import com.st.smartrash.notice.model.service.NoticeService;
import com.st.smartrash.notice.model.vo.Notice;

@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;

	@RequestMapping("nlist.do")
	public ModelAndView noticeListMethod(@RequestParam(name="page", required=false) String page, 
			ModelAndView mv) {
		int currentPage = 1;
		if(page != null){
			currentPage = Integer.parseInt(page);
		}
	      

	      int limit = 10; 

	      int listCount = noticeService.selectListCount();
	 
	
	      int maxPage = (int)((double)listCount / limit + 0.9);

	      int startPage = (int)((double)currentPage / 10 + 0.9);

	      int endPage = startPage + 10 - 1;
	      
	      if(maxPage < endPage) {
	         endPage = maxPage;
	      }
	
	      int startRow = (currentPage - 1) * limit + 1;
	      int endRow = startRow + limit - 1;
	      Paging paging = new Paging(startRow, endRow);
	      

	      ArrayList<Notice> list = noticeService.selectList(paging);
	      
	      if(list != null && list.size() > 0) {
	         mv.addObject("list", list);
	         mv.addObject("listCount", listCount);
	         mv.addObject("maxPage", maxPage);
	         mv.addObject("currentPage", currentPage);
	         mv.addObject("startPage", startPage);
	         mv.addObject("endPage", endPage);
	         mv.addObject("limit", limit);
	         
	         mv.setViewName("notice/noticeListView");
	      }else {
	         mv.addObject("message", currentPage + "페이지 목록 조회 실패.");
	         mv.setViewName("common/error");
	      }
	      
	      return mv;
	   }
	
	//상세보기
	@RequestMapping("ndetail.do")
	public ModelAndView noticeDetailMethod(ModelAndView mv, 
			@RequestParam("notice_no") int notice_no,
			@RequestParam(name= "page", required=false) String page) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		noticeService.addReadcount(notice_no);
		
		Notice notice = noticeService.selectNotice(notice_no);
		
		if(notice != null) {
			mv.addObject("notice", notice);
			mv.addObject("currnetPage", currentPage);
			mv.setViewName("notice/noticeDetailView");
			
		}else {
			mv.addObject("message", "게시글 조회 실패");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	//공지사항 글쓰기(관리자)
	//공지사항 글쓰기 페이지 이동
	@RequestMapping("movewrite.do")
	public String moveWritePage() {
		return "notice/noticeWriteForm";
	}
	
	//공지 등록처리
	@RequestMapping(value="ninsert.do", method=RequestMethod.POST)
	public String noticeInsertMethod(Notice notice, HttpServletRequest request, Model model,
			@RequestParam(name="upfile", required=false) MultipartFile mfile) {
		
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		if(!mfile.isEmpty()) {
			String fileName = mfile.getOriginalFilename(); //파일 꺼내기
			if(fileName != null && fileName.length() > 0) {
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
		
				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);
				
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "파일 저장 실패.");
					return "common/error";
				}
				
				notice.setNotice_original_filepath(fileName);
				notice.setNotice_rename_filepath(renameFileName);
			}
		} 
		
		
		if(noticeService.insertNotice(notice) > 0 ) { 
			 return "redirect:nlist.do";
		}else {
			return "common/error";
		}
	}
	
	//첨부파일 다운로드
	@RequestMapping("nfiledown.do")
	public ModelAndView fileDownMethod(HttpServletRequest request,
			@RequestParam("ofile") String originFileName,
			@RequestParam("rfile") String renameFileName, ModelAndView mv) {
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		File renameFile = new File(savePath + "\\" + renameFileName);
		File originFile = new File(originFileName);
		
		mv.setViewName("filedown");
		mv.addObject("renameFile", renameFile);
		mv.addObject("originFile", originFile);
		
		return mv;
		
	}
	
	//공지 삭제(관리자)
	@RequestMapping("ndel.do")
	public String noticeDeleteMethod(@RequestParam("notice_no") int notice_no, 
			@RequestParam(name="rfile", required=false) String renameFileName, 
			HttpServletRequest request, Model model) {
		if(noticeService.deleteNotice(notice_no) > 0) {
			if(renameFileName != null) {
				new File(request.getSession().getServletContext().getRealPath("resources/notice_upfiles") 
						+ "\\"+ renameFileName).delete();
			}
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", "글 삭제 실패.");
			return "common/error";
		}
	}
	
	
	
	//공지 일괄 삭제
	
	@RequestMapping("nsdel.do")
	public String noticeDeleteMethod(@RequestParam(value="notice_no[]") List<Integer> deleteList, 
			Model model) {
		ArrayList<Integer> deleteArray = new ArrayList<Integer>();
				for(int i=0;i<deleteList.size();i++){
			        deleteArray.add(deleteList.get(i));
		}
			return "redirect:nlist.do";
	}
	 
	 
	//공지사항 수정(관리자)
	//공지사항 수정페이지로 이동
	@RequestMapping("moveupdate.do")
	public String moveUpdatePage(@RequestParam("notice_no") int notice_no, Model model) {
		Notice notice = noticeService.selectNotice(notice_no);
		if(notice != null) {
			model.addAttribute("notice", notice);
			return "notice/noticeUpdateForm";
		}else {
			model.addAttribute("message", notice_no + "번 글 수정페이지로 이동 실패.");
			return "common/error";
		}
	}
	
	//공지 수정처리
		@RequestMapping(value="nupdate.do", method=RequestMethod.POST)
		public String noticeUpdateMethod(Notice notice, HttpServletRequest request, Model model,
				@RequestParam(name="delFlag", required=false) String delFlag,
				@RequestParam(name="upfile", required=false) MultipartFile mfile) {

			String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
			if(notice.getNotice_original_filepath() != null && delFlag != null && delFlag.equals("yes")) {

				new File(savePath + "\\" + notice.getNotice_rename_filepath()).delete();

				notice.setNotice_original_filepath(null);
				notice.setNotice_rename_filepath(null);
			}
			

			if(!mfile.isEmpty()) {

				if(notice.getNotice_original_filepath() != null) {

					new File(savePath + "\\" + notice.getNotice_rename_filepath()).delete();

					notice.setNotice_original_filepath(null);
					notice.setNotice_rename_filepath(null);
				}
				
		
				String fileName = mfile.getOriginalFilename();

				if(fileName != null && fileName.length() > 0) {
			
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				
					String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
			
					renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
					
	
					File originFile = new File(savePath + "\\" + fileName);
					File renameFile = new File(savePath + "\\" + renameFileName);
					
					
					try {
						mfile.transferTo(renameFile);
					} catch (Exception e) {
						e.printStackTrace();
						model.addAttribute("message", "전송파일 저장 실패.");
						return "common/error";
					}
					
					notice.setNotice_original_filepath(fileName);
					notice.setNotice_rename_filepath(renameFileName);
				}  
			}  
			
			if(noticeService.updateNotice(notice) > 0) {
				return "redirect:nlist.do";
			}else {
				model.addAttribute("message", "공지 수정 실패.");
				return "common/error";
			}
		}
		

		
	//공지사항 검색
	@RequestMapping(value="nsearch.do", method=RequestMethod.GET)
	public ModelAndView noticeSearchMethod(
			@RequestParam(value="keyword", defaultValue="") String keyword,
			@RequestParam(value="type", defaultValue="") String type,
			@RequestParam(name="page", required=false) String page,
			ModelAndView mv){
		int currentPage = 1;
		if(page != null){
			currentPage = Integer.parseInt(page);
		}
	      

	      int limit = 10; 

	      int listCount = noticeService.selectSearchListCount(keyword);
	 
	
	      int maxPage = (int)((double)listCount / limit + 0.9);

	      int startPage = (int)((double)currentPage / 10 + 0.9);

	      int endPage = startPage + 10 - 1;
	      
	      if(maxPage < endPage) {
	         endPage = maxPage;
	      }
	
	      int startRow = (currentPage - 1) * limit + 1;
	      int endRow = startRow + limit - 1;
	      Paging paging = new Paging(startRow, endRow);
	      
		Map<String,Object> map = new HashMap<>();
		
		map.put("type", type);
	    map.put("keyword", keyword);
	    map.put("startRow", paging.getStartRow());
	    map.put("endRow", paging.getEndRow());
	    
	 
	        ArrayList<Notice> list = noticeService.selectSearch(map);
			
	        
	        if(list != null && list.size() > 0) {
		     mv.addObject("list", list);
	         mv.addObject("listCount", listCount);
	         mv.addObject("maxPage", maxPage);
	         mv.addObject("currentPage", currentPage);
	         mv.addObject("startPage", startPage);
	         mv.addObject("endPage", endPage);
	         mv.addObject("limit", limit);
	         
	         mv.setViewName("notice/noticeSearchView");
	      }else {
	    	  
	    	 mv.setViewName("notice/noticeSearchView");
	      }
	      
	      return mv;
	}
}