package com.st.smartrash.board.model.service;

import java.util.ArrayList;

import com.st.smartrash.board.model.vo.T_Board;
import com.st.smartrash.common.Paging;
 
public interface T_BoardService {
	int selectListCount();  // 총 게시글 갯수 조회용 (페이지 수 계산용)
	ArrayList<T_Board> selectList(Paging page);  // 한 페이지에 출력할 게시글 조회용
	T_Board selectBoard(int board_no);  // 해당 번호에 대한 게시글 상세 조회용
	int updateAddReadcount(int board_no);  // 상세보기 시에 조회수 1증가 처리용
	int insertOriginBoard(T_Board board);  // 원글 등록용
	int insertReply(T_Board reply);  // 댓글 등록용
	int updateReplySeq(T_Board reply);  // 댓글 등록 시 기존 댓글순번 1증가 처리용
	int updateOrigin(T_Board board);  // 원글 수정용
	int updateReply(T_Board reply);  // 댓글 수정용
	int deleteBoard(T_Board board);  // 게시글 삭제용
}
