package com.st.smartrash.user.model.service;

import java.util.HashMap;

import com.st.smartrash.user.model.vo.User;

public interface UserService {

	String getAccessToken(String code);

	HashMap<String, Object> getUserInfo(String access_Token);

	int insertUser(User user);

}
