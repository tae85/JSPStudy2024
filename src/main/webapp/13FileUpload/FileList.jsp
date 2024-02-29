<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
</head>
<style>
img{max-width:150px;}
</style>
<body>
	<h2>DB에 등록된 파일 목록 보기</h2>
	<a href="FileUploadMain.jsp">파일등록1</a>
	<a href="MultiUploadMain.jsp">파일등록2</a>
	<%
	//업로드 디렉토리의 물리적경로 알아보기
	String saveDirectory = application.getRealPath("/Uploads");
	System.out.println("물리적경로 : " + saveDirectory);
	
	//물리적 경로를 통해 File 객체 생성
	File file = new File(saveDirectory);
	
	//해당 디렉토리의 파일목록을 배열형태로 얻어온다.
	File[] fileList = file.listFiles();
	%>
	<table border="1">
		<tr>
			<th>No</th>
			<th>썸네일</th>
			<th>파일명</th>
			<th>크기</th>
			<th></th>
		</tr>
	<%
	int fileCnt = 1;
	//디렉토리에 있는 파일의 개수만큼 반복하여 출력한다.
	for(File f : fileList) {
	%>
		<tr>
			<td><%= fileCnt %></td>
			<td><img src="../Uploads/<%= f.getName() %>" /></td>
			<td><%= f.getName() %></td>	<!-- 파일명 -->
			<td><%= (int)Math.ceil(f.length()/1024.0) %>Kb</td>	<!-- 파일크기 -->
			<td><a href="Download.jsp?oName=myImage.jpg&sName=<%=f.getName()%>">[다운로드]</a></td>
		</tr>		
	<%
		fileCnt++;
	}
	%>
	</table>
</body>
</html>






















