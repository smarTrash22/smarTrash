package com.st.smartrash.trash.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.st.smartrash.category.model.vo.Category;
import com.st.smartrash.common.CategoryTranslation;
import com.st.smartrash.common.Paging;
import com.st.smartrash.common.SearchDate;
import com.st.smartrash.trash.model.service.TrashService;
import com.st.smartrash.trash.model.vo.Trash;

@Controller
public class TrashController {

	private static final Logger logger = LoggerFactory.getLogger(TrashController.class);

	@Autowired
	private TrashService trashService;

	@RequestMapping(value = "trashMenubar.do")
//   @RequestMapping(value = "trashMenubar.do", method = RequestMethod.POST)
	public String trashMenubarViewForward() {
		return "trash/trashMenubar";
	}

	@RequestMapping(value = "moveInsertPage.do")
	public String moveInsertPageViewForward() {
		return "trash/trashInsert";
	}

	@RequestMapping(value = "moveDescPage.do")
	public String moveDescPageViewForward() {
		return "trash/trashDesc";
	}

	// 쓰레기 등록
	@RequestMapping(value = "trashInsert.do", method = RequestMethod.POST)
	public String trashInsertMethod(Trash trash, HttpServletRequest request, Model model,
			@RequestParam(name = "upfile", required = false) MultipartFile mfile) {
		// 업로드된 파일 저장 폴더 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/trash_upfiles");
		// System.out.println(trash + "," + mfile);
		// 첨부파일이 있을때만 업로드된 파일을 지정 폴더로 옮기기
		if (!mfile.isEmpty()) {
			String fileName = mfile.getOriginalFilename();
			// 이름바꾸기 처리 : 년월일시분초.확장자
			if (fileName != null && fileName.length() > 0) {
				// 바꿀 파일명에 대한 문자열 만들기
				// 공지글 등록 요청시점의 날짜정보를 이용함
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				// 변경할 파일이름 만들기
				String renameFileName = sdf.format(new Date(System.currentTimeMillis()));
				// 원본파일의 확장자를 추출해서 변경 파일명에 붙여줌
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);

				trash.setTrash_path(renameFileName);

				// 파일 객체 만들기
				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);

				// 업로드 파일 저장시키고 바로 이름 바꾸기 실행함
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장 실패");
					return "common/error";
				}

			}
		} // 첨부파일이 있을때만

		if (trashService.trashInsert(trash) != null) { // 새 공지글 등록 성공시
			model.addAttribute("message", "새 쓰레기 등록 성공!");
			return "trash/trashInsert";
		} else {
			model.addAttribute("message", "새 쓰레기 등록 실패!");
			return "common/error";
		}
	}

	// 쓰레기 전체조회
	@RequestMapping("trash.do")
	public String trashSelectAllMethod(Model model) {
		ArrayList<Trash> list = trashService.trashSelectAll();
		System.out.println(list.toString());
		model.addAttribute("list", list);
		return "trash/trashListView";
	}

	// 게시글 페이지단위로 목록 조회 처리용
	// 이름틀렸을때 서버구동시 404에러나옴
	@RequestMapping("tlist.do")
	public ModelAndView trashListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 페이징 계산 처리 -- 별도의 클래스로 작성해서 사용해도 됨 ------------
		int limit = 10; // 한 페이지에 출력할 목록 갯수
		// 페이지 수 계산을 위해 총 목록 갯수 조회
		int listCount = trashService.selectListCount();
		System.out.println("강기원은 : " + listCount);
		// 페이지 수 계산
		// 주의 : 목록이 11개이면 , 페이지수는 2가 됨
		// 나머지 목록 1개도 출력페이지가 1개 필요함
		int maxPage = (int) ((double) listCount / limit + 0.9);
		// 현재 페이지가 포함된 페이지 그룹의 시작값 지정 (뷰 아래쪽에 표시할 페이지 수를 10개씩 한 경우 1~10/ 11-20~ ...)
		int startPage = (int) ((double) currentPage / 10 + 0.9);
		// 현재 페이지가 포함된 페이지그룹의 끝값
		int endPage = startPage + 10 - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}

		// 쿼리문에 전달할 현재 페이지에 출력할 목록의 첫행과 끝행 객체 처리
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		System.out.println(paging);
		// 별도의 클래스 작성 끝 ------------------------------------------------------

		// 서비스 메소드 실행하고 결과받기
		ArrayList<Trash> list = trashService.selectList(paging);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);

			mv.setViewName("trash/trashListView");
		} else {
			mv.addObject("message", currentPage + "페이지 목록 조회 실패!");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 쓰레기 유저번호 검색용
	@RequestMapping(value = "searchUserNo.do", method = RequestMethod.POST)
	public String SearchUserNoMethod(@RequestParam("keyword") int keyword, Model model) {
		ArrayList<Trash> list = trashService.selectSearchUserNo(keyword);

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "trash/trashListView";
		} else {
			model.addAttribute("message", keyword + "로 검색된 유저 번호가 없습니다.");
			return "common/error";
		}
	}

	// 쓰레기 유저번호 검색용
	@RequestMapping(value = "searchCategoryNo.do", method = RequestMethod.POST)
	public String SearchCategoryNoMethod(@RequestParam("keyword") int keyword, Model model) {
		ArrayList<Trash> list = trashService.selectSearchCategoryNo(keyword);

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "trash/trashListView";
		} else {
			model.addAttribute("message", keyword + "로 검색된 카테고리 번호가 없습니다.");
			return "common/error";
		}
	}

	// 쓰레기 날짜 검색용
	@RequestMapping(value = "searchDate.do", method = RequestMethod.POST)
	public String SearchDateMethod(SearchDate date, Model model) {
		ArrayList<Trash> list = trashService.selectSearchDate(date);

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "trash/trashListView";
		} else {
			model.addAttribute("message", "해당 날짜로 등록된 쓰레기가 없습니다.");
			return "common/error";
		}
	}

	// 신고된 쓰레기 검색용
	@RequestMapping(value = "searchReport.do", method = RequestMethod.POST)
	public String SearchReportMethod(@RequestParam("keyword") String keyword, Model model) {
		ArrayList<Trash> list = trashService.selectSearchReport(keyword);

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "trash/trashListView";
		} else {
			model.addAttribute("message", "신고된 쓰레기가 없습니다.");
			return "common/error";
		}
	}

	@RequestMapping(value = "selectRecentList.do", method = RequestMethod.POST)
	@ResponseBody // responsebody에 담아서 보낸다
	public String selectRecentListMethod(HttpServletResponse response) throws UnsupportedEncodingException {
		// 최근 등록공지글 3개 조회해 옴
		ArrayList<Trash> list = trashService.selectRecentList();

		// 전송용 json 객체 준비
		JSONObject sendJson = new JSONObject();
		// list 옮길 json 배열 준비
		JSONArray jarr = new JSONArray();

		// list 를 jarr 로 옮기기(복사)
		for (Trash trash : list) {
			// trash 필드값 저장용 json 객체 생성
			JSONObject job = new JSONObject();

			job.put("trash_no", trash.getTrash_no());
			// 한글 데이터는 반드시 인코딩해서 json에 담아야 한글이 깨지지 않음
			job.put("trash_path", URLEncoder.encode(trash.getTrash_path(), "utf-8"));

			jarr.add(job); // job를 jarr에 저장
		}

		// 배열을 전송하는법이 없어서 전송용 객체에 배열을 담자
		// json.list 라고 했으니 list 그대로 이름 들어가야함
		sendJson.put("list", jarr);

		// json을 json string 타입으로 바꿔서 리턴시킴
		return sendJson.toJSONString();
		// 뷰리졸버에게로 리턴됨
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}