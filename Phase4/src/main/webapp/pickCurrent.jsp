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
	table {
		margin-left: auto;
		margin-right: auto;
	}
	button {
		margin-top: 50px;
		margin-bottom: 30px;
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
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	String query = "";
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	request.setCharacterEncoding("utf-8");

	String[] items = request.getParameterValues("checkB");
	if(items != null) {
		int res;
		for(String item: items) {
			query = "insert into pick values('hyejjang',?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, item);
			try{
				res=pstmt.executeUpdate();
			}
			catch (SQLIntegrityConstraintViolationException e1)
			{
				continue;	
			}
		}
	}
	//type8
	String groupid = (String)session.getAttribute("selectedGroup");
	query = "select vote_name, item_name, name "+
			"from((item natural join vote )natural join pick) join users on user_id=id "+
			"where vote_key in ( select vote_key from item natural join vote where group_id=?) "+
			"order by vote_key,item_key";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, groupid);//그룹아이디
	rs = pstmt.executeQuery();
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	String temp="-1";
	String temp2="-1";
	int flag=1;
	for(int i=1;i <= cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		temp2=rs.getString(1);
		if(!temp.equals(temp2))
		{
			if(flag==0)
			{
				out.println("</table>");
				
				out.println("<table border=\"1\">");
				for(int i=1;i <= cnt;i++){
					out.println("<th>"+rsmd.getColumnName(i)+"</th>");
				}
				out.println("<tr>");
			}
			else
				flag=0;
			temp=temp2;
		}
		out.println("<td>"+temp2+"</td>");			
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>");
		out.println("</tr>");
			
	}
	out.println("</table>");
	out.println("<button type='button' onclick=\"location.href='./voteRecent.jsp'\">투표로 돌아가기</button>");

	pstmt.close();
	conn.close();
	%>
</body>
</html>