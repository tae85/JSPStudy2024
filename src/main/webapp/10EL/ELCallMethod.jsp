<%@page import="el.MyELClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//정적메서드가 아닌 일반적인 메서드는 객체를 통해 호출해야 하므로 객체를 생성한 후 EL에서 접근할 수 있도록 영역에 저장한다.
MyELClass myClass = new MyELClass();
pageContext.setAttribute("myClass", myClass);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 메서드 호출</title>
</head>
<body>
	<!-- 일반적인 메서드 호출 -->
	<h3>영역에 저장 후 메서드 호출하기</h3>
	001225-3000000 => ${ myClass.getGender("001225-3000000") } <br>
	001225-2000000 => ${ myClass.getGender("001225-2000000") } 
	
	<!-- 정적메서드의 경우 객체 생성없이 클래스명으로 직접 호출할 수 있다. -->
	<h3>클래스명을 통해 정적메서드 호출하기</h3>
	${ MyELClass.showGugudan(8) }
</body>
</html>