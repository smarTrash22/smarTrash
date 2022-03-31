package com.st.smartrash.board.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.smartrash.board.model.dao.T_BoardDao;
import com.st.smartrash.board.model.vo.T_Board;
import com.st.smartrash.common.Paging;

@Service("t_BoardService")
public class T_BoardServiceImpl implements T_BoardService {
	@Autowired
	private T_BoardDao boardDao;
 
	@Override
	public int selectListCount() {
		return boardDao.selectListCount();
	}

	@Override
	public ArrayList<T_Board> selectList(Paging page) {
		return boardDao.selectList(page);
	}

	@Override
	public T_Board selectBoard(int board_no) {
		return boardDao.selectBoard(board_no);
	}

	@Override
	public int updateAddReadcount(int board_no) {
		return boardDao.updateAddReadcount(board_no);
	}

	@Override
	public int insertOriginBoard(T_Board board) {
		return boardDao.insertOriginBoard(board);
	}

	@Override
	public int insertReply(T_Board reply) {
		return boardDao.insertReply(reply);
	}

	@Override
	public int updateReplySeq(T_Board reply) {
		return boardDao.updateReplySeq(reply);
	}

	@Override
	public int updateOrigin(T_Board board) {
		return boardDao.updateOrigin(board);
	}

	@Override
	public int updateReply(T_Board reply) {
		return boardDao.updateReply(reply);
	}

	@Override
	public int deleteBoard(T_Board board) {
		return boardDao.deleteBoard(board);
	}

}