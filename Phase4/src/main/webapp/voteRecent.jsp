<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>우리우정 012</title>
<link rel="stylesheet" href="./common.css" />
<style>
	body {
		margin-top: 100px;
		font-size: 32px;
	}
	button {
		margin-top: 100px;
		border: none;
		background-color: #5AC8C8;
		border-radius: 5px;
		padding: 10px;
		width: 100px;
		height: 50px;
		font-size: 24px;
	}
	button:hover {
		color: white;
	}
	table {
		margin-left: auto;
		margin-right: auto;
	}
</style>
</head>
<body>
투표할 항목을 클릭하세요!
	<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "university";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	String query = "";
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	request.setCharacterEncoding("EUC-KR");

	String groupid = (String)session.getAttribute("selectedGroup");

	query = "SELECT * FROM vote natural join item WHERE group_id=? order by deadline,vote_key";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, groupid);
	rs = pstmt.executeQuery();
	
	out.println("<form action='pickCurrent.jsp'>");
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	String temp="-1";
	String temp2="-1";
	String cont="-1";
	String vote_key="-1";
	String itemK="-1";
	int flag=1;
	int ccount=0;
	int tcount=0;
	while(rs.next()){
		out.println("<tr>");
		temp2=rs.getString(1);
		if(!temp.equals(temp2))
		{
			if(flag==0)
			{
				out.println("</table>");
				out.println("<table border=\"1\">");
				ccount=0;
			}
			else
				flag=0;
			
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("<td>deadline : "+rs.getString(3)+"</td>");
			out.println("</tr>");
			
			temp=temp2;
		}
		cont=rs.getString(7);
		itemK=rs.getString(6);
		out.println("<td colspan='2'><label>"+cont+"투표하기"+"</label><input type='checkbox' name='checkB' value='"+itemK+"'></td>");
		ccount++;
		out.println("</form></tr>");
		
	}
	out.println("</table>");
	out.println("<button type='submit'>투표</button>");
	out.println("<button type='button' onclick=\"location.href='./createVote.jsp'\">생성</button>");
	rs.close();
	pstmt.close();
	conn.close();
	%>

</body>
</html>