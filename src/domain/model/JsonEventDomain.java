package domain.model;

public class JsonEventDomain {

	//[
//		{ id: '1', resourceId: 'b', start: '2017-03-06T02:00:00', end: '2017-03-06T07:00:00', title: '-xxx' },
//		{ id: '2', resourceId: 'c', start: '2017-03-06T05:00:00', end: '2017-03-06T12:00:00', title: '--2' },
//		{ id: '3', resourceId: 'd1', start: '2017-03-05', end: '2017-03-10', title: '--' },
//		{ id: '4', resourceId: 'e', start: '2017-03-06T03:00:00', end: '2017-03-06T08:00:00', title: '--影响' },
//		{ id: '5', resourceId: 'a', start: '2017-03-06T00:30:00', end: '2017-03-06T02:30:00', title: '--差不多就这样吧' }
	//]
	


		private String id;
		private String resourceId;
		private String start;
		private String end;
		private String title;
		
		

		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getResourceId() {
			return resourceId;
		}
		public void setResourceId(String resourceId) {
			this.resourceId = resourceId;
		}
		public String getStart() {
			return start;
		}
		public void setStart(String start) {
			this.start = start;
		}
		public String getEnd() {
			return end;
		}
		public void setEnd(String end) {
			this.end = end;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}

		
}
