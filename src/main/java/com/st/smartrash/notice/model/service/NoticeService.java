package com.st.smartrash.notice.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.st.smartrash.common.Paging;
import com.st.smartrash.common.SearchDate;
import com.st.smartrash.notice.model.vo.Notice;

public interface NoticeService {
	
	ArrayList<Notice> selectList(Paging page);
	Notice selectNotice(int notice_no);
	int selectListCount();
	int selectSearchListCount(String keyword);
	int insertNotice(Notice notice);
	int updateNotice(Notice notice);
	int deleteNotice(int notice_no);
	int addReadcount(int notice_no);
	ArrayList<Notice> selectNewTop3();
	ArrayList<Notice> selectSearch(Map<String, Object> map);
}
