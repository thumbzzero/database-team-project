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

	String str_num = (String)session.getAttribute("num");
	int num = Integer.parseInt(str_num);
	num++;
	session.setAttribute("num", Integer.toString(num));
	
	
	String sql = "";
		
	
	
	String diary_key = Integer.toString(num);
	String diary_content = request.getParameter("diary_content");
	String DIARY_date = (String)session.getAttribute("clickedDate");
	String id = "hyejjang";
	String group_id = (String)session.getAttribute("selectedGroup");
	
	String query = "select date_key from day_record where date_key = " + diary_key;
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = 0;
	while (rs.next()) {
		cnt++;
	}
	if (cnt == 0) {
		sql = "insert into day_record values(" + diary_key + ", To_date('" 
				+ DIARY_date + "', 'yyyy-mm-dd'), NULL, NULL, 1, '" + group_id + "', " + DIARY_date  + ")";
		System.out.println(sql);
		int res = stmt.executeUpdate(sql);
		System.out.println(res + " row inserted.");
	}
	
	sql = "insert into Diary values(" + diary_key + ", '" + diary_content + 
			"',  To_date('" + DIARY_date + "', 'yyyy-mm-dd'),'" + id + "'," + diary_key +")";
	System.out.println(sql);
	int res = stmt.executeUpdate(sql);
	System.out.println(res + " row inserted.");
	
	session.setAttribute("diary_key", diary_key);
%>
	<script type="text/javascript">
		var changeUrl = '/Phase4/showDiary.jsp'; // 기본 URL로 사이트 접속 시 변경하고 싶은 URL
		var urlString = location.href;
		alert('일기가 추가되었습니다.');
		window.location.replace(changeUrl);
	</script>
</body>
</html>