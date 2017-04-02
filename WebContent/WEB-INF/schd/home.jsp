<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page pageEncoding="UTF-8"%>
<%@page import="domain.model.EqpmentExample"%>
<%@page import="domain.model.EventExample"%>
<%@ include file="/include.jsp" %>
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

<head>
    <link type="text/css" rel="stylesheet" href="<c:url value="/style.css"/>"/>
    <title>Apache Shiro Quickstart</title>
    
    <link href='lib/fullcalendar.min.css' rel='stylesheet' />
<link href='lib/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link rel="stylesheet" href="lib/css/Lobibox.min.css">
<link rel="stylesheet" href="lib/css/jquery-ui.css">
<link href='scheduler.min.css' rel='stylesheet' />
<script src='lib/moment.min.js'></script>
<script src='lib/js/jquery-1.11.0.min.js'></script>
<script src='lib/jquery-ui.min.js'></script>
<script src='lib/fullcalendar.min.js'></script>
<script src='scheduler.min.js'></script>
<script src="lib/js/bootstrap.min.js"></script>  
<script src="lib/js/lobibox.min.js"></script>
<link rel="stylesheet" href="<c:url value="/highlight/styles/arta.css"/>" /> 
<script src="<c:url value="/highlight/highlight.pack.js" />" ></script>  
<script type="text/javascript" charset="UTF-8" >
	$(function() { 
	    $( "#star_othername" ).autocomplete({
	        source: "searchsac_other",
	        minLength: 1,
	        focus: function( event, ui ) {
	            $( "#star_othername" ).val( ui.item.objvalue.other );
	            $( "#star_objectname" ).val( ui.item.objvalue.object );
	            $( "#star_ra_value" ).val( ui.item.ra_value );
	            $( "#star_dec_value" ).val( ui.item.dec_value );
	            return false;
	          },
	        select: function( event, ui ) {
	            $( "#star_othername" ).val( ui.item.objvalue.other );
	            $( "#star_objectname" ).val( ui.item.objvalue.object );
	            $( "#star_ra_value" ).val( ui.item.ra_value );
	            $( "#star_dec_value" ).val( ui.item.dec_value );
	          //console.log( "Selected: " + ui.item.value + " aka " + ui.item.id );
	          return false;
	        }
	      });
	    var dialog, form,
	      name = $( "#name" ),
	      email = $( "#email" ),
	      password = $( "#password" ),
	      allFields = $( [] ).add( name ).add( email ).add( password ),
	      tips = $( ".validateTips" );
	    
	    $( "#star_objectname" ).autocomplete({
	        source: "searchsac_object",
	        minLength: 1,
	        focus: function( event, ui ) {
	            $( "#star_othername" ).val( ui.item.objvalue.other );
	            $( "#star_objectname" ).val( ui.item.objvalue.object );
	            $( "#star_ra_value" ).val( ui.item.ra_value );
	            $( "#star_dec_value" ).val( ui.item.dec_value );
	            return false;
	          },
	        select: function( event, ui ) {
	            $( "#star_othername" ).val( ui.item.objvalue.other );
	            $( "#star_objectname" ).val( ui.item.objvalue.object );
	            $( "#star_ra_value" ).val( ui.item.ra_value );
	            $( "#star_dec_value" ).val( ui.item.dec_value );
	          
	          return false;
	        }
	      });
		   
	      $( "#save_event_plan" ).button().on( "click", function() {
	    	  var objEvent=$('#calendar').fullCalendar( 'clientEvents', $('#event_id').val() )[0];
	    	  //console.log(objEvent);
	    	  if (!objEvent ){$( "#message_dialog_select_event" ).dialog({buttons: {"我知道了": function() {$( this ).dialog( "close" );}}});return;}
				if (objEvent.isunsave || objEvent.ismodified ) {
					$( "#message_dialog_save_event" ).dialog({
					      resizable: false,
					      height: "auto",
					      width: 400,
					      modal: true,
					      buttons: {
					        "保存": function() {
					          $( this ).dialog( "close" );
					        },
					        "取消": function() {
					          $( this ).dialog( "close" );
					        }
					      }
					    });				
				}else{
						//save plan
				}
	      });	   
	      $( "#commit_event_plan" ).button().on( "click", function() {
	    	  var objEvent=$('#calendar').fullCalendar( 'clientEvents', $('#event_id').val() )[0];
	    	  //console.log(objEvent);
	    	  if (!objEvent ){$( "#message_dialog_select_event" ).dialog({buttons: {"我知道了": function() {$( this ).dialog( "close" );}}});return;}
				if ( objEvent.isunsave || objEvent.ismodified ) {
					$( "#message_dialog_save_event" ).dialog({
					      resizable: false,
					      height: "auto",
					      width: 400,
					      modal: true,
					      buttons: {
					        "保存": function() {
					          $( this ).dialog( "close" );
					        },
					        "取消": function() {
					          $( this ).dialog( "close" );
					        }
					      }
					    });				
				}else{
					$('#message_dialog_commit_plan_value').html(objEvent.start.format());
					$( "#message_dialog_commit_plan" ).dialog({
					      resizable: false,
					      height: "auto",
					      width: 400,
					      modal: true,
					      buttons: {
					        "提交计划": function() {
					    	        $.post("addEventPlan",{eventid:objEvent.id,starttime:objEvent.start.format()
					    				,endtime:objEvent.end.format(),userid:'1'},function(data){
					    					console.log(data);
					    	        });       	
					          $( this ).dialog( "close" );
					        },
					        "取消": function() {
					          $( this ).dialog( "close" );
					        }
					      }
					    });		
				}
		      });
	    
		$('#calendar').fullCalendar({
			schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source',
			now: '2017-03-16',
			editable: true,
			aspectRatio: 1.8,
			scrollTime: '00:00',
			minTime: '23:00',
			maxTime: '30:00',
			header: {
				left: 'today prev,next',
				center: 'title',
				right: 'timelineDay,timelineTwoDays,timelineThreeDays,agendaWeek,month'
			},
			defaultView: 'timelineTwoDays',
			views: {
				timelineThreeDays: {
					type: 'timeline',
					duration: { days:3}
				},
				timelineTwoDays: {
					type: 'timeline',
					duration: { days: 2 }
				}
			},
			duration: { hours:36  },
			slotDuration:'00:10:00',
			eventOverlap: false, // will cause the event to take up entire resource height
			resourceAreaWidth: '15%',
			resourceLabelText: '列表',
			resources: ${resString},
			//resources: data.resString,
			events: ${envString},
			//events: data.envString,
		    eventResize: function(event, delta, revertFunc) {
		    	event.ismodified=true;
		    	event.textColor='blue';
		    	event.borderColor='red';
		    	//event.color='orange';
		    	Lobibox.notify.closeAll();
				Lobibox.notify(						  
				  'info',
				  {
					  sound: false,
					  size: 'large',
					  title: '<span id="prm_event_title">' + event.title +'</span>'+'  <span id="prm_event_id">'+event.id +'</span> <span id="prm_event_resourceid">' + event.resourceId +'</span>',
	                  msg: '<span id="prm_event_start">'+ event.start.format()+'</span> -- <span id="prm_event_end">'+event.end.format()
	                  	+'</span><button id ="saveEventButton" onclick="saveEvent('+event.id+')">保存（save）</button>'
				  }
				);  

		    },
		    eventDrop: function(event, delta, revertFunc) {
		    	event.ismodified=true;
		    	event.textColor='blue';
		    	event.borderColor='red';
		    	//event.color='orange';
		    	Lobibox.notify.closeAll();
				Lobibox.notify(						  
						  'info',
						  {
							  //closeOnEsc: true,
							  closeOnClick: true, 
							  //showAfterPrevious: true,
							  sound: false,
							  size: 'large',
							  title: '<span id="prm_event_title">' + event.title +'</span>'+'  <span id="prm_event_id">'+event.id +'</span> <span id="prm_event_resourceid">' + event.resourceId +'</span>',
			                  msg: '<span id="prm_event_start">'+ event.start.format()+'</span> -- <span id="prm_event_end">'+event.end.format()
			                  	+'</span><button id ="saveEventButton" onclick="saveEvent('+event.id+')">保存（save）</button>'
			        
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
			},
			eventClick: function(calEvent, jsEvent, view) {
				if (calEvent.isunsave || calEvent.ismodified ) {
					$( "#message_dialog_save_event" ).dialog({
					      resizable: false,
					      height: "auto",
					      width: 400,
					      modal: true,
					      buttons: {
					        "保存": function() {
					          $( this ).dialog( "close" );
					        },
					        "取消": function() {
					          $( this ).dialog( "close" );
					        }
					      }
					    });				
				}else{
					$('#event_id').val(calEvent.id);
					$('#event_title').val(calEvent.title);
					$('#event_resourceId').val(calEvent.resourceId);
				}				    					
		    },
			eventRender: function(event, el) {
				// render the timezone offset below the event title
				if (event.start.hasZone()) {
					el.find('.fc-title').after(
						$('<div class="tzo"/>').text(event.start.format('Z'))
					);
				}
			},
		    eventReceive : function( event ) { 
		    	event.borderColor='red';
		    	event.textColor='red';
		    	var d = new Date();
		    	event.isunsave=true;
		    	event.id=event.resourceId+'_userid_'+d.getTime();
		    	event.end=$.fullCalendar.moment.parseZone(event.start.clone().add(1, 'H').format());
		    	console.log(event.end.format());
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
							  title: '<span id="prm_event_title">' + event.title +'</span>'+'  <span id="prm_event_id">'+event.id +'</span> <span id="prm_event_resourceid">' + event.resourceId +'</span>',
			                  msg: '<span id="prm_event_start">'+ event.start.format()+'</span> -- <span id="prm_event_end">'
			                  +event.end.format()
			                  	+'</span><button id ="saveEventButton" onclick="saveEvent('+event.id+')">保存（save）</button>'
			        
						  }
						);  		    	
		    	 $('#calendar').fullCalendar('updateEvent', event);
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
		        }});
		

		// when the timezone selector changes, dynamically change the calendar option
		$('#timezone-selector').on('change', function() {
			$('#calendar').fullCalendar('option', 'timezone', this.value || false);
		});
		$('#calendar').fullCalendar('option', 'timezone', 'local');
		$('pre code').each(function(i, block) {hljs.highlightBlock(block);});
	});
	

	function saveEvent(envId){
		
/* 		$.post("updateEvent",{eventid:$("#prm_event_id").html(),eqpid:$("#prm_event_resourceid").html(),starttime:$("#prm_event_start").html()
			,endtime:$("#prm_event_end").html(),userid:'1',title:$("#prm_event_title").html()},function(data){
        }); */
        var objEvent=$('#calendar').fullCalendar( 'clientEvents', envId )[0];
		console.log(objEvent);
		if(objEvent.isunsave){
	        $.post("saveNewEvent",{eventid:objEvent.id,eqpid:objEvent.resourceId,starttime:objEvent.start.format()
				,endtime:objEvent.end.format(),userid:'1',title:objEvent.title},function(data){
					objEvent.ismodified=false;
					objEvent.textColor='white';
					objEvent.borderColor='';
	        });
	       return;
		}
		if(objEvent.ismodified){
	        $.post("updateEvent",{eventid:objEvent.id,eqpid:objEvent.resourceId,starttime:objEvent.start.format()
				,endtime:objEvent.end.format(),userid:'1',title:objEvent.title},function(data){
	        objEvent.ismodified=false;
	        objEvent.textColor='white';
	        objEvent.borderColor='';
	        console.log(objEvent);
	        $('#calendar').fullCalendar( 'updateEvent', objEvent )
	        }); 
		}
	}
