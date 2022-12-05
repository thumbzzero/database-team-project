<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>New question</title>
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

	<% 
		String serverIP = "localhost";
		String strSID = "xe";
		String portNum = "1521";
		String user = "university";
		String pass = "comp322";
		String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;

		Connection conn = null;
		PreparedStatement pstmt;
		Statement stmt = null;
		ResultSet rs;
			
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		stmt = conn.createStatement();
		
		String key = request.getParameter("questionkey");
		String content = request.getParameter("content"); 
		String query = "";
	
		//insert new question
		try{
			query = "insert into question values(" + key + ", '" + content + "')";
			System.out.println(query);
			
			int res = stmt.executeUpdate(query);
		}catch(SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	
	
	
	%>
	
	<script type="text/javascript">
		var changeUrl = '/Phase4/answer.jsp'; // 기본 URL로 사이트 접속 시 변경하고 싶은 URL
		var urlString = location.href;
		alert('질문이 추가되었습니다.');
		window.location.replace(changeUrl);
	</script>


</body>
</html>
