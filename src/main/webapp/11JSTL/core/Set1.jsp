<%@page import="common.Person"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  
JSTL의 core 관련 태그를 사용하기 위한 taglib 지시어 선언. 
prefix는 접두어, uri는 태그를 지원하는 예약어가 삽입된다. 
우리는 Tomcat10.x를 사용하므로 두번째 지시어를 사용하면 된다.
Tomcat9.x 이하의 버전이라면 첫번째 지시어를 사용해야 한다.
-->
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - set 1</title>
</head>
<body>
<!-- 
set태그 
: 변수를 선언할 때 사용. JSP의 setAttribute()와 동일하게 4가지 영역에 새로운 속성을 추가한다.
	var : 속성명(즉 변수명). 영역에 저장될 이름.
	value : 속성에 저장할 값.
	scope : 4가지 영역명을 지정. 생략시 가장 좁은 page 영역에 저장.
	target : set 태그를 통해 생성된 자바빈즈의 이름을 지정.
	property : target으로 지정된 자바빈즈의 멤버변수를 지정. 내부적으로 setter를 호출하여 값을 설정함.
-->
	<!--  
	변수선언 : scope 속성이 생략되었으므로 가장 좁은 page 영역에 저장됨. value에는 일반값, EL, 표현식 모두
	사용할 수 있다. 또한 태그사이에 값을 삽입할 수도 있다.
	-->
	<c:set var="directVar" value="100" />
	<c:set var="elVar" value="${ directVar mod 5 }" />
	<c:set var="betweenVar" >변수값 요렇게 설정</c:set>
	<c:set var="expVar" value="<%= new Date() %>" />
	
	<h4>EL을 이용해 변수 출력</h4>
	<!--  
	속성명이 중복되지 않는다면 영역을 표시하는 EL의 내장객체를 생략할 수 있다. 대부분 생략해서 사용한다.
	-->
	<ul>
		<li>directVar : ${ pageScope.directVar }</li>
		<li>elVar : ${ elVar }</li>
		<li>expVar : ${ expVar }</li>
		<li>betweenVar : ${ betweenVar }</li>
	</ul>
	
	<h4>자바빈즈 생성 1 - 생성자 사용</h4>
	<!--  
	클래스의 생성자를 통해 인스턴스를 생성한 후 request 영역에 저장한다.
	아래 문장 작성시 JSTL은 JSP코드이므로 value 속성을 기술할 때 인스턴스를 생성하기 위한 더블쿼테이션이
	겹쳐지는 경우가 발생하게 된다. 이때는 value를 싱글쿼테이션으로 감싸서 겹쳐지지 않게 작성해야 한다.
	-->
	<c:set var="personVar1" value='<%= new Person("박문수", 50) %>' scope="request" />
	<!-- EL을 통해 getter를 호출하여 멤버변수의 값을 출력한다. -->
	<ul>
		<li>이름 : ${ requestScope.personVar1.name }</li>
		
		<!-- 속성명이 유일하므로 requestScope는 생략하는 것이 일반적이다. -->
		<li>나이 : ${ personVar1.age }</li>
	</ul>
	
	<h4>자바빈즈 생성 2 - target, property 사용</h4>
	<!--  
	디폴트생성자를 통해 초기값이 없는 인스턴스를 생성한 후 초기값을 설정한다. target을 통해 자바빈즈를 선택하고,
	property를 통해 멤버변수명을 지정한다. 값 설정시 setter()를 호출하게 된다.
	-->
	<c:set var="personVar2" value='<%= new Person() %>' scope="request"/>
	<c:set target="${ personVar2 }" property="name" value="정약용" />
	<c:set target="${ personVar2 }" property="age" value="60" />
	<ul>
		<li>이름 : ${ personVar2.name }</li>
		<li>나이 : ${ requestScope.personVar2.age }</li>
	</ul>
</body>
</html>





















