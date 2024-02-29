<%@page import="utils.JSFunction"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
아래 3줄의 코드는 상황에 따라 변겨해야 한다. 파일이 저장될 디렉토리의 물리적 경로와 저장된 파일명, 원본 파일명
*/
String saveDirectory = application.getRealPath("/Uploads");
String saveFilename = request.getParameter("sName");
String originalFilename = request.getParameter("oName");

try {
    // 파일을 찾아 입력 스트림 생성
    File file = new File(saveDirectory, saveFilename);  
    InputStream inStream = new FileInputStream(file);
    
    // 한글 파일명 깨짐 방지
    String client = request.getHeader("User-Agent");
    if (client.indexOf("WOW64") == -1) {
    	//인터넷 익스플로러가 아닌 경우 UTF-8 파일명 인코딩
        originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
    }
    else {
    	//익스플로러인 경우 인코딩 방식
        originalFilename = new String(originalFilename.getBytes("KSC5601"), "ISO-8859-1");
    }
   
    // 파일 다운로드용 응답 헤더 설정 
    response.reset();
    
 	/* 웹브라우저가 인식하지 못하는 컨텐츠타입을 응답헤더에 설정하여 강제적으로 다운로드창을 띄운다. 이미지나 PDF문서처럼
 	웹브라우저가 인식할 수 있는 컨텐츠 타입인 경우 다운로드되지 않고 즉시 오픈되기 때문에 이와 같은 처리가 필요하다. */
    response.setContentType("application/octet-stream");
 	
 	/* 응답헤더 설정을 통해 저장된 파일명(날짜형식)을 원본 파일명으로 변경한 후 다운로드 시킨다. */
    response.setHeader("Content-Disposition", 
                       "attachment; filename=\"" + originalFilename + "\"");
    response.setHeader("Content-Length", "" + file.length() );
    
    // 출력 스트림 초기화
    out.clear();  
    
    // response 내장 객체로부터 새로운 출력 스트림 생성
    OutputStream outStream = response.getOutputStream();  

    // 출력 스트림에 파일 내용 출력
    byte b[] = new byte[(int)file.length()];
    int readBuffer = 0;    
    while ( (readBuffer = inStream.read(b)) > 0 ) {
        outStream.write(b, 0, readBuffer);
    }

    // 입/출력 스트림 닫음
    inStream.close(); 
    outStream.close();
}
catch (FileNotFoundException e) {
    JSFunction.alertBack("파일을 찾을 수 없습니다.", out);
}
catch (Exception e) {
    JSFunction.alertBack("예외가 발생하였습니다.", out);
}
%>




















