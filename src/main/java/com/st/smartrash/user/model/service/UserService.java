package com.st.smartrash.user.model.service;

import java.util.HashMap;

public interface UserService {

	String getAccessToken(String code);

	HashMap<String, Object> getUserInfo(String access_Token);

}
