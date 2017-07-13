package com.fithawaii.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

//@Repository
public class TestDAO {
	private static final String NAMESPACE = "com.fithawaii.fit.";

	@Autowired
	@Qualifier(value = "globalSqlSessionTemplate.jdbc")
	private GlobalSqlSessionTemplate globalSqlSessionTemplate;


/*
	public List<Map> selectTest() {
		return globalSqlSessionTemplate.getSqlSession("fit").selectList(NAMESPACE + "selectTest");
	}
*/
}
