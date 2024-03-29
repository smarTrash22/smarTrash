package com.st.smartrash.notice.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.smartrash.common.Paging;
import com.st.smartrash.common.SearchDate;
import com.st.smartrash.notice.model.dao.NoticeDao;
import com.st.smartrash.notice.model.vo.Notice;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public ArrayList<Notice> selectList(Paging page) {
		return noticeDao.selectList(page);
	}

	@Override
	public Notice selectNotice(int notice_no) {
		return noticeDao.selectOne(notice_no);
	}

	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(notice);
	}

	@Override
	public int updateNotice(Notice notice) {
		return noticeDao.updateNotice(notice);
	}

	@Override
	public int deleteNotice(int notice_no) {
		return noticeDao.deleteNotice(notice_no);
	}

	@Override
	public ArrayList<Notice> selectNewTop3() {
		return noticeDao.selectNewTop3();
	}

	@Override
	public int selectListCount() {
		return noticeDao.selectListCount();
	}

	@Override
	public int addReadcount(int notice_no) {
		return noticeDao.addReadCount(notice_no);
	}

	@Override
	public ArrayList<Notice> selectSearch(Map<String, Object> map) {
		return noticeDao.selectSearch(map);
	}

	@Override
	public int selectSearchListCount(Map<String, String> map) {
		return noticeDao.selectSearchListCount(map);
	}

}
