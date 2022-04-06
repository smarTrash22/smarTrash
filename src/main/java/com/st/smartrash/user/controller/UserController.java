package com.st.smartrash.user.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

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
	
	@Autowired // 설정된 xml에서 가져와 쓰겠다 선언
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("loginPage.do")
	public String moveLoginPage() {
		return "user/loginPage";
	}
	
	/*
	 * @RequestMapping(value="kakaologin.do", produces="application/json", method =
	 * RequestMethod.GET) public String kakaoLogin(@RequestParam("code") String
	 * code, RedirectAttributes ra, HttpSession session, HttpServletResponse
	 * response) throws IOException { System.out.println("kakao code : " + code);
	 * System.out.println("#########" + code); String access_Token =
	 * userService.getAccessToken(code); System.out.println("###access_Token#### : "
	 * + access_Token);
	 * 
	 * JsonNode accessToken;
	 * 
	 * // JsonNode트리형태로 토큰받아온다 JsonNode jsonToken =
	 * KakaoAccessToken.getKakaoAccessToken(code); // 여러 json객체 중 access_token을 가져온다
	 * accessToken = jsonToken.get("access_token");
	 * 
	 * System.out.println("access_token : " + accessToken);
	 * 
	 * // access_token을 통해 사용자 정보 요청 JsonNode userInfo =
	 * KakaoUserInfo.getKakaoUserInfo(accessToken);
	 * 
	 * // Get id String id = userInfo.path("id").asText(); String name = null;
	 * String email = null;
	 * 
	 * // 유저정보 카카오에서 가져오기 Get properties JsonNode properties =
	 * userInfo.path("properties"); JsonNode kakao_account =
	 * userInfo.path("kakao_account");
	 * 
	 * name = properties.path("nickname").asText(); email =
	 * kakao_account.path("email").asText();
	 * 
	 * System.out.println("id : " + id); System.out.println("name : " + name);
	 * System.out.println("email : " + email);
	 * 
	 * return code; }
	 */
	
	@RequestMapping("kakaoLogin.do")
	public String kakaoLogin(@RequestParam(value = "code"/* , required = false */) String code) throws Exception {
		System.out.println("#########" + code);
		
		String access_Token = userService.getAccessToken(code);
		HashMap<String, Object> userInfo = userService.getUserInfo(access_Token);
		
		System.out.println("###access_Token#### : " + access_Token);
		System.out.println("###nickname#### : " + userInfo.get("nickname"));
		System.out.println("###email#### : " + userInfo.get("email"));
		
		return "common/main";
	}
	
	@RequestMapping("mypage.do")
	public ModelAndView myInfoMethod(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession();

		User user = (User)session.getAttribute("loginUser");
		
		ArrayList<Board> blist = userService.selectMygal5(user.getUser_no());
		ArrayList<Trash> tlist = userService.selectLatest5(user.getUser_no());
		
		System.out.println("여기는 mypage.do, blist" + blist);
		System.out.println("여기는 mypage.do, tlist" + tlist);
		
		if(user != null) {
			mv.addObject("user", user);
			mv.addObject("blist", blist);
			mv.addObject("tlist", tlist);
			mv.setViewName("user/myPage");
		}
		
		return mv;
	}
	
