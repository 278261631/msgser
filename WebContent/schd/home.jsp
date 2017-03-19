<%--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~ with the License.  You may obtain a copy of the License at
  ~
  ~     http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page pageEncoding="UTF-8"%>
<%@page import="domain.model.EqpmentExample"%>
<%@page import="domain.model.EventExample"%>
<%@ include file="../include.jsp" %>
<%@ page language="java" import="domain.dao.EqpmentDAO" %>
<%@ page language="java" import="domain.dao.EventDAO" %>
<%@ page language="java" import="domain.model.Eqpment" %>
<%@ page language="java" import="domain.model.Event" %>
<%@ page language="java" import="domain.dao.EqpmentDAOImpl" %>
<%@ page language="java" import="domain.dao.EventDAOImpl" %>
<%@ page language="java" import="java.sql.SQLException" %>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="util.JsonGen" %>
<html>
<%

EqpmentDAO dao=new EqpmentDAOImpl();
EventDAO evtdao=new EventDAOImpl();
String jsonString="";
String envString="";
try {
	EqpmentExample example = new EqpmentExample();
	System.out.println(dao.countByExample(example));
	List<Eqpment> eqlist=dao.selectByExample(example);
	EventExample evtExample =new EventExample();
	List<Event> events=evtdao.selectByExample(evtExample);
	/* for(int i = 0 ;i<eqlist.size();i++){
		Eqpment item=(Eqpment)eqlist.get(i);
		
	} */
	jsonString = JsonGen.GenResourcesListJson(eqlist);
	envString  = JsonGen.GenEventListJson(events);
	System.out.println(jsonString);
	System.out.println(envString);
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
%>

<head>
    <link type="text/css" rel="stylesheet" href="<c:url value="/style.css"/>"/>
    <title>Apache Shiro Quickstart</title>
    
    <link href='lib/fullcalendar.min.css' rel='stylesheet' />
<link href='lib/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link rel="stylesheet" href="lib/css/Lobibox.min.css">
<link href='scheduler.min.css' rel='stylesheet' />
<script src='lib/moment.min.js'></script>
<script src='lib/js/jquery-1.11.0.min.js'></script>
<script src='lib/jquery-ui.min.js'></script>
<script src='lib/fullcalendar.min.js'></script>
<script src='scheduler.min.js'></script>
<script src="lib/js/bootstrap.min.js"></script>  
<script src="lib/js/lobibox.min.js"></script>  
<script type="text/javascript" charset="UTF-8" >

	$(function() { // document ready

		$('#calendar').fullCalendar({
			now: '2017-03-17',
			editable: true,
			aspectRatio: 1.8,
			scrollTime: '00:00',
			minTime: '00:00',
//			maxTime:'48:00', //不科学~
			header: {
				left: 'today prev,next',
				center: 'title',
				right: 'timelineDay,timelineTwoDays,timelineThreeDays,agendaWeek,month'
			},
			defaultView: 'timelineDay',
			views: {
				timelineThreeDays: {
					type: 'timeline',
					duration: { days: 3 }
				},
				timelineTwoDays: {
					type: 'timeline',
					duration: { days: 2 }
				}
			},
			eventOverlap: false, // will cause the event to take up entire resource height
			resourceAreaWidth: '15%',
			resourceLabelText: '列表',
			resources: <%=jsonString%>,
			events: <%=envString%>,
		    eventResize: function(event, delta, revertFunc) {
		    	Lobibox.notify.closeAll();
				Lobibox.notify(						  
				  'info',
				  {
					  sound: false,
					  size: 'large',
	                  msg: event.start.format()+'  '+event.end.format()+'<button onclick="saveEvent()">保存（save）</button>'
				  }
				);  

		    },
		    eventDrop: function(event, delta, revertFunc) {
		    	Lobibox.notify.closeAll();
				Lobibox.notify(						  
						  'info',
						  {
							  //closeOnEsc: true,
							  size: 'large', 
							  closeOnClick: true, 
							  //showAfterPrevious: true,
							  sound: false,
							  size: 'large',
							  title: '列表  <span id="prm_event_id">'+event.id +'</span> <span id="prm_event_resourceid">' + event.resourceId +'<span>',
			                  msg: '<span id="prm_event_start">'+ event.start+'</span> -- <span id="prm_event_end">'+event.end
			                  	+'</span><button id ="saveEventButton" onclick="saveEvent('+event.id+')">保存（save）</button>';
			        
						  }
						);  

		    },
		    
			droppable: true, // this allows things to be dropped onto the calendar
			drop: function() {
				// is the "remove after drop" checkbox checked?
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					$(this).remove();
				}
			}
		});
	

		$('#external-events .fc-event').each(function() {

			// store data so the calendar knows to render an event upon drop
			$(this).data('event', {
				title: $.trim($(this).text()), // use the element's text as the event title
				stick: true // maintain when user navigates (see docs on the renderEvent method)
			});

			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});

		});
	
		$('#external-events').droppable({
		      drop: function( event, ui ) {
		          $( this )
		            .addClass( "ui-state-highlight" )
		            .find( "p" )
		              .html( "Dropped!" );
		        };});
		
	});
	

	function saveEvent(){
		alert($('#prm_event_start').html()+'  '+$('#prm_event_end').html());
		
	}

