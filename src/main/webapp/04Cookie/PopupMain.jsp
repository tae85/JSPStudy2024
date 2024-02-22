<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//팝업창 오픈여부 판단을 위한 변수
String popupMode = "on"; 

/*
해당 페이지가 실행되면 제일 먼저 쿠키가 있는지 확인하기 위해 request 내장객체를 통해 생성된 쿠키를 배열의 형태로 가져온다.
*/
Cookie[] cookies = request.getCookies();

//만약 생성된 쿠키가 있다면..
if (cookies != null) {
	//읽어온 개수만큼 for문으로 반복한다.
    for (Cookie c : cookies) {
    	//쿠키의 이름을 읽어온다.
        String cookieName = c.getName();
    	
    	//쿠키에 저장된 값을 읽어온다.
        String cookieValue = c.getValue();
    	
    	/*
    	생성된 쿠키 중에 아래와 같이 팝업창 제어와 관련된 것이 있는지 확인한다. 주건에 만족한다면 쿠키값을 변수에 
    	저장한다.
    	*/
        if (cookieName.equals("PopupClose")) {
        	/*
        	즉, PopupClose라는 쿠키가 생성되어 있다면 popupMode의 값은 변경될 것이다. 현재 초기값은 on인 
        	상태이다.
        	*/
            popupMode = cookieValue; 
        }
    }
} 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키를 이용한 팝업 관리</title>
<style>
div#popup{
    position: absolute; top:100px; left:100px; color:yellow;  
    width:300px; height:100px; background-color:gray;
}
div#popup>div{
    position: relative; background-color:#ffffff; top:0px;
    border:1px solid gray; padding:10px; color:black;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
$(function() {
	//팝업창의 '닫기'버튼을 누르면 동작한다.
    $('#closeBtn').click(function() {
    	/* 팝업창을 숨김처리한다. hide() 합수는 display 속성을 none으로 설정하여 엘리멘트를 화면 상에서 
    	제거하는 역할을 한다.*/
    	$('#popup').hide();
    	
    	/*
    	'하루 동안 열지 않음' 체크박스에 체크한 경우에만 value를 읽어와서 변수에 저장한다. 따라서 체크하지
    	않은 상태라면 undefined이 할당되고, 체크된 상태람ㄴ 1이 할당된다.
    	*/
    	var chkVal = $("input:checkbox[id=inactiveToday]:checked").val();
    	console.log("chkVal", chkVal);
    	
    	//'닫기' 버튼을 누르면 항상 비동기로 요청한다.
		$.ajax({
			//요청할 서버의 경로
			url : "./PopupCookie.jsp",
			
			//전송방식으로 get으로 설정
			type : 'get',
			
			/* 요청시 전송할 파라미터, 체크박스에 처크했다면 1, 아니며 null이 전송된다. */
			data : { inactiveToday : chkVal },
			
			/* 콜백데이터 타입으로 text형식으로 지정 */
			dataType : "text",
			
			/* 요청 성공시 호출된 콜백함수*/
			success : function(resData) {
				/* PopupCookie.jsp에서 콜백해준 값이 있는지 확인하기 위해 아래와 같이 검사하면
				있는 것으로 출력한다. JSP에서는 page 지시어가 있어야 하는데 이 때문에 상단에 항상
				공백이 남게된다. 이 때문에 정상적으로 동작하지 않는 문제가 발생하게 된다. */
				if(resData) {
					console.log('있다.');
				}
				else {
					console.log('없다.');
				}
				console.log("콜백데이터", resData);
				
				/* 만약 콜백데이터가 있다면 페이지를 새로고침 한다. */
				if(resData != '') location.reload();
			}
		});
	});
});
</script>

</head>
<body>
<h2>팝업 메인 페이지</h2>
<%
	//스크립트릿을 통해 아래 출력문장을 10번 반복한다.
    for (int i = 1; i <= 10; i++) {
    	/* 변수 popupMode의 초기값은 on이고, 만약 쿠키가 생성되었다면 off로 설정된다. */
        out.println("현재 팝업창은 " + popupMode + " 상태입니다.<br/>");
    }

	/* 문자열 변수 popupMode가 on이면 팝업을 띄우기 위한 태그가 브라우저에 출력된다. 만약 on이 아니라면 해당
	태그는 표시되지 않는다. 즉, 쿠키의 상태에 따라 페이지가 동적으로 변경되므로, 이를 "동적웹페이지"라고 한다. */
    if (popupMode.equals("on")) {
%>
    <div id="popup">
        <h2 align="center">공지사항 팝업입니다.</h2>
        <div align="right"><form name="popFrm">
            <input type="checkbox" id="inactiveToday" value="1" />
            하루 동안 열지 않음
            <input type="button" value="닫기" id="closeBtn" />
        </form></div>
    </div>
<%
    }
%>
</body>
</html>

























