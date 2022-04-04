package com.st.smartrash.user.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.trash.model.vo.Trash;
import com.st.smartrash.user.model.vo.User;

@Repository("userDao")
public class UserDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public UserDao() {}

	public int insertUser(User user) {
		return session.insert("userMapper.insertUser", user);
	}

	public User selectUser(String user_email) {
		return session.selectOne("userMapper.selectUser", user_email);
	}

	public User dupCheck(String user_email) {
		return session.selectOne("userMapper.dupCheck", user_email);
	}

	public int updateNick(User user) {
		return session.update("userMapper.updateNick", user);
	}

	public int deleteUser(int user_no) {
		return session.delete("userMapper.deleteUser", user_no);
	}

	public ArrayList<Trash> selectLatest5(int user_no) {
		List<Trash> list = session.selectList("userMapper.selectLatest5", user_no);
		return (ArrayList<Trash>)list;
	}

	public ArrayList<Board> selectMygal5(int user_no) {
		List<Board> list = session.selectList("userMapper.selectMygal5", user_no);
		return (ArrayList<Board>)list;
	}

	public int updateAdmin(User user) {
		return session.update("userMapper.updateAdmin", user);
	}

	public ArrayList<Trash> selectTodayTrash() {
		List<Trash> list = session.selectList("userMapper.selectTodayTrash");
		return (ArrayList<Trash>)list;
	}

	public ArrayList<Trash> selectReportTrash() {
		List<Trash> list = session.selectList("userMapper.selectReportTrash");
		return (ArrayList<Trash>)list;
	}

	public ArrayList<Trash> selectTodayReportTrash() {
		List<Trash> list = session.selectList("userMapper.selectTodayReportTrash");
		return (ArrayList<Trash>)list;
	}
	
	
}
