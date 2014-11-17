<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Welcome iMoney</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/date_input.css" type="text/css" media="screen">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script type="text/javascript" src="/jquery.date_input.js"></script>
      <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
        <script>
           $(function() {
               $( "#date" ).datepicker();
            });
        </script>
</head>
<body>

<h1>
<a href="/">iMoney</a>
</h1>
<h2>A Personal Finance System</h2>
<%
   UserService userService = UserServiceFactory.getUserService();
   User user = userService.getCurrentUser();
   if (user != null) {
       pageContext.setAttribute("user", user);
%>
<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
    <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
} else {
%>
<p>Hello!
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
    to take control of your money with iMoney.</p>
<%  
}
%>

<form action="/save" method="post">
<table>
 <tbody>
 <tr>
  <td>
    <label>spent</label>
    <input type="text" name="amount" size="10">
  </td>
  <td>
    <label>for</label>
    <input type="text" name="tags" size="40">
  </td>
  <td>
    <label>on</label>
    <input id="date" type="text" name="date" size="10">
  </td> 
 </tr>
 <tr>
  <td>
    <label>at</label>
    <input type="text" name="address" size="40">
  </td>
 </tr>
 <tr>
  <td><input type="submit" value="Save"></td>
  <td><a href="/">Cancel</a></td>     
 </tr>
 </tbody>
</table>
</form>  

</body>
</html>