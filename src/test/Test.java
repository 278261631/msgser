package test;

import java.sql.SQLException;

import domain.dao.EqpmentDAO;
import domain.dao.EqpmentDAOImpl;

public class Test {
	public static void main(String[] args) {
//        User user=new User();
//        user.setUsername("ÕÅÈý");
//        user.setPassword("123456");
//        UserDao userDao=new UserDao();
//        userDao.addUser(user);
//        
//        User user2=userDao.getUser(1);
//        System.out.println(user2.getUsername());
        
        
        EqpmentDAO dao=new EqpmentDAOImpl();
        try {
			System.out.println(dao.countByExample(null));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	
	
	public void testSqlite(){
		
	}
}
