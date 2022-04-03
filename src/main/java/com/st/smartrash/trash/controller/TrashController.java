package com.st.smartrash.trash.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.st.smartrash.common.Paging;
import com.st.smartrash.trash.model.service.TrashService;
import com.st.smartrash.trash.model.vo.Trash;

@Controller
public class TrashController {

	private static final Logger logger = LoggerFactory.getLogger(TrashController.class);

	@Autowired
	private TrashService TrashService;

	// 쓰레기 등록
	@RequestMapping(value = "trashInsert.do", method = RequestMethod.POST)
	public String trashInsertMethod(Trash trash, HttpServletRequest request, Model model,
			@RequestParam(name = "upfile", required = false) MultipartFile mfile) {
		// 업로드된 파일 저장 폴더 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/trash_upfiles");

		// 첨부파일이 있을때만 업로드된 파일을 지정 폴더로 옮기기
		if (!mfile.isEmpty()) {
			String fileName = mfile.getOriginalFilename();
			// 이름바꾸기 처리 : 년월일시분초.확장자
			if (fileName != null && fileName.length() > 0) {
				// 바꿀 파일명에 대한 문자열 만들기
				// 공지글 등록 요청시점의 날짜정보를 이용함
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				// 변경할 파일이름 만들기
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				// 원본파일의 확장자를 추출해서 변경 파일명에 붙여줌
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);

				trash.setTrash_path(renameFileName);

				// 파일 객체 만들기
				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);

				// 업로드 파일 저장시키고 바로 이름 바꾸기 실행함
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장 실패");
					return "common/error";
				}

			}
		} // 첨부파일이 있을때만

		if (TrashService.trashInsert(trash) != null) { // 새 공지글 등록 성공시
			model.addAttribute("message", "새 쓰레기 등록 성공!");
			return "trash/trashInsert";
		} else {
			model.addAttribute("message", "새 쓰레기 등록 실패!");
			return "common/error";
		}
	}

	// 쓰레기 전체조회
	@RequestMapping("trash.do")
	public String selectTrashAllMethod(Model model) {
		ArrayList<Trash> list = TrashService.selectTrashAll();
		model.addAttribute("list", list);
		return "trash/trashListView";
	}
}
