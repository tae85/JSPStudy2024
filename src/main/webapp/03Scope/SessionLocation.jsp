<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>session 영역</title>
</head>
<body>
	<h2>페이지 이동 후 session 영역의 속성 읽기</h2>
	<%
	/*
	앞 페이지에서 session영역에 데이터를 저장했으므로 이동된 두번째 페이지에서도 그 내용을 확인할 수 있다.
	단, 모든 실행창(웹브라우저)을 닫은 후 해당 페이지를 단독으로 실행하면 예외가 발생하게 된다. 세션영역은
	웹 브라우저를 닫으면 소멸된다.
	*/
	ArrayList<String> lists = (ArrayList<String>)session.getAttribute("lists");
	for(String str : lists)
		out.print(str + "<br/>");
	%>
</body>
</html>