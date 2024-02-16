<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cookie</title>
</head>
<body>
	<!-- 
	쿠키(Cookie) : 클라이언트의 상태 정보를 유지하기 위한 기술로 클라이언트의 PC에 파일형태로 저장된다. 쿠키 하나의
		크기는 4Kb이고 약 3000개까지 만들 수 있다.
	-->
	
	<h2>1. 쿠키(Cookie) 설정</h2>
	<%
	/* 쿠키는 생성자를 통해서만 만들수 있다. setName()이라는 setter가 없으므로 쿠키는 생성한 후 이름을 변경할
	수 없다. */
	Cookie cookie = new Cookie("myCookie", "쿠키맛나요");
	
	/* 쿠키의 경로설정. 컨텍스트루트 경로를 지정하면 웹애플리케이션 전체에서 사용할 수 있게된다. */
	cookie.setPath(request.getContextPath());
	
	/* 쿠키의 유지시간 설정. 3600초이므로 1시간으로 설정한다. */
	cookie.setMaxAge(3600);
	
	/* 응답헤더에 쿠키를 추가한 후 클라이언트 측으로 전송한다. */
	response.addCookie(cookie);
	/*
	여기까지의 코드를 통해 클라이언트 측의 PC에 쿠키가 생성된다. F12를 눌러 개발자 모드에서 호가인할 수 있다.
	*/
	%>
	
	<h2>2. 쿠키 설정 직후 쿠키값 확인하기</h2>
	<% 
	/*
	request 내장객체의 getCookies()를 통해 생성된 모든 쿠키를 배열로 가져온다.
	*/
	Cookie[] cookies = request.getCookies();
	if(cookies != null) {
		for(Cookie c : cookies) {
			//쿠키명가 쿠키값을 변수에 저장한 후 웹 브라우저에 출력한다.
			String cookieName = c.getName();
			String cookieValue = c.getValue();
			out.println(String.format("%s : %s<br/>", cookieName, cookieValue));
					
		}
	}
	/*
	쿠키가 생성된 직후에는 쿠키값을 읽을 수 없다. 클라이언트 측에 저장된 쿠키를 서버로 다시 전송하기 위해 새로고침
	하거나 페이지 이동을 해야지만 서버는 쿠키의 내용을 읽을 수 있다.
	*/
	%>
	
	<h2>3. 페이지 이동 후 쿠키값 확인하기</h2>
	<a href="CookieResult.jsp">다음 페이지에서 쿠키값 확인하기</a>
</body>
</html>

























