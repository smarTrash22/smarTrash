package com.st.smartrash.user.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.trash.model.vo.Trash;
import com.st.smartrash.user.model.vo.User;

public interface UserService {

	String getAccessToken(String code);

	HashMap<String, Object> getUserInfo(String access_Token);

	int insertUser(User user);

	User selectUser(String user_email);

	User dupCheck(String email);

	int updateNick(User user);

	int deleteUser(int user_no);

	ArrayList<Trash> selectLatest5(int user_no);

	ArrayList<Board> selectMygal5(int user_no);

}
