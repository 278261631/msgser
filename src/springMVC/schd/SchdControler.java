package springMVC.schd;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.dao.EqpmentDAO;
import domain.dao.EqpmentDAOImpl;
import domain.dao.EventDAO;
import domain.dao.EventDAOImpl;
import domain.model.Eqpment;
import domain.model.EqpmentExample;
import domain.model.Event;
import domain.model.EventExample;
import util.JsonGen;

@Controller
@RequestMapping("/schd")
public class SchdControler {
	
//	@RequestMapping("/home")
//	public String hello(){
//		return "/schd/home";
//	}
    //pass the parameters to front-end
    @RequestMapping("/home")
    public String showSchdHome(Map<String,Object> map) throws SQLException{
    	EqpmentDAO dao=new EqpmentDAOImpl();
		EventDAO evtdao=new EventDAOImpl();
		String resString="";
		String envString="";
		EqpmentExample example = new EqpmentExample();
		System.out.println(dao.countByExample(example));
		List<Eqpment> eqlist=dao.selectByExample(example);
		EventExample evtExample =new EventExample();
		List<Event> events=evtdao.selectByExample(evtExample);
		/* for(int i = 0 ;i<eqlist.size();i++){
			Eqpment item=(Eqpment)eqlist.get(i);
			
		} */
		resString = JsonGen.GenResourcesListJson(eqlist);
		envString  = JsonGen.GenEventListJson(events);
		map.put("resString", resString);
		map.put("envString", envString);
		System.out.println(resString);
		System.out.println(envString);
        return "/schd/home";
    }
	
	@ResponseBody
    @RequestMapping("/getschd")
    public  Map<String,String> getschd() throws SQLException{
		Map<String, String> resultMap=new HashMap<String, String>();
		EqpmentDAO dao=new EqpmentDAOImpl();
		EventDAO evtdao=new EventDAOImpl();
		String resString="";
		String envString="";
		EqpmentExample example = new EqpmentExample();
		System.out.println(dao.countByExample(example));
		List<Eqpment> eqlist=dao.selectByExample(example);
		EventExample evtExample =new EventExample();
		List<Event> events=evtdao.selectByExample(evtExample);
		/* for(int i = 0 ;i<eqlist.size();i++){
			Eqpment item=(Eqpment)eqlist.get(i);
			
		} */
		resString = JsonGen.GenResourcesListJson(eqlist);
		envString  = JsonGen.GenEventListJson(events);
		resultMap.put("resString", resString);
		resultMap.put("envString", envString);
//		System.out.println(resultMap);
		
		return resultMap;
    }
	
	@ResponseBody
	@RequestMapping("/updateEvent")
	public  Event updateEvent(Event env) throws SQLException{
		EventDAO evtdao=new EventDAOImpl();
//		evtdao.insert(env);
		evtdao.updateByPrimaryKey(env);
		
		return env;
	}
		
    @RequestMapping("/getajax")
    public void getPerson(String name,PrintWriter pw){
        pw.write("hello,"+name);        
    }
		
}