/* 
	function addEventPlan(envId){		
		var objEvent=$('#calendar').fullCalendar( 'clientEvents', envId )[0];
		console.log(objEvent);
		if(objEvent.isunsave || objEvent.ismodified){
			alert('保存修改后才能添加');	       
	        return;
		}
	        $.post("addEventPlan",{eventid:objEvent.id,eqpid:$("#prm_event_resourceid").html(),starttime:$("#prm_event_start").html()
				,endtime:$("#prm_event_end").html(),userid:'1',title:$("#prm_event_title").html()},function(data){
	        });
	}
	 */
	
	
/* 	function searchsac(){
        $.post("searchsac",{star_name :'M42'},function(data){
        	console.log(data)
        });
	} */
	
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
	.left { float: left }
	.right { float: right ;width: 400px; display: flex ;justify-content:space-around;direction: right;}
	.clear { clear: both }
	.tzo {
		color: #000;
	}
	fieldset{
	  border: 1px solid rgb(230,230,230);
	  width: 1100px;
	  margin:auto;
	  padding:auto;
	}
	.flex-display {
		display: flex;
		justify-content: space-around;
		direction: left;
	}

</style>

</head>
<body>
<fieldset>
	<div id='top'>
		<div class='left'>
			时区(Timezone):
			<select id='timezone-selector'>
				<option value='' selected>none</option>
				<option value='local'>local</option>
				<option value='UTC'>UTC</option>
			</select>
		</div>
		<div class='right'>
		<shiro:guest>Guest</shiro:guest>
		<shiro:user><span>当前登录：<shiro:principal/></span>
			<span>星点 ： 1000</span>
			<span>[+]</span> 
		</shiro:user>
		 <shiro:user><a href="<c:url value="/logout"/>">退出（Log out）</a></shiro:user>
    <shiro:guest><a href="<c:url value="/login.jsp"/>">登录（Log in）</a> (sample accounts provided)</shiro:guest> 
			<span id='loading'>...</span>
		</div>
		<div class='clear'></div>
	</div>
