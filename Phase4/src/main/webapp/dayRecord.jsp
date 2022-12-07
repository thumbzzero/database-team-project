<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>우리우정 012</title>
<link rel="stylesheet" href="./common.css" />
<style>
	div {
		margin-top: 150px;
	}
	button {
		border: none;
		background-color: #5AC8C8;
		border-radius: 100%;
		width: 300px;
		height: 300px;
		padding: 10px;
		cursor: pointer;
		font-size: 1.7rem;
		margin: 20px;
	}
	button:hover {
		color: white;
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
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt = null;
	
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();

	
	String date = request.getParameter("date");
	String clickedDate = "202209" + date;
	if (Integer.parseInt(date) < 10) {
		clickedDate = "2022090" + date;
	}
	session.setAttribute("clickedDate", clickedDate);
	
	String sql = "";
	String str_num = (String)session.getAttribute("num");
	String diary_key = Integer.toString(Integer.parseInt(str_num));
	String id = "hyejjang";
	String group_id = (String)session.getAttribute("selectedGroup");
	
	//String query = "select date_key from day_record where date_key = " + diary_key;
	//pstmt = conn.prepareStatement(query);
	//rs = pstmt.executeQuery();
	
	int res=0;
	
	sql = "insert into day_record values(" + diary_key + ", To_date('" 
			+ clickedDate + "', 'yyyy-mm-dd'), NULL, NULL, 1, '" + group_id + "', " + clickedDate  + ")";
	System.out.println(str_num);
	System.out.println(sql);
	try{
		res = stmt.executeUpdate(sql);
	}
	catch(SQLIntegrityConstraintViolationException e1)
	{
		sql="update day_record set  date_key="+diary_key+ " where question_key="+clickedDate+" and group_id='"+group_id+"'";
		System.out.println(sql);
		res = stmt.executeUpdate(sql);
		System.out.println("업테이트 함 day_record. date_key는 "+diary_key);

	}
	/*try{
	sql="update day_record set date_key="+diary_key+ " where question_key="+clickedDate+" and group_id='"+group_id+"'";
	System.out.println("diary_key : "+str_num);
	System.out.println(sql);
	res = stmt.executeUpdate(sql);
	System.out.println("업테이트 함 day_record. date_key는 "+diary_key);
	}
	catch(SQLIntegrityConstraintViolationException e1)
	{
		sql = "insert into day_record values(" + diary_key + ", To_date('" 
				+ clickedDate + "', 'yyyy-mm-dd'), NULL, NULL, 1, '" + group_id + "', " + clickedDate  + ")";
		System.out.println(str_num);
		System.out.println(sql);
		res = stmt.executeUpdate(sql);
		
	}
*/	
	System.out.println(res + " row inserted.");

	%>
	<div>
	<a href='addDiary.html'><button>오늘의 일기 생성하기</button></a>
	<a href='answerInput.jsp'><button>오늘의 질문에 답하러 가기</button></a>
	<a href='voteRecent.jsp'><button>투표 조회/생성</button></a>
	</div>
</body>
</html>
