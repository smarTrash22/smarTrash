package com.st.smartrash.trash.model.service;

import java.sql.Date;
import java.util.ArrayList;

import com.st.smartrash.common.Paging;
import com.st.smartrash.common.SearchDate;
import com.st.smartrash.trash.model.vo.Trash;

public interface TrashService {
	// 전체 쓰레기 조회
	ArrayList<Trash> trashSelectAll();

	// 쓰레기 추가
	ArrayList<Trash> trashInsert(Trash trash);

	// 총 쓰레기 갯수 조회용 (페이지 수 계산용)
	int selectListCount();

	// 쓰레기 페이지 리스트(한 페이지에 출력할 게시글 조회용)
	ArrayList<Trash> selectList(Paging page);

	// 쓰레기 유저번호로 검색
	ArrayList<Trash> selectSearchUserNo(int keyword);

	// 쓰레기 카테고리 번호로 검색
	ArrayList<Trash> selectSearchCategoryNo(int keyword);

	// 쓰레기 날짜로 검색
	ArrayList<Trash> selectSearchDate(SearchDate date);

	// 신고된 쓰레기 검색
	ArrayList<Trash> selectSearchReport(String keyword);
	
	// 최근 쓰레기 조회
	ArrayList<Trash> selectRecentList();
	
	// 오늘의 쓰레기 갯수
	int selectTodayCount();
}
