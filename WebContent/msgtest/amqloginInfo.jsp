<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>test</title>

	<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="js/amq_jquery_adapter.js"></script>
	<script type="text/javascript" src="js/amq.js"></script>

</head>
<body class="no-scrollbar" style="padding:0px;margin:0px;">
<div id="hiddValue" style="display: block"></div>

昵称：<input type="text" id="nickname">
内容：<input type="text" id="content">
<button onclick="send()">发送</button>
<button onclick="removeListener()">停止</button>

<div>
	
		<input id="loginTime" key="登录时间"  width="200px" type="text" />
		<input id="loginName" key="用户名称"  width="200px"  type="text"  />
		<input id="loginId" key="账号"  width="200px"  type="text"  />
		<input id="department" key="部门"  width="200px"   type="text" />
		<input id="sysName" key="系统"  width="200px"   type="text" />
		<input id="actionMessage" key="操作"  width="200px"   type="text" />
		<input id="serverName" key="服务器"  width="200px"   type="text" />

</div>
</body>
</html>
<script type="text/javascript">

	$(function(){
		//$("body").taLayout();
	})
	var amq = org.activemq.Amq;
	amq.init({
		uri: '<%=basePath %>amq',
		logging: true,
		timeout: 20,
		clientId: 'loginMsg_AmqClient'
	});

	var myHandler = {
		rcvMessage: function(message) {
			console.log(message);
			  $("#hiddValue").html(message);
			  var data=$("#hiddValue").html()+"";//必须这样写，不然message是xml类型，不好处理
/* 			data= eval(data);
				  alert(data);
			  for(var i=0;i<data.length;i++){
				 Base.addGridRow('gridLogin',{'loginTime':data[i].loginTime,'loginName':data[i].loginName,'loginId':data[i].loginId
					,'department':data[i].department,'sysName':data[i].sysName,'actionMessage':data[i].actionMessage
					,'serverName':data[i].serverName
				}); 
		 	 } */
		}
	};

	amq.addListener("huagjieTest","topic://loginTopic",myHandler.rcvMessage);


	//移除
	function removeListener(){
		amq.removeListener("huagjieTest");
	}


	//该方法直接可以发送消息到服务器  loginTopic消息唯一标识
	function send(){
		var nickname = $("#nickname").val();
		var content = $("#content").val();
		var msg = nickname + " : " +content;
		amq.sendMessage("topic://loginTopic",msg);
	}


</script>