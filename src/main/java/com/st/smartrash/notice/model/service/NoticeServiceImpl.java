package com.st.smartrash.notice.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.smartrash.common.SearchDate;
import com.st.smartrash.notice.model.dao.NoticeDao;
import com.st.smartrash.notice.model.vo.Notice;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	private NoticeDao noticeDao;

	@Override
	public ArrayList<Notice> selectAll() {
		return noticeDao.selectList();
	}

}
