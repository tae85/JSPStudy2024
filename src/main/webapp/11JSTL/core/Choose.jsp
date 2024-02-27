<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - choose/when/otherwise</title>
</head>
<body>
<!--  
choose태그 : 하위에 when, otherwise 태그를 가지고 있다. 여러 조건이 있는 경우 사용하기에 적합하다.
-->
	<c:set var="number" value="100"/>
	
	<h4>choose 태그로 홀짝 판단하기</h4>
	<!--  
	choose 태그와 when 태그 사이에 HTML 주석을 기술하면 에러가 발생한다. 또한 when과 otherwise 사이에도
	기술할 수 없다.
	if 태그와 동일하게 test 속성에 조건을 기술한다. 또한 공백(스페이스)이 들어가면 무조건 false로 판단하므로
	주의해야 한다.
	-->
	<c:choose>
		<c:when test="${ number mod 2 eq 0 }">
		<!-- number를 2로 나눈 나머지가 0이면 짝수로 판단 -->
			${ number }는 짝수 입니다.
		</c:when>
		<c:otherwise>
		<!-- else와 동일한 역할을 한다. 위 조건에 만족되지 않을 때 실행된다. -->
			${ number }는 홀수 입니다.
		</c:otherwise>
	</c:choose>
	
	<h4>국, 영, 수 점수를 입력하면 평균을 내어 학점 출력</h4>
	<!-- form 태그에 아무런 속성이 없으면 get 방식으로 현재페이지로 폼값을 전송한다. -->
	<form>
		국어 : <input type="text" name="kor" /><br>
		영어 : <input type="text" name="eng" /><br>
		수학 : <input type="text" name="math" /><br>
		<input type="submit" value="학점 구하기" />
	</form>
	
	<!--  
	국, 영, 수 3과목 모두 점수를 입력해야지만 조건에 만족하므로 하나라도 입력되지 않으면 평균점수는 출력되지 않는다.
	-->
	<c:if test="${ not (empty param.kor or empty param.eng or empty param.math) }">
		<!--  
		3과목의 점수를 합산 후 평균을 구한다. 결과는 avg에 저장된다. EL은 자동형변환을 지원하므로 경우에 따라 실수의
		결과가 나올 수 있다.
		-->
		<c:set var="avg" value="${ (param.kor + param.eng + param.math) / 3 }" />
		평균 점수는 ${ avg }으로
		<!--  
		평균점수를 통해 조건을 걸어 학점을 출력한다. when 태그는 if 혹은 if else와 동일하고 otherwise는 
		else와 동일하다.
		-->
		<c:choose>
			<c:when test="${ avg >= 90 }">A 학점</c:when>
			<c:when test="${ avg >= 80 }">B 학점</c:when>
			<c:when test="${ avg ge 70 }">C 학점</c:when>
			<c:when test="${ avg ge 60 }">D 학점</c:when>
			<c:otherwise>F 학점</c:otherwise>
		</c:choose>
		입니다.
	</c:if>

</body>
</html>



























