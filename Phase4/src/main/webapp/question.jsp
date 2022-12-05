<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>New question</title>
<link href="https://fonts.googleapis.com/css?family=Gamja+Flower:400" rel="stylesheet">
<style>
	* {
		text-align: center;
		font-weight: bold;
		font-family: "Gamja Flower", sans-serif;
	}
	body {
		background-image: url('./background.jpg');
		background-size: cover;
	}
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
	<h3><font size = "6">�ㅻ��留��� ���� ��濡��� 吏�臾몄�� ���깊�대낫�몄��!</font></h3>
	<h4>
	
			<% 
				String serverIP = "localhost";
				String strSID = "orcl";
				String portNum = "1521";
				String user = "university";
				String pass = "comp322";
				String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
				System.out.println(url);
				Connection conn = null;
				PreparedStatement pstmt;
				ResultSet rs;
			
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(url,user,pass);
			%>
	
			吏�臾몄�� �댁�⑹�� ���깊���몄�� 
			<br>
			<br>
			<input type="text" name="content">
			<br>
			<br>
			吏�臾몄�� �ㅻ�� ���깊�� 二쇱�몄�� (�レ��留� ���ν�댁＜�몄��!) 
			<br>
			<a href = "answer.jsp?name = 'questionkey' ">
			<input type="text" name="questionkey">
			</a>
			
			<br>
			<br>
			<input type="submit" name="Submit">
	
	</h4>
	<%
		
		
		String key = request.getParameter("questionkey");
		String content = request.getParameter("content"); 
	
		//insert new question
		String query = "insert into question values(" + key + ", '" + content + "')";
	
		System.out.println(query);
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
	
	%>


</body>
</html>
