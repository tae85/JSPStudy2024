<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
</head>
<body>
	<h2>DB에 등록된 파일 목록 보기</h2>
	<a href="FileUploadMain.jsp">파일등록1</a>
	<a href="MultiUploadMain.jsp">파일등록2</a>
	<%
	String saveDirectory = application.getRealPath("/Uploads");
	File file = new File(saveDirectory);
	File[] fileList = file.listFiles();
	%>
	<table border="1">
		<tr>
			<th>No</th>
			<th>파일명</th>
			<th>크기</th>
			<th></th>
		</tr>
	<%
	int fileCnt = 1;
	for(File f : fileList) {
	%>
		<tr>
			<td><%= fileCnt %></td>
			<td><%= f.getName() %></td>
			<td><%= (int)Math.ceil(f.length()/1024.0) %>Kb</td>
			<td><a href="Download.jsp?oName=myImage.jpg&sName=<%=f.getName()%>">[다운로드]</a></td>
		</tr>		
	<%
		fileCnt++;
	}
	%>
	</table>
</body>
</html>