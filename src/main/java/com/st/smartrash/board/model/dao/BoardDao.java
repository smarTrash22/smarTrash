package com.st.smartrash.board.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.common.Paging;




@Repository("boardDao")
public class BoardDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public int selectListCount() {
		return session.selectOne("boardMapper.getListCount");
	}
	
	public ArrayList<Board> selectList(Paging page) {
		List<Board> list = session.selectList("boardMapper.selectList", page);
		return (ArrayList<Board>)list;
	}

	public Board selectBoard(int board_num) {
		// TODO Auto-generated method stub
		return null;
	}

	public int updateAddReadcount(int board_num) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int insertOriginBoard(Board board) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int insertReply(Board reply) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateOrigin(Board board) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateReply(Board reply) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteBoard(Board board) {
		// TODO Auto-generated method stub
		return 0;
	}
}