//	@RequestMapping("nickname.do")
//	public ModelAndView nicknameMethod(HttpServletRequest request, ModelAndView mv) {
//		HttpSession session = request.getSession();
//
//		User user = (User)session.getAttribute("loginUser");
//		System.out.println("여기는 닉네임" + user);
//
//		if(user != null) {
//			mv.addObject("user", user);
//			mv.setViewName("user/nickname");
//		}
//
//		return mv;
//	}
	
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

	@RequestMapping(value="udel.do")
	public String userDeleteMethod(HttpServletRequest request, @RequestParam(value="user_email", required=false) String user_email) {
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
			return "common/main";
		}

	}
	
	@RequestMapping(value="latest5.do", method=RequestMethod.POST)
	@ResponseBody
	public String latest5Method(HttpServletResponse response, HttpServletRequest request) throws UnsupportedEncodingException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("loginUser");
		System.out.println("여기는 latest5.do, 받은 세션user : " + user);
		
		ArrayList<Trash> list = userService.selectLatest5(user.getUser_no());
		
		//전송용 json 객체 준비
		JSONObject sendJson = new JSONObject();
		//list 옮길 json 배열 준비
		JSONArray jarr = new JSONArray();
		
		//list 를 jarr 로 옮기기(복사)
		for(Trash trash : list) {
			//notice 필드값 저장용 json 객체 생성
			JSONObject job = new JSONObject();
			
			job.put("trash_no", trash.getTrash_no());
			job.put("trash_path", trash.getTrash_path());
			
			jarr.add(job); // job 을 jarr 에 저장
		}
		
		//전송용 객체에 jarr 을 담음
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();  //json 을 json string 형으로 바꿔서 전송함
		//servlet-context.xml 뷰리졸버에게로 리턴됨
	}
	
	@RequestMapping(value="mygal5.do", method=RequestMethod.POST)
	@ResponseBody 
	public String mygal5Method(HttpServletResponse response, HttpServletRequest request) throws UnsupportedEncodingException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("loginUser");
		System.out.println("여기는 mygal5.do, 받은 세션user : " + user);
		
		ArrayList<Board> list = userService.selectMygal5(user.getUser_no());
		System.out.println("mg5 list 검사 : " + list);
		//전송용 json 객체 준비
		JSONObject sendJson = new JSONObject();
		//list 옮길 json 배열 준비
		JSONArray jarr = new JSONArray();
		
		//list 를 jarr 로 옮기기(복사)
		for(Board board : list) {
			//notice 필드값 저장용 json 객체 생성
			JSONObject job = new JSONObject();
			
			job.put("board_no", board.getBoard_no());
			job.put("board_content", board.getBoard_content());
			
			jarr.add(job); // job 을 jarr 에 저장
		}
		
		//전송용 객체에 jarr 을 담음
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();  //json 을 json string 형으로 바꿔서 전송함
		//servlet-context.xml 뷰리졸버에게로 리턴됨
	}
	
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
			System.out.println("닉네임 변경 실패");
			return "user/myPage";
		}
	}
	
	@RequestMapping("manager1.do")
	public ModelAndView managerPageMethod(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession();

		User user = (User)session.getAttribute("loginUser");
		System.out.println("여기는 manager.do : " + user);
		
		ArrayList<User> ulist = userService.selectUserList();
		ArrayList<Trash> tlist = userService.selectTodayTrash();
		ArrayList<Trash> rlist = userService.selectReportTrash();
		ArrayList<Trash> trlist = userService.selectTodayReportTrash();
		
		System.out.println("여기는 manager.do : " + rlist);
		
		mv.addObject("user", user);
		mv.addObject("ulist", ulist);
		mv.addObject("tlist", tlist);
		mv.addObject("rlist", rlist);
		mv.addObject("trlist", trlist);
		mv.setViewName("user/managerPage");

		return mv;
		
	}
	
	@RequestMapping("manager.do")
	public ModelAndView boardListMethod(@RequestParam(name="page", required=false) String page,
										ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		//페이징 처리 -- 별도의 클래스로 작성해서 사용해도 됨 ------------------------------------------------------------------------------------
		int limit = 9;  //한 페이지에 출력할 목록 갯수
		//페이지 수 계산을 위해 총 목록갯수 조회
		int listCount = userService.selectReportListCount();
		//페이지 수 계산
		//주의 : 목록이 11개이면, 페이지 수는 2가 됨 (나머지 목록 1개도 페이지가 1개 필요함)
		int maxPage = (int)((double)listCount / limit + 0.9);
		//현재 페이지가 포함된 페이지 그룹의 시작값 지정 (뷰 아래쪽에 표시할 페이지 수를 10개씩 한 경우)
		int startPage = (int)((double)currentPage / 10 + 0.9);
		//현재 페이지가 포함된 페이지그룹의 끝 값
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		//쿼리문에 전달할 현재 페이지에 출력할 목록의 첫 행과 끝 행 객체 처리
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		
		//별도의 클래스 작성 끝 ---------------------------------------------------------------------------------------------------------
		
		//서비스 메소드 실행하고 결과 받기
		ArrayList<Board> list = userService.selectReportList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			
			mv.setViewName("user/boardListView");
		}else {
			mv.addObject("message", currentPage + "페이지 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		
		ArrayList<User> ulist = userService.selectUserList();
		ArrayList<Trash> tlist = userService.selectTodayTrash();
		ArrayList<Trash> rlist = userService.selectReportTrash();
		ArrayList<Trash> trlist = userService.selectTodayReportTrash();
		
		System.out.println("여기는 manager.do : " + rlist);

		mv.addObject("ulist", ulist);
		mv.addObject("tlist", tlist);
		mv.addObject("rlist", rlist);
		mv.addObject("trlist", trlist);
		mv.setViewName("user/managerPage");
		
		return mv;
	}
	
	@RequestMapping("mbdetail.do")
	public ModelAndView boardDetailMethod(HttpServletRequest request, ModelAndView mv,@RequestParam("board_no") int board_no) {
		
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
	@RequestMapping("loginok.do")
	public String changeLoginOKMethod(User user, Model model, HttpServletRequest request) {
		logger.info("loginok.do : " + user.getUser_email() + ", " + user.getLogin_ok());
		
		if(userService.updateLoginOK(user) > 0) {
			String referer = request.getHeader("Referer");
			return "redirect:"+ referer;
//			return "redirect:manager.do";
		}else {
			model.addAttribute("message", "로그인 제한/허용 처리 오류 발생!");
			return "common/error";
		}
		
	}
}
