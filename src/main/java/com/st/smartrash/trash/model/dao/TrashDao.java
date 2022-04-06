package com.st.smartrash.trash.model.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.common.Paging;
import com.st.smartrash.common.SearchDate;
import com.st.smartrash.common.TrashSet;
import com.st.smartrash.trash.model.vo.Trash;

@Repository("trashDao")
public class TrashDao {

	@Autowired
	private SqlSessionTemplate session;

	public TrashDao() {
	}

	// 전체 쓰레기 조회
	public ArrayList<Trash> selectTrashAll() {
		List<Trash> list = session.selectList("trashMapper.trashSelectAll");
		return (ArrayList<Trash>) list;
	}

	// 쓰레기 추가
	public ArrayList<Trash> trashInsert(Trash trash) {
		List<Trash> list = session.selectList("trashMapper.trashInsert", trash);
		return (ArrayList<Trash>) list;
	}

	// 총 쓰레기 갯수 조회용 (페이지 수 계산용)
	public int selectListCount() {
		return session.selectOne("trashMapper.getListCount");
	}

	// 쓰레기 페이지 처리 리스트
	public ArrayList<Trash> selectList(Paging page) {
		List<Trash> list = session.selectList("trashMapper.selectList", page);
		return (ArrayList<Trash>) list;
	}

	// 쓰레기 유저번호로 검색
	public ArrayList<Trash> selectSearchUserNo(int keyword) {
		List<Trash> list = session.selectList("trashMapper.searchUserNo", keyword);
		return (ArrayList<Trash>) list;
	}

	// 쓰레기 카테고리 번호로 검색
	public ArrayList<Trash> selectSearchCategoryNo(int keyword) {
		List<Trash> list = session.selectList("trashMapper.searchCategoryNo", keyword);
		return (ArrayList<Trash>) list;
	}

	// 쓰레기 날짜로 검색
	public ArrayList<Trash> selectSearchDate(SearchDate date) {
		List<Trash> list = session.selectList("trashMapper.searchDate", date);
		return (ArrayList<Trash>) list;
	}
	
	// 쓰레기 파일 이름으로 검색
	public Trash searchTrashPath(String keyword) {
		return session.selectOne("trashMapper.searchTrashPath", keyword);
	}

	// 신고된 쓰레기 검색
	public ArrayList<Trash> selectSearchReport(String keyword) {
		List<Trash> list = session.selectList("trashMapper.searchReport", keyword);
		return (ArrayList<Trash>) list;
	}
	
	// 쓰레기 삭제
	public int deleteTrash(int trash_no) {
		return session.delete("trashMapper.deleteTrash", trash_no);
	}

	// 최근 업로드 쓰레기 출력(사진) - 구현중
	public ArrayList<Trash> selectRecentList() {
		List<Trash> list = session.selectList("trashMapper.selectRecentList");
		return (ArrayList<Trash>) list;
	}

	// 오늘의 쓰레기 갯수
	public int selectTodayCount() {
		return session.selectOne("trashMapper.selectTodayCount");
	}
	
	// 쓰레기 페이지 처리 리스트
	public ArrayList<TrashSet> trashDesc(TrashSet trashSet) {
		List<TrashSet> list = session.selectList("trashMapper.trashDesc", trashSet);
		return (ArrayList<TrashSet>) list;
	}
	
	// 메인페이지 최근 분류한 쓰레기
	public ArrayList<Trash> selectTrashNewTop() {
		List<Trash> list =  session.selectList("trashMapper.selectTrashNewTop");
		return (ArrayList<Trash>) list;
	}
}
