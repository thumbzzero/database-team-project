<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>우리우정 012</title>
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
	Statement stmt = null;

	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();
	String group_id = request.getParameter("group_id");
	String password = request.getParameter("password");
	String date = request.getParameter("date");
	String createdAt = "To_date('" + date + "', 'yyyy-mm-dd')";
	String user_id = "hyejjang";
	String sql = "";
	
	try {
		// Let's execute an SQL statement.
		sql = "INSERT INTO Calendar VALUES ('" + group_id + "'," + createdAt + ",'" + password + "')";
		System.out.println(sql);
		
		int res = stmt.executeUpdate(sql);
		System.out.println(res + " row inserted.");
		
		sql = "insert into participate values('" + group_id + "', '" + user_id + "')";
		System.out.println(sql);
		
		res = stmt.executeUpdate(sql);
		System.out.println(res + " row inserted.");
		
		
		// conn.commit();			
	}catch(SQLException ex2) {
		System.err.println("sql error = " + ex2.getMessage());
		System.exit(1);
	}
	%>
	<script type="text/javascript">
		var changeUrl = '/Phase4/groups.jsp'; // 기본 URL로 사이트 접속 시 변경하고 싶은 URL
		var urlString = location.href;
		alert('그룹이 추가되었습니다.');
		window.location.replace(changeUrl);
	</script>
</body>
</html>