package domain.dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import domain.model.Eqpment;
import util.IbatisUtil;

public class SqlMapClientDaoSupport {
	SqlMapClient sqlMapClient = IbatisUtil.sqlMapClient;

	SqlMapClient getSqlMapClientTemplate(){
		
		return sqlMapClient;
	}
}
