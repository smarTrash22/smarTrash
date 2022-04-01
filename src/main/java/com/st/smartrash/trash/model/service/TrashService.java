package com.st.smartrash.trash.model.service;

import java.sql.Date;
import java.util.ArrayList;

import com.st.smartrash.trash.model.vo.Trash;

public interface TrashService {
	// 전체 쓰레기 조회
	ArrayList<Trash> trashSelectAll(Trash trash);

	// 신고된 쓰레기 조회
	ArrayList<Trash> trashSelectReport(Trash trash);

	// 쓰레기 추가
	ArrayList<Trash> trashInsert(Trash trash);

	// 쓰레기 삭제
	ArrayList<Trash> trashDelete(Trash trash);

	// 쓰레기 신고
	ArrayList<Trash> trashReport(Trash trash);

	// 최근 쓰레기 조회
	ArrayList<Trash> trashRecentList(Trash trash);

	// 오늘 추가된 쓰레기
	int trashTodayCount(Trash trash);

	// 유저번호로 쓰레기 검색
	int trashSelectUserNo(int user_no);

	// 카테고리번호로 쓰레기 검색
	int trashSelectCategoryNo(int category_no);

	// 날짜로 쓰레기 검색
	Date trashSelectDate(Date trash_date);
}
