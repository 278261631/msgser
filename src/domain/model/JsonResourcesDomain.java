package domain.model;

import java.util.List;

//resources: [
//			{ id: 'a', title: '-รื' },
//			{ id: 'b', title: 'าปรื', eventColor: 'green' },
//			{ id: 'c', title: 'Auditorium C', eventColor: 'orange' },
//			{ id: 'd', title: '--', children: [
//				{ id: 'd1', title: '-CM' , eventColor: 'BLACK'},
//				{ id: 'd2', title: '-CM' , eventColor: 'WHITE'},
//				{ id: 'd3', title: '--CM' , eventColor: 'PINK'}
//			] },
//			{ id: 'e', title: ' ^_^' , eventColor: 'RED'},
//			{ id: 'z', title: 'Auditorium Z' }
//		]
		
public class JsonResourcesDomain {


	private String id;
	private String title;
	private String eventColor;
	private List<JsonResourcesDomain> children;
	public static String [] EventColors={"Aqua","Yellow","Red","Green","Blue","Purple","orange",
			"cyan","Violet","magenta","tangerineindigo","peach","salmon","orchid"};
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEventColor() {
		return eventColor;
	}
	public void setEventColor(String eventColor) {
		this.eventColor = eventColor;
	}
	public List<JsonResourcesDomain> getChildren() {
		return children;
	}
	public void setChildren(List<JsonResourcesDomain> children) {
		this.children = children;
	}
	
	
	
}
