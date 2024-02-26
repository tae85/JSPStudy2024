<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 내장 객체</title>
</head>
<body>
	<h2>ImplicitForwardResult 페이지</h2>
	<h3>각 영역에 저장된 속성 읽기</h3>
	<!--  
	포워드 되면 page 영역은 소멸되고, request 영역은 공유되므로 아래에서는 page 영역 부분에 아무런 값도 
	출력되지 않는다.
	-->
	
	<ul>
		<li>페이지 영역 : ${ pageScope.scopeValue }</li>
		<li>리퀘스트 영역 : ${ requestScope.scopeValue }</li>
		<li>세션 영역 : ${ sessionScope.scopeValue }</li>
		<li>애플리케이션 영역 : ${ applicationScope.scopeValue }</li>
	</ul>	
	
	<!-- 표현식으로 출력하는 경우 null이 화면에 출력된다. -->
	<%= pageContext.getAttribute("scopeValue") %>
	
	<!-- 
	포워드 된 페이지에서는 page영역이 소멸되므로, request 영역이 가장 좁은 영역이 되어 해당값이 출력된다. -->
	<h3>영역 지정 없이 속성 읽기</h3>
	<ul>
		<li>${ scopeValue }</li>
	</ul>
	<!--  
	앞의 Main파일을 한번 실행하면 4가지 영역 전체에 속성값이 저장된다. 특히 session, application 영역의 속성값은
	브라우저를 종료하거나 서버를 종료해야 소멸되는 영역이므로 해당 파일을 단독으로 실행하면 두 영역의 값이 출력된다. 여기서
	가장 좁은 영역은 session이 된다
	-->

</body>
</html>