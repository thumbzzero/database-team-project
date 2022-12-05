<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>우리우정 012</title>
</head>
<body>
	<%
	String date = request.getParameter("date");
	System.out.println(date);
	%>
	<button><input name="date" type="submit" value="1" /></button>
</body>
</html>