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
	<h2>영역을 통해 전달된 객체 읽기</h2>
	<!--  
	영역에 저장된 속성에 EL로 접근할 때는 속성명이 중복되지 않는다면 EL내장객체없이 속성명만으로 출력할 수 있다.
	즉, requestScope.personObj.name 형태로 기술하지 않아도 된다.
	
	"속성명.멤버변수명" 형태로 기술하면 클래스에 선언된 getter()를 자동으로 호출하여 값을 출력한다. 즉 아래 문장은
	게터를 호출하고 있으므로 클래스에서 getName()을 주석처리하면 에러가 발생하게 된다.
	-->
	<ul>
		<li>Person 객체 => 이름 : ${ personObj.name },
						나이 : ${ personObj.age }</li>
		<li>String 객체 => ${ requestScope.stringObj }</li>
		<li>Integer 객체 => ${ integerObj }</li>
	</ul>
	
	<h2>JSP 내장객체를 통해 영역의 값 읽어오기</h2>
	<%
	//영역에는 모든 객체를 저장할 수 있으므로 Object로 저장된다.
	Object object = request.getAttribute("personObj");
	
	//영역에서 꺼낸 후에는 원래의 타입으로 형변환해야 한다.
	Person person = (Person) object;
	
	//출력시에는 멤버변수에 직접 접근할 수 없으므로 getter를 호출한다.
	out.println("이름:" + person.getName());
	//이런 모든 절차를 EL은 자동으로 처리해준다.
	%>
	
	<!--  
	파라미터로 전달된 값을 읽을 때는 아래 3가지 방식을 모두 사용할 수 있다.
		param.파라미터명
		param['파라미터명']
		param["파라미터명"]
	-->
	<h2>매개변수로 전달된 값 읽기</h2>
	<ul>
		<!-- EL안에서 파라미터끼리 더하므로 실제 덧셈연산이 된다. -->
		<li>${ param.firstNum + param['secondNum'] }</li>
		
		<!-- 10과 20이 각각 출력된다. -->
		<li>${ param.firstNum } + ${ param["secondNum"] } </li>
	</ul>
</body>
</html>


























