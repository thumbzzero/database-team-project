<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Random" %>
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
	.makeGroup {
		background-color: #7DEBEB;
		margin-top: 60px;
		width: 120px;
		height: 50px;
	}
	.makeGroup:hover {
		color: white;
	}
</style>
</head>
<body>
	<h1>어느 캘린더에 접속하시겠습니까?</h1>
	<%
	Random random = new Random();
	int number = random.nextInt(10000000) + 70;
	session.setAttribute("num", Integer.toString(number));
	
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
	out.println("<form method=get action='calendar.jsp'>");
	while (rs.next()) {
		String temp=rs.getString(1);
		out.println("<button name='selectedGroup' value='" + temp + "'><input name='selectedGroup' type='submit' value='" + temp + "'></button>");
	}
	out.println("</form>");
	
	%>
	<a href="addGroup.html" class='makeGroup'><button class='makeGroup'>그룹 만들러 가기</button></a>
</body>
</html>