package com.st.smartrash.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.st.smartrash.trash.model.service.TrashService;
import com.st.smartrash.trash.model.vo.Trash;
import com.st.smartrash.user.model.service.UserService;
import com.st.smartrash.user.model.vo.NaverLoginBO;
import com.st.smartrash.user.model.vo.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	@Inject
	private TrashService trashService;
	
	@Autowired
	private UserService userService;

	//로그인 첫 화면 요청 메소드
	@RequestMapping(value="login.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrlNaver(session);
		
		System.out.println("네이버:" + naverAuthUrl);
		//네이버
		
//		String kakaoAuthUrl = naverLoginBO.getAuthorizationUrlKakao(session);
//		System.out.println("카카오:" + kakaoAuthUrl);
//		//카카오

		model.addAttribute("naverUrl", naverAuthUrl);
//		model.addAttribute("kakaoUrl", kakaoAuthUrl);
		return "user/login";

	}

	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value="callback.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, User user)
			throws IOException, ParseException {
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		//1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		 **/
		//2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		//3. 데이터 파싱
		//Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		System.out.println(response_obj);
		//response의 name값 파싱
		String name = (String)response_obj.get("name");
		String email = (String)response_obj.get("email");

		//중복된 이메일이 있으면 그대로 사용, 아니면 새로 적용
		if(userService.dupCheck(email) != null) {
			user = userService.dupCheck(email);
		}else {
			user.setUser_name(name);
			user.setUser_email(email);
			if(userService.insertUser(user) > 0) {
				System.out.println("디비저장완료");
			}else {
				System.out.println("디비저장실패");
			}
		}
		user = userService.selectUser(email);
		System.out.println(user.toString());
		//4.파싱 네임 세션으로 저장
		// 세션 생성
		session.setAttribute("loginUser", user);
		
		ArrayList<Trash> trash_list = trashService.selectTrashNewTop();
		ArrayList<Trash> category_list = trashService.selectTrashNewTop();
		model.addAttribute("trash_list", trash_list);
		model.addAttribute("category_list", category_list);
		model.addAttribute("result", apiResult);
		return "common/main";
	}

	//로그아웃
	@RequestMapping(value="logout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session, Model model)throws IOException {
		System.out.println("여기는 logout");
		session.invalidate();
		
		ArrayList<Trash> trash_list = trashService.selectTrashNewTop();
		ArrayList<Trash> category_list = trashService.selectTrashNewTop();
		model.addAttribute("trash_list", trash_list);
		model.addAttribute("category_list", category_list);
		return "common/main";
	}
}
