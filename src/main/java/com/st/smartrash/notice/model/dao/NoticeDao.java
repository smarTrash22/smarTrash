package com.st.smartrash.notice.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.common.Paging;
import com.st.smartrash.common.SearchDate;
import com.st.smartrash.notice.model.vo.Notice;

@Repository("noticeDao")
public class NoticeDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<Notice> selectList(Paging page) {
		List<Notice> list = session.selectList("noticeMapper.selectList", page);
		return (ArrayList<Notice>)list;
	}

	public Notice selectOne(int notice_no) {
		return session.selectOne("noticeMapper.selectNotice", notice_no);
	}

	public int insertNotice(Notice notice) {
		return session.insert("noticeMapper.insertNotice", notice);
	}

	public int updateNotice(Notice notice) {
		return session.update("noticeMapper.updateNotice", notice);
	}

	public int deleteNotice(int notice_no) {
		return session.delete("noticeMapper.deleteNotice", notice_no);
	}

	public ArrayList<Notice> selectNewTop3() {
		List<Notice> list = session.selectList("noticeMapper.selectNewTop3");
		return (ArrayList<Notice>)list;
	}

	public int selectListCount() {
		return session.selectOne("noticeMapper.getListCount");
	}

	public int addReadCount(int notice_no) {
		return session.update("noticeMapper.addReadCount", notice_no);
	}

	public ArrayList<Notice> selectSearch(Map<String, Object> map) {
		List<Notice> list = session.selectList("noticeMapper.searchNotice", map);
		return (ArrayList<Notice>)list;
	}

	public int selectSearchListCount(String keyword) {
		return session.selectOne("noticeMapper.getSearchListCount", keyword);
	}
}
