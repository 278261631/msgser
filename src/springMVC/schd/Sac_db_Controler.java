package springMVC.schd;

import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.jms.JMSException;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.quartz.DateBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.DateBuilder.IntervalUnit;
import org.quartz.impl.StdSchedulerFactory;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.interstellarexploration.remoteobs.asputil.amq.AmqSender;
import com.interstellarexploration.remoteobs.asputil.plangen.PlanCheckExeption;
import com.interstellarexploration.remoteobs.asputil.plangen.PlanFileContent;
import com.interstellarexploration.remoteobs.asputil.plangen.plantarget.NormalPlan;

import domain.dao.EqpmentDAO;
import domain.dao.EqpmentDAOImpl;
import domain.dao.EventDAO;
import domain.dao.EventDAOImpl;
import domain.dao.Sac_deepskyDAO;
import domain.dao.Sac_deepskyDAOImpl;
import domain.model.Eqpment;
import domain.model.EqpmentExample;
import domain.model.Event;
import domain.model.EventExample;
import domain.model.Sac_deepsky;
import domain.model.Sac_deepskyExample;
import domain.model.Sac_deepskyExample.Criteria;
import quartz.HelloJob;
import quartz.SimpleExample;
import util.JsonGen;

@Controller
@RequestMapping("/schd")
public class Sac_db_Controler {
	

	
	@ResponseBody
    @RequestMapping("/getsacdata")
    public  Map<String,String> get_sac_data() throws SQLException{
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
	@RequestMapping("/searchsac_other")
	public  List<Map<String, Object>> searchsac_other(String term) throws SQLException{
		term=term == null ? "" :term.trim();
//		star_name=star_name.replace(' ', '%');
//		star_name="%"+star_name+"%";
		Sac_deepskyDAOImpl deepSkyDao=new Sac_deepskyDAOImpl();
		Sac_deepskyExample example = new Sac_deepskyExample();
		example.createCriteria().andOtherLike('%'+term+'%');
//		example.createCriteria().andObjectLike(term);
//		example.or(example.createCriteria().andOtherLike(term));
		
		 List<Sac_deepsky> daoResult =deepSkyDao. getSqlMapClientTemplate().queryForList("sac_deepsky.abatorgenerated_selectByExample", example, 0, 10);
//		 List result =deepSkyDao. getSqlMapClientTemplate().queryForList("select_sqlmap.select_sac_by_name",example);
		 List<Map<String,Object>> result=new ArrayList<Map<String,Object>>();
		 for (Iterator<Sac_deepsky> iterator = daoResult.iterator(); iterator.hasNext();) {
			Sac_deepsky sac_item = iterator.next();
			Map<String,Object> lable_value=new HashMap<String,Object>();
			lable_value.put("lable", sac_item.getOther());
			lable_value.put("value", sac_item.getOther());
			lable_value.put("ra_value", sac_item.getRa_hr()+"h"+sac_item.getRa_min());
			lable_value.put("dec_value", sac_item.getDec_deg()+"."+sac_item.getDec_min());
			lable_value.put("objvalue", sac_item);
			result.add(lable_value);
		}
		 System.out.println("---------"+result.size());
		return result;
	}	
	
	@ResponseBody
	@RequestMapping("/searchsac_object")
	public  List<Map<String, Object>> searchsac_object(String term) throws SQLException{
		term=term == null ? "" :term.trim();
//		star_name=star_name.replace(' ', '%');
//		star_name="%"+star_name+"%";
		Sac_deepskyDAOImpl deepSkyDao=new Sac_deepskyDAOImpl();
		Sac_deepskyExample example = new Sac_deepskyExample();
		example.createCriteria().andObjectLike('%'+term+'%');
		
		 List<Sac_deepsky> daoResult =deepSkyDao. getSqlMapClientTemplate().queryForList("sac_deepsky.abatorgenerated_selectByExample", example, 0, 10);
//		 List result =deepSkyDao. getSqlMapClientTemplate().queryForList("select_sqlmap.select_sac_by_name",example);
		 List<Map<String,Object>> result=new ArrayList<Map<String,Object>>();
		 for (Iterator<Sac_deepsky> iterator = daoResult.iterator(); iterator.hasNext();) {
			Sac_deepsky sac_item = iterator.next();
			Map<String,Object> lable_value=new HashMap<String,Object>();
			lable_value.put("lable", sac_item.getObject());
			lable_value.put("value", sac_item.getObject());
			lable_value.put("ra_value", sac_item.getRa_hr()+"h"+sac_item.getRa_min());
			lable_value.put("dec_value", sac_item.getDec_deg()+"."+sac_item.getDec_min());
			lable_value.put("objvalue", sac_item);
			result.add(lable_value);
		}
		 System.out.println("---------"+result.size());
		return result;
	}

		
		
}
