package springMVC;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/mvc")
public class MVCControler {
	
	@RequestMapping("/hello")
	public String hello(){
		return "/test/hello";
	}
	
	@ResponseBody
    @RequestMapping("/getjson")
    public  Map getjson(){
        Map u = new HashMap();
        
        u.put("jayjay","xx");
        u.put("-",1);
        return u;
    }
	
    @RequestMapping("/getajax")
    public void getPerson(String name,PrintWriter pw){
        pw.write("hello,"+name);        
    }
	
}
