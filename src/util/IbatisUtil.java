package util;

import java.io.IOException;
import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class IbatisUtil {
	public static SqlMapClient sqlMapClient = null;
    static {
        try {
            //º”‘ÿ≈‰÷√Œƒº˛
            Reader reader = Resources.getResourceAsReader("SqlMapConfig.xml");
            sqlMapClient=SqlMapClientBuilder.buildSqlMapClient(reader);
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private IbatisUtil() {
    }

}
