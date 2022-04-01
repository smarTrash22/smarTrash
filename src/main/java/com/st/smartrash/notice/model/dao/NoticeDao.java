package com.st.smartrash.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.st.smartrash.common.SearchDate;
import com.st.smartrash.notice.model.vo.Notice;

@Repository("noticeDao")
public class NoticeDao {
	// 스프링-마이바티스 연동 객체 사용 : root-context.xml에 선언되어 있음
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<Notice> selectList() {
		List<Notice> list = session.selectList("noticeMapper.selectAll");
		return (ArrayList<Notice>)list;
	}

}
