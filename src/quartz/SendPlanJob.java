package quartz;
import java.util.Date;

import javax.jms.JMSException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.interstellarexploration.remoteobs.asputil.amq.AmqSender;
import com.interstellarexploration.remoteobs.asputil.plangen.PlanCheckExeption;
import com.interstellarexploration.remoteobs.asputil.plangen.PlanFileContent;
import com.interstellarexploration.remoteobs.asputil.plangen.plantarget.NormalPlan;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * <p>
 * This is just a simple job that says "Hello" to the world.
 * </p>
 * 
 * @author Bill Kratzer
 */
public class SendPlanJob implements Job {

    private static Logger _log = LoggerFactory.getLogger(SendPlanJob.class);

    /**
     * <p>
     * Empty constructor for job initilization
     * </p>
     * <p>
     * Quartz requires a public empty constructor so that the
     * scheduler can instantiate the class whenever it needs.
     * </p>
     */
    public SendPlanJob() {
    }

    /**
     * <p>
     * Called by the <code>{@link org.quartz.Scheduler}</code> when a
     * <code>{@link org.quartz.Trigger}</code> fires that is associated with
     * the <code>Job</code>.
     * </p>
     * 
     * @throws JobExecutionException
     *             if there is an exception while executing the job.
     */
    public void execute(JobExecutionContext context)
        throws JobExecutionException {
    	 try {
    		 _log.debug("-------quartz------run---");
    		 AmqSender asender=new AmqSender();
    		 PlanFileContent planFile = new PlanFileContent();
    		 NormalPlan planA = new NormalPlan("M 42", 1,new int[]{1,2},new int[]{1,2},new int[]{1,2});
    		 planFile.getTargetList().add(planA);
			 asender.sender(planFile.toOutString());
			 _log.debug("-------quartz--------"+planFile.toOutString());
		} catch (PlanCheckExeption | ConfigurationException | JMSException e) {
		
			e.printStackTrace();
		}
//    	try {
//			Runtime.getRuntime().exec("notepad");
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
        _log.info("Hello World! - " + new Date());
    }

}
