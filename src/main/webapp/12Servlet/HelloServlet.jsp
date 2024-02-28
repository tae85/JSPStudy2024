<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HelloServlet</title>
</head>
<body>
	<h2>web.xml에서 매핑 후 JSP에서 출력하기</h2>
	<p>
		<!-- request 영역에 저장된 속성값을 출력한다. -->
		<strong><%= request.getAttribute("message") %></strong>
		<br />
		<!-- 상대경로로 요청명에 대한 링크 작성 -->
		<a href="./HelloServlet.do">바로가기</a>
	</p>
</body>
</html>