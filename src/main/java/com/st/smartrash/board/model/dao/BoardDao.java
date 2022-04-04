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
	
	public int selectReplyCount(int board_no) {
		return session.selectOne("boardMapper.getReplyCount", board_no);
	}
	
	public ArrayList<Board> selectList(Paging page) {
		List<Board> list = session.selectList("boardMapper.selectList", page);
		return (ArrayList<Board>)list;
	}

	public Board selectBoard(int board_no) {
		return session.selectOne("boardMapper.selectBoard", board_no);
	}

	public int updateAddReadcount(int board_num) {
		return session.update("boardMapper.addReadCount", board_num);
	}
	
	public ArrayList<Board> selectReplyList(int board_no){
		List<Board> list = session.selectList("boardMapper.selectReplyList",board_no);
		return (ArrayList<Board>)list;
	}

	public int insertOriginBoard(Board board) {
		return 0;
	}

	public int insertReply(Board reply) {
		return session.insert("boardMapper.insertReply1", reply);
	}

	public int updateOrigin(Board board) {
		return 0;
	}

	public int updateReply(Board reply) {
		return 0;
	}

	public int deleteBoard(Board board) {
		return 0;
	}
}
