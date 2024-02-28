<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AnnoMapping</title>
</head>
<body>
	<h2>어노테이션으로 매핑하기</h2>
	<p>
		<!-- EL은 null 값에 관대하므로 아래에서는 아무것도 출력되지 않는다. -->
		<strong>${message}</strong>
		<br />
		<!-- request 내장객체를 이용해서 현재 프로젝트의 컨텍스트루트 경로를 얻어온 후 링크에 적용한다.
		이런 경우 절대경로로 링크를 설정하면 된다. -->
		<a href="<%= request.getContextPath() %>/12Servlet/AnnoMapping.do">바로가기</a>
	</p>
</body>
</html>