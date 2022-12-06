<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>우리우정 012</title>
</head>
<body>
<%	
	String str_num = (String)session.getAttribute("num");
	int num = Integer.parseInt(str_num);
	num++;
	session.setAttribute("num", Integer.toString(num));
	
	String diary_key = Integer.toString(num);
	String diary_content = request.getParameter("diary_content");
	String DIARY_date = (String)session.getAttribute("clickedDate");
	String id = "hyejjang";
	
	String sql = "insert into Diary values(" + diary_key + ", '" + diary_content + 
			"',  To_date('" + DIARY_date + "', 'yyyy-mm-dd'),'" + id + "'," + diary_key +")";
	System.out.println(sql);
%>
</body>
</html>