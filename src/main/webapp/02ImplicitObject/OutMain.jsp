<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - out</title>
</head>
<body>
	<%
	/*
	out 내장객체를 통해 print() 메서드를 호출하면 인수로 전달된 내용이 웹브라우저에 즉시 출력되지 않고 버퍼에
	먼저 저장된다.
	*/
	out.print("출력되지 않는 텍스트");
	
	/*
	버퍼에 저장된 모든 내용을 삭제한다. 그러면 해당 내용은 브라우저에 출력되지 않는다. '소스보기'로 확인해보면
	상단의 <html>태그가 사라진걸 볼 수 있다.
	*/
	out.clearBuffer();
	
	//JSP의 기본 버퍼 사이즈는 8Kb로 설정된다.
	out.print("<h2>out 내장 객체</h2>");
	out.print("출력 버퍼의 크기 : " + out.getBufferSize() + "<br>");
	out.print("남은 버퍼의 크기 : " + out.getRemaining() + "<br>");
	
	//버퍼에 저장된 내용을 목적지(웹브라우저)로 전송(플러쉬)한다.
	out.flush();	
	
	//버퍼의 모든 내용이 출력되었으므로 크기는 원상복구 된다.
	out.print("flush 후 버퍼의 크기 : " + out.getRemaining() + "<br>");
	
	//타입에 상관없이 다양한 타입의 값을 출력할 수 있도록 오버로딩 되어있다.
	out.println(1);
	out.println(false);
	out.print('가');
	/* print()와 println()의 차이는 출력값 뒤에 \n 하나를 추가하는 정도이다. 웹브라우저에서는 줄바꿈을 위해
	<br>태그가 필요하므로 두 메서드의 차이는 스페이스 한칸이 들어가는 정도이다. */
	%>
</body>
</html>


























