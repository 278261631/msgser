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
import domain.model.Eqpment;
import domain.model.EqpmentExample;
import domain.model.Event;
import domain.model.EventExample;
import quartz.SendPlanJob;
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
		Subject currentUser = SecurityUtils.getSubject();
		
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

	@ResponseBody
	@RequestMapping("/addEventPlan")
	public  Event addEventPlan(Event env) throws SQLException , JMSException,ConfigurationException, SchedulerException {
		Logger log = Logger.getLogger(this.getClass());
		log.debug("-----startTime--------" + env.getStarttime());
		EventDAO evtdao=new EventDAOImpl();
	    log.info("------- Initializing ----------------------");
	    SchedulerFactory sf = new StdSchedulerFactory();
	    Scheduler sched = sf.getScheduler();
//	    Date runTime = evenMinuteDate(new Date());
	    Date runTime =   DateBuilder.futureDate(10, IntervalUnit.SECOND);
	    log.info("------- Scheduling Job  -------------------");
	    JobDetail job = newJob(SendPlanJob.class).withIdentity("job1", "group1").build();
	    // Trigger the job to run on the next round minute
	    Trigger trigger = newTrigger().withIdentity("trigger1", "group1").startAt(runTime).build();

	    // Tell quartz to schedule the job using our trigger
	    sched.scheduleJob(job, trigger);
	    log.info(job.getKey() + " will run at: " + runTime);
	    sched.start();
	    log.info("------- Started Scheduler -----------------");

		
		

		return env;
	}
		
    @RequestMapping("/getajax")
    public void getPerson(String name,PrintWriter pw){
        pw.write("hello,"+name);        
    }
		
}
