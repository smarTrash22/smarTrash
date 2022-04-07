package com.st.smartrash.user.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.common.Paging;
import com.st.smartrash.trash.model.vo.Trash;
import com.st.smartrash.user.model.vo.User;

public interface UserService {

	String getAccessToken(String code);

	HashMap<String, Object> getUserInfo(String access_Token);

	int insertUser(User user);

	User selectUser(String user_email);

	User dupCheck(String email);

	int updateNick(User user);

	int deleteUser(String user_email);

	ArrayList<Trash> selectMytrash(int user_no);

	int updateAdmin(User user);

	ArrayList<Trash> selectTodayTrash();

	ArrayList<Trash> selectReportTrash();

	ArrayList<Trash> selectTodayReportTrash();

	ArrayList<User> selectUserList(Paging page);

	int selectReportListCount();

	ArrayList<Board> selectReportList(Paging page);
	
	int updateLoginOK(User user);

	int selectMygalListCount(int user_no);

	ArrayList<Board> selectMygalList(Map<String, Object> map);

	int selectUserListCount();

}
