<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>친구들의 답변을 확인해봐요!</title>
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

    String questionkey = (String)session.getAttribute("clickedDate");


    System.out.println(questionkey);

    query = "select u.name, a.user_answer from users u, Answer a Where u.id=a.id and question_key = '" + questionkey + "'";

    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    
    //out.println("---------------------------");
    
    ResultSetMetaData rsmd = rs.getMetaData();
    int cnt = rsmd.getColumnCount();
    //for(int i =1;i<=cnt;i++){
    //    out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    //}

    while(rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+": </td>");
        out.println("</tr>");   
        out.println("<tr>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("</tr>"); 
    }

    rs.close();
    pstmt.close();
    conn.close();
    %>

</body>
</html>
