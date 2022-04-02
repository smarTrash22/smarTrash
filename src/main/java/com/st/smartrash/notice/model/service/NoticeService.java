package com.st.smartrash.notice.model.service;

import java.util.ArrayList;

import com.st.smartrash.common.Paging;
import com.st.smartrash.common.SearchDate;
import com.st.smartrash.notice.model.vo.Notice;

public interface NoticeService {
	
	ArrayList<Notice> selectList(Paging page);
	Notice selectNotice(int noticeno);
	int selectListCount();
	int insertNotice(Notice notice);
	int updateNotice(Notice notice);
	int deleteNotice(int noticeno);
	ArrayList<Notice> selectNewTop3();
	ArrayList<Notice> selectSearchTitle(String keyword);
	ArrayList<Notice> selectSearchWriter(String keyword);
	ArrayList<Notice> selectSearchDate(SearchDate date);
}
