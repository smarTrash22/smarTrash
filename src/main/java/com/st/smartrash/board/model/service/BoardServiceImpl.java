package com.st.smartrash.board.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.smartrash.board.model.dao.BoardDao;
import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.common.Paging;


@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public int selectListCount() {
		return boardDao.selectListCount();
	}
	
	@Override
	public ArrayList<Board> selectList(Paging page) {
		return boardDao.selectList(page);
	}

	@Override
	public Board selectBoard(int board_no) {
		return boardDao.selectBoard(board_no);
	}

	@Override
	public int updateAddReadcount(int board_no) {
		return boardDao.updateAddReadcount(board_no);
	}

	@Override
	public int insertOriginBoard(Board board) {
		return boardDao.insertOriginBoard(board);
	}

	@Override
	public int insertReply(Board reply) {
		return boardDao.insertReply(reply);
	}

	@Override
	public int updateOrigin(Board board) {
		return boardDao.updateOrigin(board);
	}

	@Override
	public int updateReply(Board reply) {
		return boardDao.updateReply(reply);
	}

	@Override
	public int deleteBoard(int board_no) {
		return boardDao.deleteBoard(board_no);
	}

	@Override
	public ArrayList<Board> selectReplyList(int board_no) {
		return boardDao.selectReplyList(board_no);
	}

	@Override
	public int selectReplyCount(int board_no) {
		return boardDao.selectReplyCount(board_no);
	}

	@Override
	public int deleteReply(Board board) {
		return boardDao.deleteReply(board);
	}
//
//	@Override
//	public ArrayList<Board> selectSearchHashtag(String hashtag) {
//		return boardDao.selectSearchHashtag(hashtag);
//	}

	@Override
	public ArrayList<Board> selectSearch(Map<String, Object> map) {
		return boardDao.selectSearch(map);
	}


	@Override
	public int selectSearchListCount(String keyword) {
		// TODO Auto-generated method stub
		return boardDao.selectSearchListCount(keyword);
	}

}
