<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장객체 - request</title>
</head>
<body>
<!-- 
<form>태그를 통한 전송방식 비교
1.get방식
	-<a>태그를 통해 전송하거나 method를 get으로 했을 때의 전송방식
	-전달되는 파라미터가 웹브라우저의 주소표시줄에 노출된다.
	-전송되는 용량에 한계가 있다.
	-보안이 필요하지 않는 데이터의 전송에 주로 사용된다.
2.post방식
	-method를 post로 지정했을 때의 전송방식
	-파라미터가 주소줄에 노출되지 않는다.
	-로그인, 회원가입과 같이 보안이 필요한 데이터의 전송에 주로 사용된다.
	-전송되는 용량에 제한이 없다.
	-파일 첨부시에는 반드시 post방식으로 전송해야 한다.
 -->
    <h2>1. 클라이언트와 서버의 환경정보 읽기</h2>
    <!--  
    <a>태그를 통해 페이지 이동시 파라미터를 전달하고 싶다면 파일명 뒤에 물음표를 붙이고 "파라미터명=값"의 형태로
    작성한다. 2개 이상의 파라미터는 &를 통해 구분하면 된다. 이 부분을 "쿼리스트링(Query string)" 이라고 한다.
    -->
    <a href="./RequestWebInfo.jsp?eng=Hello&han=안녕">  <!--GET 방식으로 요청-->
      GET 방식 전송
    </a>
    <br />
    <!-- <form>태그 하위의 <input>, <select>, <textarea>태그를 통해 값을 전송할 때는 반드시
    name 속성이 명시되어야 한다. name속성에 지정한 이름을 통해 서버로 파라미터를 전송할 수 있다. -->
    <form action="RequestWebInfo.jsp" method="post">  <!--POST 방식으로 요청-->
        영어 : <input type="text" name="eng" value="Bye" /><br />
        한글 : <input type="text" name="han" value="잘 가" /><br />
        <input type="submit" value="POST 방식 전송" />
    </form>

    <h2>2. 클라이언트의 요청 매개변수 읽기</h2>
    <form method="post" action="RequestParameter.jsp">  <!--다양한 <input> 태그 사용-->
        아이디 : <input type="text" name="id" value="" /><br />
        성별 :
        <input type="radio" name="sex" value="man" />남자
        <input type="radio" name="sex" value="woman" checked />여자
        <br />
        관심사항 :
        <input type="checkbox" name="favo" value="eco" />경제
        <input type="checkbox" name="favo" value="pol" checked />정치
        <input type="checkbox" name="favo" value="ent" />연예<br />
        자기소개 :
        <textarea name="intro" cols="30" rows="4"></textarea>
        <br />
        학력 :
        <select name="grade" multiple size="3">
        	<option value="초딩">초딩</option>
        	<option value="중딩">중딩</option>
        	<option value="고딩">고딩</option>
        </select>
        <br>
        <input type="submit" value="전송하기" />
    </form>

    <h2>3. HTTP 요청 헤더 정보 읽기</h2>
    <a href="RequestHeader.jsp">  <!--HTTP 요청 헤더 읽기-->
        요청 헤더 정보 읽기
    </a>    
</body>
</html>




















