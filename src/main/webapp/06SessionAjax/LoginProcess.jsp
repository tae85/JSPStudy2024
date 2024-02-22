<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");
System.out.println(userId + " = " + userPwd);

String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
dao.close();

if(memberDTO.getId() != null) {
	session.setAttribute("UserId", memberDTO.getId());
	session.setAttribute("UserName", memberDTO.getName());
	out.println("로그인 성공!!");
}
else {
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	out.println("로그인 실패~~");
}
%>





























