<%@page import="java.util.Collection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//날짜 형식을 지정한다.
SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm");

//getTime() : 타임스탬프. 초단위로 변경된 시간을 long 타입의 변수에 저장한다.
long add_date = s.parse(request.getParameter("add_date")).getTime();

/* 문자열로 전송되는 값을 실제 날자로 변경하기 위해 포맷을 지정한 후 타임스탬프로 변경한다. */
System.out.println("add_date="+add_date);

//전송된 폼값을 정수로 변환한다. 
int add_int = Integer.parseInt(request.getParameter("add_int"));

//문자열은 그대로 사용하면 된다.
String add_str = request.getParameter("add_str");

/*
addDateHeader() : 응답헤더에 날짜형식을 추가하는 경우 long타입의 타임스탬프로 변환 후 추가한다.
addIntHeader() : 숫자형식의 응답헤더를 추가한다.
addHeader() : 문자형식의 응답헤더를 추가한다.
*/
//날짜형식의 헤더값 추가
response.addDateHeader("myBirthday", add_date);
//정수형식 추가. 동일한 헤더명으로 2개의 값이 추가된다.
response.addIntHeader("myNumber", add_int);
response.addIntHeader("myNumber", 1004);
//최초 '홍길동'이 추가된 후 '안중근'으로 변경된다.
response.addHeader("myName", add_str);
response.setHeader("myName", "안중근");

//웹브라우저가 인식하지 못하는 컨텐츠타입을 응답헤더에 설정하면 다운로드창을 띄우게 된다.
//response.setContentType("application/octet-stream");	//다운로드할 때 필요
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - response</title>
</head>
<body>
	<h2>응답 헤더 정보 출력하기</h2>
	<%
	//getHeaderNames()를 통해 응답헤더명 전체를 얻어온다.
	Collection<String> headerNames = response.getHeaderNames();
	
	//확장 for문으로 얻어온 개수만큼 반복한다.
	for(String hName : headerNames) {
		//헤더명을 통해 헤더값을 얻어온 후 출력한다.
		String hValue = response.getHeader(hName);
	%>
		<li><%=hName %> : <%= hValue %></li>
	<% 
	}
	/*
	출력결과에서 날짜의 경우 하루 전인 11월 30일이 출력된다. 이것은 대한민국이 세계표준시(그리니치 천문대)에 +09
	즉, 9시간이 빨라서 생기는 현상으로 9시간을 더해줘야 정상적인 날짜가 출력된다.
	
	myNumber라는 헤더명이 2번 출력되는데 8282만 나오는걸 볼 수 있다. 이것은 getHeader()메서드의 특성으로
	처음 입력한 헤더값만 출력된다.
	*/
	%>
	
	<h2>myNumber만 출력하기</h2>
	<%
	/*
	myNumber라는 헤더명으로 2개의 값을 추가했으므로 아래에서는 각각의 값이 정상적으로 출력된다. 즉 add계열의
	메서드는 헤더명을 동일하게 사용하더라도 덮어쓰기 되지 않고 각각 추가되게 된다.
	*/
	Collection<String> myNumber = response.getHeaders("myNumber");
	for(String myNum : myNumber) {
	%>
		<li>myNumber : <%= myNum %></li>
	<% 
	}
	%>
</body>
</html>




















