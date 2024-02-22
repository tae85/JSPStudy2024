<%@page import="utils.JSFunction"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//전송된 폼값을 받는다.
String user_id = request.getParameter("user_id");
String user_pw = request.getParameter("user_pw");

/*
체크박스의 경우 둘 이상의 항목인 경우라면 getParameterValues()를 통해 폼값을 받아야 하지만, 항목이 한개라면
아래와 같이 받을 수 있다.
*/
String save_check = request.getParameter("save_check");

//단순히 문자열 비교를 통해 로그인 성공/실패를 판단한다.
if ("must".equals(user_id) && "1234".equals(user_pw)) {
	if(save_check != null && save_check.equals("Y")) {
		/* 로그인에 성공하고, 아이디 저장에 체크한 경우에는 하루 동안 유효한 쿠키를 생성한다. 쿠키값으로는 로그인
		아이디가 저장된다. */
		CookieManager.makeCookie(response, "loginId", user_id, 86400);
	}
	else {
		/* 로그인에 성공하고, 아이디저장을 체크하지 않은 경우에는 쿠키를 삭제한다. */
		CookieManager.deleteCookie(response, "loginId");
	}
	//로그인 성공시에는 경고창을 띄운 후 로그인 페이지로 이동한다.
	JSFunction.alertLocation("로그인에 성공했습니다.", "IdSaveMain.jsp", out);
}
else {
	//로그인에 실패한 경우 경고창을 띄운 후 뒤로 이동한다.
	//JSFunction.alertBack("로그인에 실패했습니다.", out);
	
%>
	<script>
		alert('로그인 실패!!!!!');
		history.go(-1);
	</script>
<%
}
%>





























