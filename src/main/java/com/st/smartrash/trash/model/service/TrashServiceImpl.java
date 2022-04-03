package com.st.smartrash.trash.model.service;

import java.sql.Date;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.smartrash.common.Paging;
import com.st.smartrash.trash.model.dao.TrashDao;
import com.st.smartrash.trash.model.vo.Trash;

@Service("TrashService")
public class TrashServiceImpl implements TrashService {
	
	@Autowired
	private TrashDao trashDao;

	@Override
	// 전체 쓰레기 조회
	public ArrayList<Trash> selectTrashAll() {	
		return trashDao.selectTrashAll();
	}

	@Override
	// 쓰레기 추가
	public ArrayList<Trash> trashInsert(Trash trash) {
		return trashDao.trashInsert(trash);
	}
	
	@Override
	public int selectListCount() {
		return trashDao.selectListCount();
	}

}
