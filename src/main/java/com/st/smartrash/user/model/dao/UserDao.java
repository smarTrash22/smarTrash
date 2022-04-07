package com.st.smartrash.user.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.common.Paging;
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

	public int deleteUser(String user_email) {
		return session.delete("userMapper.deleteUser", user_email);
	}

	public ArrayList<Trash> selectMytrash(int user_no) {
		List<Trash> list = session.selectList("userMapper.selectMytrash", user_no);
		return (ArrayList<Trash>)list;
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

	public ArrayList<User> selectUserList(Paging page) {
		List<User> list = session.selectList("userMapper.selectUserList", page);
		return (ArrayList<User>)list;
	}

	public ArrayList<Board> selectReportList(Paging page) {
		List<Board> list = session.selectList("userMapper.selectReportList", page);
		return (ArrayList<Board>)list;
	}

	public int updateLoginOK(Map<String, String> map) {
		return session.update("userMapper.updateLoginOK", map);
	}

	public int selectReportListCount() {
		return session.selectOne("userMapper.getReportListCount");
	}

	public int selectMygalListCount(int user_no) {
		return session.selectOne("userMapper.getMygalListCount", user_no);
	}

	public ArrayList<Board> selectMygalList(Map<String, Object> map) {
		List<Board> list = session.selectList("userMapper.selectMygalList", map);
		return (ArrayList<Board>)list;
	}

	public int selectUserListCount() {
		return session.selectOne("userMapper.selectUserListCount");
	}
	
}
