<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>우리우정 012</title>
<link rel="stylesheet" href="./common.css" />
<style>
	h1 {
		margin: 100px 0 70px 0;
	}
	button {
		border: none;
		background-color: #5AC8C8;
		border-radius: 5px;
		padding: 10px;
		width: 200px;
		height: 120px;
	}
	input:hover {
		color: white;
	}
	a {
		text-decoration: none;
		color: black;
		font-size: 24px;
	}
	input {
		border: none;
		background: none;
		cursor: pointer;
		font-size: 28px;
	}
	
</style>
</head>
<body>
	<h1>어느 캘린더에 접속하시겠습니까?</h1>
	<%
	session.setAttribute("num", "50");
	
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "university";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	
	String query = "select p.group_id from users u, participate p where u.id = p.participant and u.id = 'hyejjang'";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	out.println("<form method=get action='calendar.jsp'>");
	while (rs.next()) {
		out.println("<button><input name='selectedGroup' type='submit' value='" + rs.getString(1) + "' /></button>");
	}
	out.println("</form>");
	
	%>
</body>
</html>