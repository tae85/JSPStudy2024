<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 객체 매개변수</title>
</head>
<body>
	<%
	//3가지 객체를 생성한 후 request 영역에 저장한다.
	request.setAttribute("personObj", new Person("홍길동", 33));
	request.setAttribute("stringObj", "나는 문자열");
	request.setAttribute("integerObj", new Integer(99));
	%>
	<!--  
	액션태그를 통해 포워드한다. 이때 2개의 정수를 파라미터로 전달한다. param 액션태그는 쿼리스트링을 통해 파라미터를
	전달하는 것과 동일한 방식을 사용한다. 즉 "파일명?이름=값"처럼 동작한다.
	-->
	<jsp:forward page="ObjectResult.jsp">
		<jsp:param value="10" name="firstNum" />
		<jsp:param value="20" name="secondNum" />
	</jsp:forward>
	<%-- 
	위 액션태그를 JSP로 표현하면 아래와 같이 기술할 수 있다.
	request.getRequestDispatcher("ObjectResult.jsp?firstNum=10&secondNum=20")
		.forward(request, response);
	--%>
</body>
</html>