package springtask;
import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;

import java.util.Date;
import java.util.List;

import org.quartz.DateBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.DateBuilder.IntervalUnit;
import org.quartz.impl.StdSchedulerFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;    
import org.springframework.stereotype.Component;

import domain.model.Event;
import quartz.HelloJob;
import quartz.SimpleExample;  
  
@Component("taskJob")  
public class TaskJob {  
	
	List<Event> eventTodayList=null;
	int a=0;
	
    @Scheduled(fixedRate=3600000 )  
    public void ececJob() throws SchedulerException {
        Logger log = LoggerFactory.getLogger(SimpleExample.class);
        SchedulerFactory sf = new StdSchedulerFactory();
        Scheduler sched = sf.getScheduler();
        a++;
        log.info(Integer.toString(a));
        log.info("------- Run Spring Task ----------------------"+new Date());
//        Date runTime =   DateBuilder.nextGivenSecondDate(null, 15);;
        Date runTime =   DateBuilder.futureDate(7, IntervalUnit.SECOND);

        JobDetail job = newJob(HelloJob.class).withIdentity("job1", "group1").build();

        Trigger trigger = newTrigger().withIdentity("trigger1", "group1").startAt(runTime).build();

        // Tell quartz to schedule the job using our trigger
        sched.scheduleJob(job, trigger);
        log.info(job.getKey() + " will run at: " + runTime);

        // Start up the scheduler (nothing can actually run until the
        // scheduler has been started)
        sched.start();
        // shut down the scheduler
//        sched.shutdown();
//        sched.shutdown(true);
        log.info("------- Shutdown Complete -----------------");
//        System.out.println("任务执行。。。");  
    }  
    
//    @Scheduled(fixedRate=10000 )  
    public void autoUpdateEvent() {
    	
    	System.out.println("自动任务更新。。。");  
    }  
    
    public void ManualUpdateEvent() {
    	
    	System.out.println("手动任务更新。。。");  
    }  
    
    
}  