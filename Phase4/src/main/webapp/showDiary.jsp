<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>우리우정 012</title>
<link rel="stylesheet" href="./common.css" />
<style>
	p {
		margin-top: 200px;
		font-size: 32px;
		line-height: 60px;
	}
</style>
</head>
<body>
<%
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
	
	String diary_key = (String)session.getAttribute("diary_key");
	String query = "select id, diary_content from diary where id='hyejjang' and diary_key = " + diary_key;
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rs.getMetaData();
	
	while (rs.next()) {
		out.println("<p>작성자 : " + rs.getString(1) + "<br>" + rs.getString(2) +"</p>");
		out.println("<br>");
	}
	rs.close();
	pstmt.close();
	conn.close();
%>
</body>
</html>