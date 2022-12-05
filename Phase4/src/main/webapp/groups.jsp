<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
	button:hover {
		color: white;
	}
	a {
		text-decoration: none;
		color: black;
		font-size: 24px;
	}
	
	
</style>
</head>
<body>
	<h1>어느 캘린더에 접속하시겠습니까?</h1>
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
	
	/*
	String query = "select count(*) from users u, participate p where u.id = p.participant";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	for (int i=1; i <= cnt; i++) {
		out.println("<button>"+rsmd.getColumnName(i)+"</button>");
	}
	*/
	
	%>
	<button>
		<a href='/calendar'>
			calendar name
		</a>
	</button>
		
</body>
</html>