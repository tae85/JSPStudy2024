<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
로그인 체크를 위한 파일로 세션영역에 UserId라는 속성값이 없다면 로그아웃 상태이므로 경고창을 띄운 후 로그인 페이지로
강제 이동시킨다. 로그인 체크가 필요한 모든 페이지 상단에 include 지시어를 통해 포함시킨다.
*/
if(session.getAttribute("UserId") == null) {
	JSFunction.alertLocation("로그인 후 이용해주십시오.", "../06Session/LoginForm.jsp", out);
	
	//JSP실행을 중지시킨다.
	return; 
}
%>