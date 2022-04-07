package com.st.smartrash.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.st.smartrash.board.model.service.BoardService;
import com.st.smartrash.board.model.vo.Board;
import com.st.smartrash.common.Paging;
import com.st.smartrash.trash.model.service.TrashService;
import com.st.smartrash.trash.model.vo.Trash;
import com.st.smartrash.user.model.vo.User;

@Controller
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService boardService;
	
	@Inject
	private TrashService trashService;

	@RequestMapping("boardlist.do")
	public ModelAndView boardListMethod(HttpServletRequest request,
			@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 페이징 계산 처리 ----- 별도의 클래스로 작성해서 사용해도 됨 -----
		int limit = 9; // 한 페이지에 출력할 목록 갯수
		// 페이지 수 계산을 위해 총 목록갯수 조회
		int listCount = boardService.selectListCount();
		// 페이지 수 계산
		// 주의 : 목록이 11개이면, 페이지 수는 2가 됨 (나머지 목록 1개도 출력페이지가 1개 필요함)
		int maxPage = (int) ((double) listCount / limit + 0.9);
		// 현재 페이지가 포함된 페이지 그룹의 시작값 지정 (뷰 아래쪽에 표시할 페이지수를 10개씩 한 경우)
		int startPage = (int) ((double) currentPage / 10 + 0.9);
		// 현재 페이지가 포함된 페이지그룹의 끝값
		int endPage = startPage + 10 - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}

		// 쿼리문에 전달할 현재 페이지에 출력할 목록의 첫행과 끝행 객체 처리
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);

		ArrayList<Board> list = boardService.selectList(paging);

		if (list != null && list.size() > 0) {
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

	// 게시글 상세보기 처리
	@RequestMapping("bdetail.do")
	public ModelAndView boardDetailMethod(ModelAndView mv, @RequestParam("board_no") int board_no,
			@RequestParam(name = "page", required = false) String page) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}
		// 조회수 1증가 처리
		boardService.updateAddReadcount(board_no);

		// 댓글 리스트 저장-------
		ArrayList<Board> list = boardService.selectReplyList(board_no);
		int listCount = boardService.selectReplyCount(board_no);
		// 해당 게시글 조회
		Board board = boardService.selectBoard(board_no);
		if (board != null) {
//				

			// 댓글 리스트보내기
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("board", board);
			mv.addObject("currentPage", currentPage);
			mv.setViewName("board/boardDetailView");
		} else {
			mv.addObject("message", board_no + "번 게시글 조회 실패");
			mv.setViewName("common/error");
		}

		return mv;
	}
	
	@RequestMapping(value = "binsert.do", method = RequestMethod.POST)
	public String insertOriginMethod(HttpServletRequest request, @RequestParam("trash_path") String trash_path, Board board, Model model) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null) {

			Trash trash = trashService.searchTrashPath(trash_path);
			User user = (User)session.getAttribute("loginUser");
			
			board.setTrash_no(trash.getTrash_no());
			board.setUser_no(user.getUser_no());
	
			if (boardService.insertOriginBoard(board) > 0) {
				return "redirect:boardlist.do?page=1";
			} else {
				model.addAttribute("message", board.getBoard_ref() + "번 글에 대한 댓글 등록 실패");
				return "common/error";
			}
		} else {
			ArrayList<Trash> trash_list = trashService.selectTrashNewTop();
			ArrayList<Trash> category_list = trashService.selectTrashNewTop();
			model.addAttribute("trash_list", trash_list);
			model.addAttribute("category_list", category_list);
			return "common/main";
		}
	}
	
	
	@RequestMapping(value = "breply.do", method = RequestMethod.POST)
	public String replyInsertMethod(Board reply, @RequestParam("board_ref") int board_ref,
			@RequestParam("user_no") int user_no, @RequestParam("page") int page,
			@RequestParam("board_content") String board_content, Model model) {
		// 해당 댓글에 대한 원글 조회
		if("".equals(board_content)) {
			board_content=" ";
		}
		reply.setBoard_ref(board_ref);
		reply.setBoard_content(board_content);
		reply.setUser_no(user_no);

		if (boardService.insertReply(reply) > 0) {
			return "redirect:bdetail.do?board_no=" + board_ref + "&page=" + page;
		} else {
			model.addAttribute("message", reply.getBoard_ref() + "번 글에 대한 댓글 등록 실패");
			return "common/error";
		}
	}

	@RequestMapping("boarddelete.do")
	public String boardDeleteMethod(@RequestParam("board_no") int board_no, Model model) {
		if (boardService.deleteBoard(board_no) > 0) {

			return "redirect:boardlist.do?page=1";
		} else {
			model.addAttribute("message", board_no + "번 글 삭제 실패");
			return "common/error";
		}
	}

	@RequestMapping("replydelete.do")
	public String replyDeleteMethod(Board board, @RequestParam("board_no") int board_no,
			@RequestParam("board_ref") int board_ref, @RequestParam("page") int page, Model model) {
		board.setBoard_no(board_no);
		board.setBoard_ref(board_ref);
		if (boardService.deleteReply(board) > 0) {

			return "redirect:bdetail.do?board_no=" + board_ref + "&page=" + page;
		} else {
			model.addAttribute("message", board_no + "번 글 삭제 실패");
			return "common/error";
		}
	}

	@RequestMapping("bupdate.do")
	public ModelAndView boardUpdatePageMethod(ModelAndView mv, @RequestParam("board_no") int board_no,
			@RequestParam(name = "page", required = false) String page) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 댓글 리스트 저장-------
		ArrayList<Board> list = boardService.selectReplyList(board_no);
		int listCount = boardService.selectReplyCount(board_no);
		// 해당 게시글 조회
		Board board = boardService.selectBoard(board_no);
		if (board != null) {
//					

			// 댓글 리스트보내기
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("board", board);
			mv.addObject("currentPage", currentPage);
			mv.setViewName("board/boardUpdate");
		} else {
			mv.addObject("message", board_no + "번 게시글 조회 실패");
			mv.setViewName("common/error");
		}

		return mv;
	}

	@RequestMapping(value = "boardupdate.do", method = RequestMethod.POST)
	public String boardUpdateMethod(Board board, Model model, @RequestParam("page") int page,
			@RequestParam("board_no") int board_no, @RequestParam("board_content") String board_content) {
		if("".equals(board_content)) {
			board_content=" ";
		}
		board.setBoard_no(board_no);
		board.setBoard_content(board_content);

		if (boardService.updateOrigin(board) > 0) {
			model.addAttribute("page", page);
			model.addAttribute("board_no", board_no);
			return "redirect:bdetail.do";
		} else {
			model.addAttribute("message", "[" + board_no + "]번 게시글 수정 실패");
			return "common/error";
		}
	}

	@RequestMapping(value = "searchHash.do", method = RequestMethod.GET)
	public ModelAndView boardSearchHashtag(HttpServletRequest request, ModelAndView mv) {
		
		String keyword = request.getParameter("hashtag");
		String page = request.getParameter("page");
		
		int currentPage = 1;
//		if (page != null) {
//			currentPage = Integer.parseInt(page);
//		}

		int limit = 9;

		int listCount = boardService.selectSearchListCount(keyword);

		int maxPage = (int) ((double) listCount / limit + 0.9);

		int startPage = (int) ((double) currentPage / 10 + 0.9);

		int endPage = startPage + 10 - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;

		Map<String, Object> map = new HashMap<>();

		map.put("keyword", keyword);
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		ArrayList<Board> list = boardService.selectSearch(map);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			mv.addObject("hashtag", keyword);

			mv.setViewName("board/boardlist");
		} else {
			mv.setViewName("board/boardlist");
		}
		return mv;
	}

}
