<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//로그아웃 처리
//방법1 : session 영역에 저장된 속성명을 지정해서 삭제한다.
session.removeAttribute("UserId");
session.removeAttribute("UserName");

//방법2 : 모든 속성을 한꺼번에 삭제한다.
session.invalidate();

//로그아웃 처리 후 로그인 페이지로 '이동'한다.
response.sendRedirect("LoginForm.jsp");
%>
