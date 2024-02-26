<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//4가지 영역에 동일한 속성명으로 각기 다른 값을 저장한다.
pageContext.setAttribute("scopeValue", "페이지 영역");
request.setAttribute("scopeValue", "리퀘스트 영역");
session.setAttribute("scopeValue", "세션 영역");
application.setAttribute("scopeValue", "애플리케이션 영역");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 내장 객체</title>
</head>
<body>
	<h2>ImplicitObjMain 페이지</h2>
	
	<!-- 
	4가지 영역에 접근할 때는 EL의 내장객체를 통해 내용을 출력한다. 모두 동일한 패턴으로 "영역명Scope"와 같은 형태로
	되어 있다. EL의 내장객체에 .(닷)을 추가하여 속성명을 기술한다.
	 -->
	<h3>각 영역에 저장된 속성 읽기</h3>
	<ul>
		<li>페이지 영역 : ${ pageScope.scopeValue }</li>
		<li>리퀘스트 영역 : ${ requestScope.scopeValue }</li>
		<li>세션 영역 : ${ sessionScope.scopeValue }</li>
		<li>애플리케이션 영역 : ${ applicationScope.scopeValue }</li>
	</ul>
	
	<!-- 
	만약 영역명 지정없이 속성을 읽을 때는 가장 좁은 영역을 우선으로 출력한다. 즉, 여기서는 page 영역의 속성을 출력하게
	된다. 실질적인 사용에서는 주로 동일한 속성명으로 저장하는 경우가 없으므로 대부분 이와 같이 사용할 수 있다.
	 -->
	<h3>영역 지정 없이 속성 읽기</h3>
	<ul>
		<li>${ scopeValue }</li>
	</ul>
	<!-- 액션태그를 통한 포워드 -->
	<%-- <jsp:forward page = "ImplicitForwardResult.jsp" /> --%>
	<%
	//JSP코드를 통한 포워드
	request.getRequestDispatcher("ImplicitForwardResult.jsp").forward(request, response);
	/*
	JSP 페이지에서 포워드는 위 2가지 방법을 사용할 수 있는데, 액션태그를 사용하면 좀 더 간편하게 표현할 수 있다. 현재
	페이지로 들어온 요청을 포워드된 페이지로 전달한다.
	*/
	%>
</body>
</html>

























