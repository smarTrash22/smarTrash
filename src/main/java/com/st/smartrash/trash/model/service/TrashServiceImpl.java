package com.st.smartrash.trash.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.smartrash.common.Paging;
import com.st.smartrash.common.SearchDate;
import com.st.smartrash.common.TrashSet;
import com.st.smartrash.trash.model.dao.TrashDao;
import com.st.smartrash.trash.model.vo.Trash;

@Service("TrashService")
public class TrashServiceImpl implements TrashService {

	@Autowired
	private TrashDao trashDao;

	// 전체 쓰레기 조회
	@Override
	public ArrayList<Trash> trashSelectAll() {
		return trashDao.selectTrashAll();
	}

	// 쓰레기 추가
	@Override
	public ArrayList<Trash> trashInsert(Trash trash) {
		return trashDao.trashInsert(trash);
	}

	// 쓰레기 리스트 카운트
	@Override
	public int selectListCount() {
		return trashDao.selectListCount();
	}
	
	// 쓰레기 페이지 리스트
	@Override
	public ArrayList<Trash> selectList(Paging page) {
		return trashDao.selectList(page);

	}

	// 쓰레기 유저번호로 검색
	@Override
	public ArrayList<Trash> selectSearchUserNo(int keyword) {
		return trashDao.selectSearchUserNo(keyword);
	}

	// 쓰레기 카테고리로 검색
	@Override
	public ArrayList<Trash> selectSearchCategoryNo(int keyword) {
		return trashDao.selectSearchCategoryNo(keyword);
	}

	// 쓰레기 날짜로 검색
	@Override
	public ArrayList<Trash> selectSearchDate(SearchDate date) {
		return trashDao.selectSearchDate(date);
	}

	// 신고된 쓰레기 조회
	@Override
	public ArrayList<Trash> selectSearchReport(String keyword) {
		return trashDao.selectSearchReport(keyword);
	}

	// 최근 쓰레기 조회
	@Override
	public ArrayList<Trash> selectRecentList() {
		return trashDao.selectRecentList();
	}

	// 오늘의 쓰레기 갯수
	@Override
	public int selectTodayCount() {
		return trashDao.selectListCount();
	}
	
	@Override
	public ArrayList<TrashSet> trashDesc(TrashSet trashSet) {
		return trashDao.trashDesc(trashSet);
	}
	
	@Override
	public ArrayList<Trash> selectTrashNewTop() {
		return trashDao.selectTrashNewTop();
	}

	@Override
	public Trash searchTrashPath(String keyword) {
		return trashDao.searchTrashPath(keyword);
	}

	@Override
	public int deleteTrash(int trash_no) {
		return trashDao.deleteTrash(trash_no);
	}
}
