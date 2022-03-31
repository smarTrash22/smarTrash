package com.st.smartrash.board.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.board.model.vo.T_Board;
import com.st.smartrash.common.Paging;

@Repository("boardDao")
public class T_BoardDao {
	@Autowired
	private SqlSessionTemplate session;


	public int selectListCount() {
		return session.selectOne("boardMapper.getListCount");
	}
    
	public ArrayList<T_Board> selectList(Paging page) {
		List<T_Board> list = session.selectList("boardMapper.selectList", page);
		return (ArrayList<T_Board>)list;
	}

	public T_Board selectBoard(int board_no) {
		return session.selectOne("boardMapper.selectBoard", board_no);
	}

	public int updateAddReadcount(int board_no) {
		return session.update("boardMapper.addReadCount", board_no);
	}

	public int insertOriginBoard(T_Board board) {
		return session.insert("boardMapper.insertOriginBoard", board);
	}

	public int insertReply(T_Board reply) {
		int result = 0;
		
		if(reply.getBoard_lev() == 2) {  // 댓글이면
			result = session.insert("boardMapper.insertReply1", reply);
		}
		if(reply.getBoard_lev() == 3) {  // 대댓글이면
			result = session.insert("boardMapper.insertReply2", reply);
		}
		
		return result;
	}

	public int updateReplySeq(T_Board reply) {
		int result = 0;
		
		if(reply.getBoard_lev() == 2) {  // 댓글이면
			result = session.update("boardMapper.updateReplySeq1", reply);
		}
		if(reply.getBoard_lev() == 3) {  // 대댓글이면
			result = session.update("boardMapper.updateReplySeq2", reply);
		}
		
		return result;
	}

	public int updateOrigin(T_Board board) {
		return session.update("boardMapper.updateOrigin", board);
	}

	public int updateReply(T_Board reply) {
		return session.update("boardMapper.updateReply", reply);
	}

	public int deleteBoard(T_Board board) {
		return session.delete("boardMapper.deleteBoard", board);
	}
}

