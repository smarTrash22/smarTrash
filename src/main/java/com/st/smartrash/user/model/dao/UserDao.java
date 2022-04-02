package com.st.smartrash.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.user.model.vo.User;

@Repository("userDao")
public class UserDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public UserDao() {}

	public int insertUser(User user) {
		return session.insert("userMapper.insertUser", user);
	}
	
	
}
