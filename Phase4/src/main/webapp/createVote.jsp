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
	h1 {
		margin-top: 50px;
	}
	table {
		margin: 100px auto;
	}
</style>
</head>
<body>
 <form
    action="./voteSet.jsp"
    method="get"
  >
  <h1 for="titleVote">제목 : </h1>
  <input id="titleVote" name="title" type="text" value="title">
  <table>
    <tr>
      <td>
        <input id="firstItem" name="item1" type="text" placeholder="첫번째 투표항목을 입력하세요">
      </td>
    </tr>
    <tr> 
      <td><input id="secondItem" name="item2" type="text" placeholder="두번째 투표항목을 입력하세요">
      </td>
    </tr>
    <tr>
      <td>
        <input id="thirdItem" name="item3" type="text" placeholder="세번째 투표항목을 입력하세요">
      </td>
    </tr>
    <tr>
      <td>
        <input id="fourthItem" name="item4" type="text" placeholder="네번째 투표항목을 입력하세요">
      </td>
    </tr>
    <tr>
      <td>
        <input id="deadline" name="deadline" type="text" placeholder="마감일을 입력하세요">
      </td>
    </tr>
    
  </table>
  <button type="submit">만들기</button>
  <button type="reset">초기화</button>
</form>

</body>
</html>