<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>우리우정 012</title>
<link rel="stylesheet" href="./common.css" />
<link href="https://fonts.googleapis.com/css?family=Gamja+Flower:400" rel="stylesheet">
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
<h1>[Today question]</h1>
<br>

	<h2>오늘의 질문은!?</h2>
	<%
		
			String serverIP = "localhost";
			String strSID = "orcl";
			String portNum = "1521";
			String user = "university";
			String pass = "comp322";
			String url = "jdbc:oracle:thin:@"+ serverIP + ":" + portNum + ":" + strSID;
			
			String query = "";
			Connection conn = null;
			PreparedStatement pstmt;
			Statement stmt;
			ResultSet rs;
	
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url,user,pass);
			
			String questionkey = (String)session.getAttribute("clickedDate");
			String userid = "hyejjang";
			String myanswer = request.getParameter("myanswer");
			
			query = "select question_content from Question where question_key = '" + questionkey + "'";
			System.out.println(query);
			
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()){
        			out.println("<h3>" + rs.getString(1) + "</h3>");
			}
       

		%>
	<form method="get" action="answer.jsp">
			<h1>답변을 입력하세요!</h1>
			<input type="text" name="myanswer">
			<br>
			<button>답변작성</button>
			<br>
		</form>
</body>
</html>