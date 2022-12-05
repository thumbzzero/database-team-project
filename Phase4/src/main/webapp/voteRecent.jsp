<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Repeating Lab</title>
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

	String groupid = (String)session.getAttribute("gid");

	query = "SELECT * FROM vote natural join item WHERE group_id=? order by deadline,vote_key";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, groupid);
	rs = pstmt.executeQuery();

	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	String temp="-1";
	String temp2="-1";
	String cont="-1";
	int flag=1;
	int count=-1;
	while(rs.next()){
		count++;
		out.println("<tr>");
		temp2=rs.getString(1);
		if(!temp.equals(temp2))
		{
			if(flag==0)
			{
				out.println("</table>");
				out.println("<table border=\"1\">");		
			}
			else
				flag=0;
			
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("<td>deadline : "+rs.getString(3)+"</td>");
			out.println("</tr>");
			
			temp=temp2;
		}
		cont=rs.getString(7);
		out.println("<td>"+cont+"</td>");
		out.println("<td><input type='button' id='button1' onclick='button1_click("+cont+");' value='"+cont+"투표하기' /></td>");
		out.println("</tr>");
	}
	out.println("</table>");
	out.println("<button type='button' onclick=\"location.href='./createVote.html'\">생성하기</button>");
	rs.close();
	pstmt.close();
	conn.close();
	%>

</body>
</html>