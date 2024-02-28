<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
</head>
<script>
	/*
	폼값을 submit(전송)할 때 빈값에 대한 검증을 위한 JS함수로 필수사항인 제목과 첨부파일에 대해 입력값이 있는지 
	확인한다.
	*/
	function validateForm(form) {
		/*
		<form> 태그에서 submit 이벤트 발생시 전달하는 this를 통해 하위의 <input> 태그에 접근하게 된다. 여기서
		매개변수로 전달되는 this는 <form> 태그의 DOM이 된다.
		*/
		if(form.title.value == ""){
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if(form.ofile.value == ""){
			alert("첨부파일은 필수 입력입니다.");
			return false;
		}
	}
</script>
<body>
	<h3>파일 업로드</h3>
	<span style="color: red;">${errorMessage }</span>
	<!--  
	파일첨부를 위한 <form> 태그 구성시 아래 2가지는 필수사항
	1.method 속성은 post로 설정
	2.enctype 속성은 'multipart/form-data'로 설정해야 한다. 만약 get방식이 되면 파일이 전송되지 않고 
	파일명만 전송된다.
	-->
	<form name="fileForm" method="post" enctype="multipart/form-data"
		action="UploadProcess.do" onsubmit="return validateForm(this);">
		제목 : <input type="text" name="title" /><br>
		첨부파일 : <input type="file" name="ofile" /><br>
		<input type="submit" value="전송하기" />
	</form>
</body>
</html>