</script>
<style>

	body {
		margin: 0;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	p {
		text-align: center;
	}

	#calendar {
		float: right;
		width: 900px;
	}
		#wrap {
		width: 1100px;
		margin: 0 auto;
	}
		
	#external-events {
		float: left;
		width: 150px;
		padding: 0 10px;
		border: 1px solid #ccc;
		background: #eee;
		text-align: left;
	}
		
	#external-events h4 {
		font-size: 16px;
		margin-top: 0;
		padding-top: 1em;
	}
		
	#external-events .fc-event {
		margin: 10px 0;
		cursor: pointer;
	}
		
	#external-events p {
		margin: 1.5em 0;
		font-size: 11px;
		color: #666;
	}
		
	#external-events p input {
		margin: 0;
		vertical-align: middle;
	}

</style>
    
</head>
<body>

	<div id='wrap'>

		<div id='external-events'>
			<h4>Draggable Events</h4>
			<div class='fc-event'>My Event 1</div>
			<div class='fc-event'>My Event 2</div>
			<div class='fc-event'>My Event 3</div>
			<div class='fc-event'>My Event 4</div>
			<div class='fc-event'>My Event 5</div>
			<p>
				<input type='checkbox' id='drop-remove' />
				<label for='drop-remove'>remove after drop</label>
			</p>
		</div>

		<div id='calendar'></div>

		<div style='clear:both'></div>

	</div>

	<p>
		Things render a bit differently with <code>eventOverlap:false</code>
	</p>

	<div id='calendar'></div>
<h1>Apache Shiro Quickstart</h1>

<a onclick="showNotifybox()">notification</a>
<p>Hi <shiro:guest>Guest</shiro:guest><shiro:user><shiro:principal/></shiro:user>!
    ( <shiro:user><a href="<c:url value="/logout"/>">Log out</a></shiro:user>
    <shiro:guest><a href="<c:url value="/login.jsp"/>">Log in</a> (sample accounts provided)</shiro:guest> )
</p>

<p>Welcome to the Apache Shiro Quickstart sample application.
    This page represents the home page of any web application.</p>

<shiro:user><p>Visit your <a href="<c:url value="/account"/>">account page</a>.</p></shiro:user>
<shiro:guest><p>If you want to access the user-only <a href="<c:url value="/account"/>">account page</a>,
    you will need to log-in first.</p></shiro:guest>

<h2>Roles</h2>

<p>To show some taglibs, here are the roles you have and don't have. Log out and log back in under different user
    accounts to see different roles.</p>

<h3>Roles you have</h3>

<p>
    <shiro:hasRole name="admin">admin<br/></shiro:hasRole>
    <shiro:hasRole name="president">president<br/></shiro:hasRole>
    <shiro:hasRole name="darklord">darklord<br/></shiro:hasRole>
    <shiro:hasRole name="goodguy">goodguy<br/></shiro:hasRole>
    <shiro:hasRole name="schwartz">schwartz<br/></shiro:hasRole>
</p>

<h3>Roles you DON'T have</h3>

<p>
    <shiro:lacksRole name="admin">admin<br/></shiro:lacksRole>
    <shiro:lacksRole name="president">president<br/></shiro:lacksRole>
    <shiro:lacksRole name="darklord">darklord<br/></shiro:lacksRole>
    <shiro:lacksRole name="goodguy">goodguy<br/></shiro:lacksRole>
    <shiro:lacksRole name="schwartz">schwartz<br/></shiro:lacksRole>
</p>

</body>
</html>
