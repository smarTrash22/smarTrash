package com.st.smartrash.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.st.smartrash.board.model.service.BoardService;
import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.common.Paging;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("boardlist.do")
	public ModelAndView boardListMethod(@RequestParam(name="page", required=false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		// 페이징 계산 처리 ----- 별도의 클래스로 작성해서 사용해도 됨 -----
		int limit = 9;  // 한 페이지에 출력할 목록 갯수
		// 페이지 수 계산을 위해 총 목록갯수 조회
		int listCount = boardService.selectListCount();
		// 페이지 수 계산
		// 주의 : 목록이 11개이면, 페이지 수는 2가 됨 (나머지 목록 1개도 출력페이지가 1개 필요함)
		int maxPage = (int)((double)listCount / limit + 0.9);
		// 현재 페이지가 포함된 페이지 그룹의 시작값 지정 (뷰 아래쪽에 표시할 페이지수를 10개씩 한 경우)
		int startPage = (int)((double)currentPage / 10 + 0.9);
		// 현재 페이지가 포함된 페이지그룹의 끝값
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		// 쿼리문에 전달할 현재 페이지에 출력할 목록의 첫행과 끝행 객체 처리
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		
		// 별도의 클래스 작성 끝 -----
		
		// 서비스 메소드 실행하고 결과받기
		ArrayList<Board> list = boardService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			
			mv.setViewName("board/boardlist");
		} else {
			mv.addObject("message", "[" + currentPage + "]페이지 목록 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	//게시글 상세보기 처리
		@RequestMapping("bdetail.do")
		public ModelAndView boardDetailMethod(ModelAndView mv,@RequestParam("board_no") int board_no, @RequestParam(name="page", required=false) String page) {
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			//조회수 1증가 처리
			boardService.updateAddReadcount(board_no);
			
			//해당 게시글 조회
			Board board = boardService.selectBoard(board_no);
			if(board != null) {
				mv.addObject("board", board);
				mv.addObject("currentPage", currentPage);
				mv.setViewName("board/boardDetailView");
			}else {
				mv.addObject("message", board_no+"번 게시글 조회 실패");
				mv.setViewName("common/error");
			}
			
			return mv;
		}
	
	
}
