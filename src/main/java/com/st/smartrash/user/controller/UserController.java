package com.st.smartrash.user.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.st.smartrash.user.model.service.UserService;
import com.st.smartrash.user.model.vo.KakaoUserInfo;

@Controller
@RequestMapping(value="/user/*")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
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
	
	@RequestMapping(value="/kakaoLogin", method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code"/* , required = false */) String code) throws Exception {
		System.out.println("되긴하는거냐고");
		System.out.println("#########" + code);
		
		String access_Token = userService.getAccessToken(code);
		HashMap<String, Object> userInfo = userService.getUserInfo(access_Token);
		
		System.out.println("###access_Token#### : " + access_Token);
		System.out.println("###nickname#### : " + userInfo.get("nickname"));
		System.out.println("###email#### : " + userInfo.get("email"));
		
		return "common/main";
	}
	
	
}
