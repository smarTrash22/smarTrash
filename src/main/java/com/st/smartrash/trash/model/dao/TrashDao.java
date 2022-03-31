package com.st.smartrash.trash.model.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.trash.model.vo.Trash;

@Repository("trashDao")
public class TrashDao {

	@Autowired
	private SqlSessionTemplate session;

	public TrashDao() {
	}

	// 전체 쓰레기 조회
	public ArrayList<Trash> trashSelectAll(Trash trash) {
		List<Trash> list = session.selectList("TrashMapper.trashSelectAll");
		return (ArrayList<Trash>) list;
	}

	// 신고된 쓰레기 조회
	public ArrayList<Trash> trashSelectReport(Trash trash) {
		List<Trash> list = session.selectList("TrashMapper.trashSelectReport", trash);
		return (ArrayList<Trash>) list;
	}

	// 쓰레기 추가
	public ArrayList<Trash> trashInsert(Trash trash) {
		List<Trash> list = session.selectList("TrashMapper.trashInsert", trash);
		return (ArrayList<Trash>) list;
	}

	// 쓰레기 삭제
	public ArrayList<Trash> trashDelete(Trash trash) {
		List<Trash> list = session.selectList("TrashMapper.trashDelete", trash);
		return (ArrayList<Trash>) list;
	}

	// 쓰레기 신고
	public ArrayList<Trash> trashReport(Trash trash) {
		List<Trash> list = session.selectList("TrashMapper.trashReport", trash);
		return (ArrayList<Trash>) list;
	}

	// 최근 쓰레기 조회
	public ArrayList<Trash> trashRecentList(Trash trash) {
		List<Trash> list = session.selectList("TrashMapper.trashRecentList", trash);
		return (ArrayList<Trash>) list;
	}

	// 오늘 추가된 쓰레기
	public int trashTodayCount(Trash trash) {
		return session.selectOne("TrashMapper.insertTrash", trash);
	}

	// 유저번호로 쓰레기 검색
	public int trashSelectUserNo(int user_no) {
		return session.selectOne("TrashMapper.updateTrash", user_no);
	}

	// 카테고리번호로 쓰레기 검색
	public int trashSelectCategoryNo(int trash_category) {
		return session.selectOne("TrashMapper.trashSelectCategoryNo", trash_category);
	}

	// 날짜로 쓰레기 검색
	public Date trashSelectDate(Date trash_date) {
		return session.selectOne("TrashMapper.trashSelectDate", trash_date);
	}

}
