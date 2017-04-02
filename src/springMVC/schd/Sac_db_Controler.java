package springMVC.schd;

import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
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
	@RequestMapping("/searchsac")
	public  List searchsac(String star_name) throws SQLException{
		star_name=star_name == null ? "" :star_name.trim();
		star_name=star_name.replace(' ', '%');
		star_name="%"+star_name+"%";
		Sac_deepskyDAO deepSkyDao=new Sac_deepskyDAOImpl();
//		Sac_deepskyExample example = new Sac_deepskyExample();
//		example.createCriteria().andObjectLike(star_name).;
//		example.or(example.createCriteria().andOtherLike(star_name));

		
		 List result =deepSkyDao. getSqlMapClientTemplate().queryForList("sac_deepsky.abatorgenerated_selectByExample", example);
		return result;
	}

		
		
}
