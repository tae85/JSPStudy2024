<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="common.Person"%>
<%@page import="java.util.LinkedList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - forEach3</title>
</head>
<body>
	<h4>List 컬렉션 사용하기</h4>
	<%
	//List 계열의 컬렉션을 생성한다.
	LinkedList<Person> lists = new LinkedList<Person>();
	
	//Person 인스턴스를 3개 추가
	lists.add(new Person("맹사성", 34));
	lists.add(new Person("장영실", 44));
	lists.add(new Person("신숙주", 54));
	%>
	<!-- set 태그로 page 영역에 속성(변수)를 저장한다. -->
	<c:set var="lists" value="<%= lists %>"/>
	
	<!--  
	해당 변수를 통해 확장 for문을 실행한다. items에 지정한 컬렉션에 저장된 인스턴스의 개수만큼 반복하여 list로
	하나씩 전달한다.
	-->
	<c:forEach items="${ lists }" var="list">
	
	<!-- 각 루프에서는 class에 정의된 getter를 통해 값을 출력한다. -->
	<li>
		이름 : ${ list.name }, 나이 : ${ list.age }
	</li>
	</c:forEach>
	
	<h4>Java 코드를 통한 출력</h4>
	<%
	for( Person p : lists) {
		out.println("이름 : " + p.getName() + ", 나이 : " + p.getAge() + "<br>");
	}
	%>	
	
	<h4>Map 컬렉션 사용하기</h4>
	<%
	/*
	Map 컬렉션 생성. Key는 String, Value는 Person 타입으로 지정
	*/
	Map<String, Person> maps = new HashMap<String, Person>();
	
	//3개의 Person 인스턴스를 추가
	maps.put("1st", new Person("맹사성", 34));
	maps.put("2nd", new Person("장영실", 44));
	maps.put("3rd", new Person("신숙주", 54));
	%>
	
	<!-- set 태그를 통해 변수 저장 -->
	<c:set var="maps" value="<%= maps %>" />
	
	<!-- JSTL을 통해 반복하면 Key를 별도로 얻어올 필요없이 "변수명.key" 혹은 "변수명.value"를 통해 값을
	출력할 수 있다. -->
	<c:forEach items="${ maps }" var="map">
		<li>Key => ${ map.key } <br>
			Value => 이름 : ${ map.value.name }, 나이 : ${ map.value.age }</li>
	</c:forEach>
	
	<h4>Java 코드를 통한 출력</h4>
	<%
	//Map은 항상 Key를 먼저 얻어와야 한다.
	Set<String> keys = maps.keySet();
	for(String key : keys) {
		//Key를 통해 Value를 얻어온다.
		Person p = maps.get(key);
		
		/* Key와 Value를 출력한다. 여기서 Value는 Person 인스턴스 이므로 멤버변수에 저장된 값은 getter를 
		통해 출력한다. */
		out.println("key => " + key + "<br>");
		out.println("value => " + p.getName() + ", " + p.getAge() +"<br>");
	}
	%>
	
</body>
</html>


























