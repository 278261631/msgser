package util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



import domain.model.Eqpment;
import domain.model.JsonResourcesDomain;
import net.sf.json.JSONArray;

public class JsonGen {

	public static String GenResourcesListJson(List<Eqpment> eqp){
		List<JsonResourcesDomain> resourceList=new ArrayList<JsonResourcesDomain>(); 
		if (eqp!=null && eqp.size()>0) {
			for (Eqpment eqpItem : eqp) {
				JsonResourcesDomain resItem=new JsonResourcesDomain();
				resItem.setTitle(eqpItem.getQuipname());				
				resItem.setId(eqpItem.getQuipid().toString());
				resItem.setEventColor(JsonResourcesDomain.EventColors[eqp.indexOf(eqpItem)%JsonResourcesDomain.EventColors.length]);
				resourceList.add(resItem);
			}
		}
		JSONArray jsArr = JSONArray.fromObject(resourceList);
		
		return jsArr.toString();  
	}
	
	public static String GenEventListJson(){
		
		return "";
	}
}
