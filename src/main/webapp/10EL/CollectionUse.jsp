<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="common.Person"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 컬렉션</title>
</head>
<body>
<h2>List 컬렉션</h2>
<%
//List 컬렉션을 Object 기반으로 생성
List<Object> aList = new ArrayList<Object>();

//아래와 같이 타입매개변수를 생략해도 Object 기반의 컬렉션이 된다.
List aList2 = new ArrayList();

//String 인스턴스 추가
aList.add("청해진");

//Person 인스턴스 추가
aList.add(new Person("장보고", 28));

//EL은 4가지 영역에 저장된 값을 대상으로 하므로 page 영역에 저장한다.
pageContext.setAttribute("Ocean", aList);
%>
<ul>
	<!-- String 인스턴스가 출력된다. ArrayList는 배열의 특성을 가지므로 인덱스로 접근한다. -->
	<li>0번째 요소 : ${ Ocean[0] }</li>
	
	<!-- Person 인스턴스를 출력한다. 멤버변수명을 통해 getter를 호출하여 출력한다. getter를 정의하지 않으면
	에러가 발생한다. -->
	<li>1번째 요소 : ${ Ocean[1].name }, ${ Ocean[1].age }</li>
	
	<!-- 2번 인덱스는 아무런 값도 없으므로 출력되지 않는다. Java라면 예외가 발생하겠지만 EL에서는 예외가 발생하지 
	않는다. -->
	<li>2번째 요소 : ${ Ocean[2] }</li>
</ul>
<h2>Map 컬렉션</h2>
<%
//Map 컬렉션을 생성한다. Key와 Value 모두 String 타입으로 선언한다.
Map<String, String> map = new HashMap<String, String>();

//Key로 한글과 영문을 각각 사용하여 저장한다.
map.put("한글", "훈민정음");
map.put("Eng", "English");

//page영역에 저장한다.
pageContext.setAttribute("King", map);
%>
<ul>
	<!-- Key가 영문인 경우에는 아래 3가지 방식으로 출력할 수 있다. -->
	<li>영문 Key : ${ King["Eng"] },  ${ King['Eng'] },  ${ King.Eng }</li> 
	
	<!-- 단, Key가 한글인 경우에는 배열의 형태로만 사용할 수 있고, 닷(.)은 사용할 수 없다. -->
	<li>한글 Key : ${ King["한글"] },  ${ King['한글'] },  \${ King.한글 }</li> 
	<!--  
	EL 앞에 역슬러쉬를 붙이면 일종의 주석이 된다. 코드가 숨겨지진 않고 입력한 모양 그대로 출력된다.
	-->
</ul>
</body>
</html>






















