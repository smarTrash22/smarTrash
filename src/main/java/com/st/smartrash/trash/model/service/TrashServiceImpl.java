package com.st.smartrash.trash.model.service;

import java.sql.Date;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.smartrash.trash.model.dao.TrashDao;
import com.st.smartrash.trash.model.vo.Trash;

@Service("TrashService")
public class TrashServiceImpl implements TrashService {

	@Autowired
	private TrashDao trashDao;

	@Override
	// 전체 쓰레기 조회
	public ArrayList<Trash> trashSelectAll(Trash trash) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	// 신고된 쓰레기 조회
	public ArrayList<Trash> trashSelectReport(Trash trash) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	// 쓰레기 추가
	public ArrayList<Trash> trashInsert(Trash trash) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	// 쓰레기 삭제
	public ArrayList<Trash> trashDelete(Trash trash) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	// 쓰레기 신고
	public ArrayList<Trash> trashReport(Trash trash) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	// 최근 쓰레기 조회
	public ArrayList<Trash> trashRecentList(Trash trash) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	// 오늘 추가된 쓰레기
	public int trashTodayCount(Trash trash) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	// 유저번호로 쓰레기 검색
	public int trashSelectUserNo(int user_no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	// 카테고리번호로 쓰레기 검색
	public int trashSelectCategoryNo(int category_no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	// 날짜로 쓰레기 검색
	public Date trashSelectDate(Date trash_date) {
		// TODO Auto-generated method stub
		return null;
	}

}
