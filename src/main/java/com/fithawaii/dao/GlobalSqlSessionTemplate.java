package com.fithawaii.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

/*
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
*/

public class GlobalSqlSessionTemplate {
/*
	private final int STACKTRACE_LINE_LIMIT = 10;
	private final String DB_PREFIX = "fit";

	private final Logger logger = LoggerFactory.getLogger(GlobalSqlSessionTemplate.class);

	private HashMap<String, SqlSessionTemplate> sqlSessionTemplateMap;

	public void setSqlSessionTemplateMap(HashMap<String, SqlSessionTemplate> sqlsessionTemplateMap) {
		this.sqlSessionTemplateMap = sqlsessionTemplateMap;
	}

	public SqlSessionTemplate getSqlSession(String key) {
		if (sqlSessionTemplateMap.containsKey(key)) {
			return sqlSessionTemplateMap.get(key);
		}

		logStackTrace(key);
		return null;
	}

	public List<String> getDistributedDBIDList() {
		Set<String> dbids = sqlSessionTemplateMap.keySet();

		if (CollectionUtils.isEmpty(dbids)) {
			return null;
		}

		List<String> distributedDBIDList = new ArrayList<String>();
		for (String dbid : dbids) {
			if (StringUtils.startsWith(dbid, DB_PREFIX) == false) {
				continue;
			}

			String dbNum = StringUtils.remove(dbid, DB_PREFIX);
			if (NumberUtils.isDigits(dbNum)) {
				distributedDBIDList.add(dbid);
			}
		}

		return distributedDBIDList;
	}

	private void logStackTrace(String key) {
		logger.info("Not find key : [{}]", key);

		Thread th = Thread.currentThread();

		if (th == null) {
			logger.error("Fail to Thread.currentThread()!");
			return;
		}

		StackTraceElement[] elements = th.getStackTrace();
		if (ArrayUtils.isEmpty(elements)) {
			logger.error("Fail to th.getStackTrace()!");
			return;
		}

		for (int i = 0; i < STACKTRACE_LINE_LIMIT && i < elements.length; i++) {
			StackTraceElement element = elements[i];
			if (StringUtils.isNotEmpty(element.getFileName())) {
				logger.info("\tat {}.{}({}:{})", element.getClassName(), element.getMethodName(), element.getFileName(), element.getLineNumber());
			} else {
				logger.info("\tat {}.{}", element.getClassName(), element.getMethodName());
			}
		}
	}
*/
}
