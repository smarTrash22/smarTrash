package com.st.smartrash.user.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

//import org.codehaus.jackson.JsonParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonParser; 
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.common.Paging;
import com.st.smartrash.trash.model.vo.Trash;
import com.st.smartrash.user.model.dao.UserDao;
import com.st.smartrash.user.model.vo.User;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;
	
	@Override
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
            
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
            
			sb.append("&client_id=deb4c9afa0906ffd568af7df8f8a4567"); //본인이 발급받은 key
			sb.append("&redirect_uri=http://127.0.0.1:8888/smartrash/"); // 본인이 설정한 주소
            
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
            
			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
            
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
            
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
            
			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
            
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);
            
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}
	
	@Override
	public HashMap<String, Object> getUserInfo(String access_Token) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return userInfo;
	}
	
	@Override
	public User dupCheck(String email) {
		return userDao.dupCheck(email);
	}
	
	@Override
	public int insertUser(User user) {
		return userDao.insertUser(user);
	}
	
	@Override
	public User selectUser(String user_email) {
		return userDao.selectUser(user_email);
	}
	
	@Override
	public int updateNick(User user) {
		return userDao.updateNick(user);
	}
	
	@Override
	public int deleteUser(String user_email) {
		return userDao.deleteUser(user_email);
	}
	
	@Override
	public ArrayList<Trash> selectMytrash(int user_no) {
		return userDao.selectMytrash(user_no);
	}
	
	@Override
	public int updateAdmin(User user) {
		return userDao.updateAdmin(user);
	}
	
	@Override
	public ArrayList<Trash> selectTodayTrash() {
		return userDao.selectTodayTrash();
	}
	
	@Override
	public ArrayList<Trash> selectReportTrash() {
		return userDao.selectReportTrash();
	}
	
	@Override
	public ArrayList<Trash> selectTodayReportTrash() {
		return userDao.selectTodayReportTrash();
	}
	
	@Override
	public ArrayList<User> selectUserList(Paging page) {
		return userDao.selectUserList(page);
	}
	
	@Override
	public int selectReportListCount() {
		return userDao.selectReportListCount();
	}
	
	@Override
	public ArrayList<Board> selectReportList(Paging page) { //신고된트래시리스트 가져오는데 보드를 가져온다고?
		return userDao.selectReportList(page);
	}
	
	@Override
	public int updateLoginOK(Map<String, String> map) {
		return userDao.updateLoginOK(map);
	}
	
	@Override
	public int selectMygalListCount(int user_no) {
		return userDao.selectMygalListCount(user_no);
	}
	
	@Override
	public ArrayList<Board> selectMygalList(Map<String, Object> map){
		return userDao.selectMygalList(map);
	}
	
	@Override
	public int selectUserListCount() {
		return userDao.selectUserListCount();
	}
}
