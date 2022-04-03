package com.st.smartrash.board.model.service;

import java.util.ArrayList;

import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.common.Paging;

public interface BoardService {
	int selectListCount();  // 총 게시글 갯수 조회용 (페이지 수 계산용)
	ArrayList<Board> selectList(Paging page);  // 한 페이지에 출력할 게시글 조회용
	Board selectBoard(int board_no);  // 해당 번호에 대한 게시글 상세 조회용
	int updateAddReadcount(int board_no);  // 상세보기 시에 조회수 1증가 처리용
	int insertOriginBoard(Board board);  // 원글 등록용
	int insertReply(Board reply);  // 댓글 등록용
	int updateOrigin(Board board);  // 원글 수정용
	int updateReply(Board reply);  // 댓글 수정용
	int deleteBoard(Board board);  // 게시글 삭제용
}
