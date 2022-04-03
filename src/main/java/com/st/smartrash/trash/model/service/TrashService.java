package com.st.smartrash.trash.model.service;

import java.sql.Date;
import java.util.ArrayList;

import com.st.smartrash.common.Paging;
import com.st.smartrash.trash.model.vo.Trash;

public interface TrashService {
	// 전체 쓰레기 조회
	ArrayList<Trash> selectTrashAll();

	// 쓰레기 추가
	ArrayList<Trash> trashInsert(Trash trash);

	// 총 쓰레기 갯수 조회용 (페이지 수 계산용)
	int selectListCount(); 
}
