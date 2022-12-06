<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>우리우정 012</title>
<link rel="stylesheet" href="./common.css" />
<style>
	h1 {
		margin: 70px 0 30px 0;
	}
	table {
		margin: 10px auto;
		width: 50%;
		height: 500px;
		border: 1px solid #5AC8C8;
	}
	th {
		height: 20px;
		border: 1px solid #5AC8C8;
	}
	td {
		height: 90px;
		text-align: left;
		vertical-align: top;
		border: 1px solid #5AC8C8;
	}
	input {
		border: none;
		background: none;
		cursor: pointer;
		font-size: 20px;
	}
	input:hover {
		color: red;
	}
</style>
</head>
<body>
<%
	String selectedGroup = request.getParameter("selectedGroup");
	System.out.println(selectedGroup);
	session.setAttribute("selectedGroup", selectedGroup);
%>
<h1>2022년 09월</h1>
	<form method=get action="dayRecord.jsp">
	<table>
		<tr>
			<th>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>	
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td><input name="date" type="submit" value="1" /></td>
			<td><input name="date" type="submit" value="2" /></td>
			<td><input name="date" type="submit" value="3" /></td>
		</tr>
		<tr>
			<td><input name="date" type="submit" value="4" /></td>
			<td><input name="date" type="submit" value="5" /></td>
			<td><input name="date" type="submit" value="6" /></td>
			<td><input name="date" type="submit" value="7" /></td>
			<td><input name="date" type="submit" value="8" /></td>
			<td><input name="date" type="submit" value="9" /></td>
			<td><input name="date" type="submit" value="10" /></td>
		</tr>
		<tr>
			<td><input name="date" type="submit" value="11" /></td>
			<td><input name="date" type="submit" value="12" /></td>
			<td><input name="date" type="submit" value="13" /></td>
			<td><input name="date" type="submit" value="14" /></td>
			<td><input name="date" type="submit" value="15" /></td>
			<td><input name="date" type="submit" value="16" /></td>
			<td><input name="date" type="submit" value="17" /></td>
		</tr>
		<tr>
			<td><input name="date" type="submit" value="18" /></td>
			<td><input name="date" type="submit" value="19" /></td>
			<td><input name="date" type="submit" value="20" /></td>
			<td><input name="date" type="submit" value="21" /></td>
			<td><input name="date" type="submit" value="22" /></td>
			<td><input name="date" type="submit" value="23" /></td>
			<td><input name="date" type="submit" value="24" /></td>
		</tr>
		<tr>
			<td><input name="date" type="submit" value="25" /></td>
			<td><input name="date" type="submit" value="26" /></td>
			<td><input name="date" type="submit" value="27" /></td>
			<td><input name="date" type="submit" value="28" /></td>
			<td><input name="date" type="submit" value="29" /></td>
			<td><input name="date" type="submit" value="30" /></td>
			<td></td>
		</tr>
	</table>
	</form>
</body>
</html>