</fieldset>

	<div id='wrap'>
		<div id='external-events'>
			<h4>拖放添加</h4>
			<div class='fc-event' data-start='' data-end='' data-id='' 	>整晚</div>
			<div class='fc-event'>一个小时</div>
			<div class='fc-event'>连续一个月</div>
			<div class='fc-event'>连续一年</div>
			<p>
				<input type='checkbox' id='drop-remove' />
				<label for='drop-remove'>remove after drop</label>
			</p>
		</div>

		<div id='calendar'></div>

		<div style='clear:both'></div>

	</div>

	<div id='calendar'></div>
 

<div style="display:none">
	<div id="dialog-confirm" title="Empty the recycle bin?">
	  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>需要先保存预约</p>
	</div>
	<div id="message_dialog_commit_plan" title="是否提交计划">
	  提交后会在预约时间（<span id="message_dialog_commit_plan_value"></span>）执行，是否提交计划？
	</div>
	<div id="message_dialog_save_event" title="是否保存预约时段？">
	  	保存计划之后才可以提交计划。
	</div>
	<div id="message_dialog_select_event" title="需要选择时段">
	  	鼠标点击选择时段
	</div>
</div>



<fieldset>
	<div class="ui-widget flex-display">
	  <label for="event_id">预约编号: </label>
	  <input id="event_id">
	  <label for="event_title">预约备注: </label>
	  <input id="event_title" placeholder="（Event Tile）">
	  <label for="event_resourceId">设备编号: </label>
	  <input id="event_resourceId">
	  <label for="event_start_format">开始时间: </label>
	  <input id="test_delay_time">
	</div>
</fieldset>
<fieldset>
	<div class="ui-widget flex-display">
	  <label for="star_objectname">目标编号</label>
	  <input id="star_objectname" placeholder="SAC Name： NGC1976">
	  <label for="star_othername">常用名: </label>
	  <input id="star_othername" placeholder="SAC Other Name：M42">
	  <label for="star_ra_value">RA: </label>
	  <input id="star_ra_value">
	  <label for="star_dec_value">Dec: </label>
	  <input id="star_dec_value">
	</div>
</fieldset>

<fieldset>
<div class="ui-widget flex-display">
  <button id="save_event_plan">保存计划（Save Plan）</button>
  <button id="commit_event_plan">提交计划（Commit Plan）</button>
</div>
</fieldset>

</body>
</html>
