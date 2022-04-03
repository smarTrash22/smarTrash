package com.st.smartrash.trash.model.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.common.Paging;
import com.st.smartrash.trash.model.vo.Trash;

@Repository("trashDao")
public class TrashDao {

	@Autowired
	private SqlSessionTemplate session;

	public TrashDao() {
	}

	// 전체 쓰레기 조회
	public ArrayList<Trash> selectTrashAll() {
		List<Trash> list = session.selectList("trashMapper.selectTrashAll");
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

}
