package com.st.smartrash.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.smartrash.board.model.service.BoardService;
import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.common.Paging;
import com.st.smartrash.notice.model.vo.Notice;
import com.st.smartrash.trash.model.service.TrashService;
import com.st.smartrash.trash.model.vo.Trash;
import com.st.smartrash.user.model.service.UserService;
import com.st.smartrash.user.model.vo.User;

@Controller
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BoardService boardService;
	
	@Inject
	private TrashService trashService;
	
	@Autowired // 설정된 xml에서 가져와 쓰겠다 선언
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//마이페이지
	@RequestMapping("mypage.do")
	public ModelAndView myInfoMethod(HttpServletRequest request, ModelAndView mv, 
									 @RequestParam(name="page", required=false) String page) {
		HttpSession session = request.getSession();
		
		User user = (User)session.getAttribute("loginUser");
		if(user != null) {
			ArrayList<Trash> tlist = userService.selectMytrash(user.getUser_no());
	
			System.out.println("여기는 mypage.do, tlist" + tlist);
			
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			
			//페이징 처리 -- 별도의 클래스로 작성해서 사용해도 됨 ------------------------------------------------------------------------------------
			int limit = 5;  //한 페이지에 출력할 목록 갯수
			//페이지 수 계산을 위해 총 목록갯수 조회
			int listCount = userService.selectMygalListCount(user.getUser_no());
			System.out.println("내가쓴 갤러리 수 listCount : " + listCount);
			//페이지 수 계산
			//주의 : 목록이 11개이면, 페이지 수는 2가 됨 (나머지 목록 1개도 페이지가 1개 필요함)
			int maxPage = (int)((double)listCount / limit + 0.9);
			System.out.println("maxPage : " + maxPage);
			//현재 페이지가 포함된 페이지 그룹의 시작값 지정 (뷰 아래쪽에 표시할 페이지 수를 10개씩 한 경우)
			int startPage = (int)((double)currentPage / 10 + 0.9);
			System.out.println("startPage : " + startPage);
			//현재 페이지가 포함된 페이지그룹의 끝 값
			int endPage = startPage + 10 - 1;
			System.out.println("endPage : " + endPage);
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			
			//쿼리문에 전달할 현재 페이지에 출력할 목록의 첫 행과 끝 행 객체 처리
			int startRow = (currentPage - 1) * limit + 1;
			System.out.println("쿼리문에 전달할 startRow : " + startRow);
			int endRow = startRow + limit - 1;
			System.out.println("쿼리문에 전달할 endRow : " + endRow);
			Paging paging = new Paging(startRow, endRow);
			
			//별도의 클래스 작성 끝 ---------------------------------------------------------------------------------------------------------
			
			//서비스 메소드 실행하고 결과 받기
			Map<String,Object> map = new HashMap<>();
			map.put("user_no", user.getUser_no());
			map.put("startRow", startRow);
	        map.put("endRow", endRow);
			
			ArrayList<Board> blist = userService.selectMygalList(map);
			
			if(blist != null && blist.size() > 0) {
				mv.addObject("blist", blist);
				mv.addObject("listCount", listCount);
				mv.addObject("maxPage", maxPage);
				mv.addObject("currentPage", currentPage);
				mv.addObject("startPage", startPage);
				mv.addObject("endPage", endPage);
				mv.addObject("limit", limit);
				
			}else {
				mv.addObject("message", currentPage + "페이지 목록 조회 실패.");
				mv.setViewName("common/error");
			}
			
			if(user != null) {
				mv.addObject("user", user);
				mv.addObject("tlist", tlist);
				System.out.println("tlist : " + tlist);
				mv.setViewName("user/myPage");
			}
			
			return mv;
		}else {
			mv.addObject("message", "로그인 가능 여부를 관리자에게 문의하세요.");
			mv.setViewName("common/error");
			return mv;
		}
	}
	
	//닉네임 변경 팝업페이지
	@RequestMapping("nickname.do")
	public ModelAndView nicknameMethod(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession();

		User user = (User)session.getAttribute("loginUser");
		System.out.println("여기는 nickname.do" + user);

		if(user != null) {
			mv.addObject("user", user);
			mv.setViewName("user/popNickPage");
		}

		return mv;
	}
	
	//닉네임 변경용
	@RequestMapping(value="upnick.do", method=RequestMethod.POST)
	public String UpdateNicknameMethod(HttpServletRequest request, Model model, @RequestParam("user_name") String user_name) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("loginUser");
		System.out.println("여기는 upnick.do, 받은 세션user : " + user);
		
		user.setUser_name(user_name);
		
		if(userService.updateNick(user) > 0) {
			return "redirect:mypage.do?user";
		}else {
			System.out.println("닉네임 변경 실패");
			return "user/myPage";
		}
	}
	
	//마이페이지 회원탈퇴용
	@RequestMapping(value="udel.do")
	public String userDeleteMethod(HttpServletRequest request, @RequestParam(value="user_email", required=false) String user_email, Model model) {
		User user;
		if(user_email != null) {
			System.out.println("여기는 udel.do, 관리자가 탈퇴요청 : " + user_email);
			userService.deleteUser(user_email);
			return "user/managerPage";
		}else {
			HttpSession session = request.getSession();
			user = (User)session.getAttribute("loginUser");
			System.out.println("여기는 udel.do, 마이페이지 탈퇴 : " + user);
			userService.deleteUser(user.getUser_email());
			session.invalidate();
			
			ArrayList<Trash> trash_list = trashService.selectTrashNewTop();
			ArrayList<Trash> category_list = trashService.selectTrashNewTop();
			model.addAttribute("trash_list", trash_list);
			model.addAttribute("category_list", category_list);
			return "common/main";
		}

	}
	
	//관리자 권한 팝업페이지
	@RequestMapping("popManager.do")
	public ModelAndView managerLoginMethod(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession();

		User user = (User)session.getAttribute("loginUser");
		System.out.println("여기는 popManager.do : " + user);
		
		if(user != null) {
			mv.addObject("user", user);
			mv.setViewName("user/popAdminPage");
		}

		return mv;
	}
	
	//관리자 권한용
	@RequestMapping(value="admin.do", method=RequestMethod.POST)
	public String UpdateAdminMethod(HttpServletRequest request, Model model, @RequestParam("user_admin") String user_admin) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("loginUser");
		System.out.println("여기는 admin.do, 받은 세션user : " + user);
		
		if(user.getUser_admin().equals("Y")) {
			user.setUser_admin("N");
		}else {
			user.setUser_admin(user_admin);
		}
		
		if(userService.updateAdmin(user) > 0) {
			System.out.println("관리자 변경 ok");
			return "redirect:mypage.do?user";
		}else {
			System.out.println("관리자 변경 실패");
			return "user/myPage";
		}
	}
	
	//관리자페이지
	@RequestMapping("manager.do")
	public ModelAndView boardListMethod(@RequestParam(name="upage", required=false) String upage, @RequestParam(name="inpage", required=false) String inpage,
										@RequestParam(name="rpage", required=false) String rpage, ModelAndView mv, HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		User user = (User)session.getAttribute("loginUser");
		if(user != null && user.getLogin_ok().equals("Y") && user.getUser_admin().equals("Y")) {
			System.out.println("받아온 upage : " + upage);
			System.out.println("받아온 rpage : " + rpage);
			int onPage = 1;
			if(inpage != null) {
				onPage = Integer.parseInt(inpage);
			}
	
			int rcurrentPage = 1;
			if(rpage != null) {
				rcurrentPage = Integer.parseInt(rpage);
			}
			int ucurrentPage = 1;
			if(upage != null) {
				ucurrentPage = Integer.parseInt(upage);
			}
			
			//신고된 쓰레기 페이징 처리 ---------------------------------------------------------------------------------------------------------
			int rlimit = 12;  //한 페이지에 출력할 목록 갯수
			//페이지 수 계산을 위해 총 목록갯수 조회
			int rlistCount = userService.selectReportListCount();
			System.out.println("신고된 쓰레기 수 :" + rlistCount);
			//페이지 수 계산
			//주의 : 목록이 11개이면, 페이지 수는 2가 됨 (나머지 목록 1개도 페이지가 1개 필요함)
			int rmaxPage = (int)((double)rlistCount / rlimit + 0.9);
			//현재 페이지가 포함된 페이지 그룹의 시작값 지정 (뷰 아래쪽에 표시할 페이지 수를 10개씩 한 경우)
			int rstartPage = (int)((double)rcurrentPage / 10 + 0.9);
			//현재 페이지가 포함된 페이지그룹의 끝 값
			int rendPage = rstartPage + 10 - 1;
			
			if(rmaxPage < rendPage) {
				rendPage = rmaxPage;
			}
			
			//쿼리문에 전달할 현재 페이지에 출력할 목록의 첫 행과 끝 행 객체 처리
			int rstartRow = (rcurrentPage - 1) * rlimit + 1;
			int rendRow = rstartRow + rlimit - 1;
			Paging rpaging = new Paging(rstartRow, rendRow);
			System.out.println("리포트 페이징 startRow, endRow : " + rstartRow + ", " + rendRow);
			
			//신고된 쓰레기 페이징 끝 ---------------------------------------------------------------------------------------------------------
			
			//저장된 유저 페이징 처리 ---------------------------------------------------------------------------------------------------------
			int ulimit = 10;  //한 페이지에 출력할 목록 갯수
			//페이지 수 계산을 위해 총 목록갯수 조회
			int ulistCount = userService.selectUserListCount();
			System.out.println("저장된 유저 수 :" + ulistCount);
			//페이지 수 계산
			//주의 : 목록이 11개이면, 페이지 수는 2가 됨 (나머지 목록 1개도 페이지가 1개 필요함)
			int umaxPage = (int)((double)ulistCount / ulimit + 0.9);
			//현재 페이지가 포함된 페이지 그룹의 시작값 지정 (뷰 아래쪽에 표시할 페이지 수를 10개씩 한 경우)
			int ustartPage = (int)((double)ucurrentPage / 10 + 0.9);
			//현재 페이지가 포함된 페이지그룹의 끝 값
			int uendPage = ustartPage + 10 - 1;
			
			if(umaxPage < uendPage) {
				uendPage = umaxPage;
			}
			
			//쿼리문에 전달할 현재 페이지에 출력할 목록의 첫 행과 끝 행 객체 처리
			int ustartRow = (ucurrentPage - 1) * ulimit + 1;
			int uendRow = ustartRow + ulimit - 1;
			Paging upaging = new Paging(ustartRow, uendRow);
			System.out.println("유저 페이징 startRow, endRow : " + ustartRow + ", " + uendRow);
			
			//저장된 유저 페이징 끝 ---------------------------------------------------------------------------------------------------------
			
			//서비스 메소드 실행하고 결과 받기
			ArrayList<Board> rlist = userService.selectReportList(rpaging);
			System.out.println("rlist : " + rlist);
			ArrayList<User> ulist = userService.selectUserList(upaging);
		
			mv.addObject("rlist", rlist);
			mv.addObject("rlistCount", rlistCount);
			mv.addObject("rmaxPage", rmaxPage);
			mv.addObject("rcurrentPage", rcurrentPage);
			mv.addObject("rstartPage", rstartPage);
			mv.addObject("rendPage", rendPage);
			mv.addObject("rlimit", rlimit);	
	
			mv.addObject("ulist", ulist);
			mv.addObject("ulistCount", ulistCount);
			mv.addObject("umaxPage", umaxPage);
			mv.addObject("ucurrentPage", ucurrentPage);
			mv.addObject("ustartPage", ustartPage);
			mv.addObject("uendPage", uendPage);
	
			ArrayList<Trash> tlist = userService.selectTodayTrash();
			ArrayList<Trash> trlist = userService.selectTodayReportTrash();
	
			mv.addObject("tlist", tlist);
			mv.addObject("trlist", trlist);
			mv.addObject("onPage", onPage);
			System.out.println("mv : " + mv);
			mv.setViewName("user/managerPage");
			
			return mv;
		} else {
			mv.addObject("message", "관리자 여부를 확인하세요.");
			mv.setViewName("common/error");
			return mv;
		}
	}
	
	//마이페이지에서 내가쓴 갤러리 상세페이지 이동용
	@RequestMapping("mbdetail.do")
	public ModelAndView boardDetailMethod(HttpServletRequest request, ModelAndView mv, @RequestParam("board_no") int board_no) {
		
		//댓글 리스트 저장-------
		ArrayList<Board> list = boardService.selectReplyList(board_no);
		int listCount = boardService.selectReplyCount(board_no);
		//해당 게시글 조회
		Board board = boardService.selectBoard(board_no);
		if(board != null) {
//			String path = request.getSession().getServletContext().getRealPath("resources/trash_upfiles");
//			
//			board.setTrash_path(path + "\\" + board.getTrash_path());
//			System.out.println(board.getTrash_path());
			
			//댓글 리스트보내기
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("board", board);
			mv.setViewName("board/boardDetailView");
		}else {
			mv.addObject("message", board_no+"번 게시글 조회 실패");
			mv.setViewName("common/error");
		}
		
		return mv;
	}

	//로그인 제한/가능 변경 처리용
	@RequestMapping(value="loginok.do", method=RequestMethod.POST)
	public void changeLoginOKMethod(@RequestParam("user_email") String user_email, @RequestParam("login_ok") String login_ok, HttpServletResponse response) throws IOException {
		logger.info("여기는 loginok.do : " + user_email);
		if(userService.selectUser(user_email).getUser_admin().equals("Y")) {
			response.setContentType("text/html; charset=utf-8"); // 문자는 html로 utf-8 형식으로
			PrintWriter out = response.getWriter();
			out.append("no");
			out.flush();
			out.close();
		}else {
			
			if(login_ok.equals("true")) {
				login_ok = "Y";
			} else if(login_ok.equals("false")) {
				login_ok = "N";
			}
			
			Map<String, String> map = new HashMap<>();
			map.put("login_ok", login_ok);
			map.put("user_email", user_email);
			
			if(userService.updateLoginOK(map) > 0) {
				response.setContentType("text/html; charset=utf-8"); // 문자는 html로 utf-8 형식으로
				PrintWriter out = response.getWriter();
				out.append("ok");
				out.flush();
				out.close();
			}else {
				System.out.println("변경 실패");
			}
		}
	}
}
