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
<%@page import="domain.model.EqpmentExample"%>
<%@ include file="include.jsp" %>
<%@ page language="java" import="domain.dao.EqpmentDAO" %>
<%@ page language="java" import="domain.dao.EqpmentDAOImpl" %>
<%@ page language="java" import="java.sql.SQLException" %>
<%@ page language="java" import="java.util.List" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="<c:url value="/style.css"/>"/>
    <script src='schd/lib/js/jquery-1.11.0.min.js'></script>
    <title>Apache Shiro Quickstart</title>
    <script type="text/javascript">
	    $(function(){
	        $("#btnAjax").click(function(){
	            $.post("mvc/getajax",{name:$("#name").val()},function(data){
	                alert(data);
	            });
	        });
	        $("#btnJson").click(function(){
	            $.post("mvc/getjson",{name:$("#name").val()},function(data){
	                alert(data);
	            });
	        });
	    });
    </script>
</head>
<body>

<h1>Apache Shiro Quickstart</h1>

<p>Hi <shiro:guest>Guest</shiro:guest><shiro:user><shiro:principal/></shiro:user>!
    ( <shiro:user><a href="<c:url value="/logout"/>">Log out</a></shiro:user>
    <shiro:guest><a href="<c:url value="/login.jsp"/>">Log in</a> (sample accounts provided)</shiro:guest> )
    <p><a href="<c:url value="/schd/home.jsp"/>">schd</a></p>
    <p><a href="<c:url value="/mvc/hello"/>">mvc hello</a></p>
    <p><a href="<c:url value="/mvc/getjson"/>">mvc hello</a></p>
    <p><a id='btnJson' >jsonResult</a></p>
    <p><a href="<c:url value="/mvc/getajax"/>"> ajax </a></p>
    <p><a id='btnAjax' > ajaxResult </a></p>
</p>
<div id='ajaxResult' ></div>
<div id='jsonResult' ></div>

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
<%

EqpmentDAO dao=new EqpmentDAOImpl();
try {
	EqpmentExample example = new EqpmentExample();
	System.out.println(dao.countByExample(example));
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
%>

</body>
</html>
