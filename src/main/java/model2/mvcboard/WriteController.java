package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.JSFunction;

/*
글쓰기의 경우 <a> 태그의 링크를 통해 진입할 때는 get 방식, 작성처리를 위해서는 post 방식의 전송을 해야하므로
doGet, doPost 모두 필요하다.
*/
public class WriteController extends HttpServlet {
	//글쓰기 페이지 진입
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		req.getRequestDispatcher("/14MVCBoard/Write.jsp").forward(req, resp);
	}
	
	//글쓰기 처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		String saveDirectory = getServletContext().getRealPath("/Uploads");
		
		String originalFileName = ""; 
		try {
			//업로드가 정상적으로 완료되면 원본 파일명을 반환한다.
			originalFileName = FileUtil.uploadFile(req, saveDirectory);
		} 
		catch (Exception e) {
			/* 파일 업로드시 오류가 발생되면 경고창을 띄운 후 작성페이지로 이동한다. 예외 발생의 이유를 확인하기
			위해 printStackTrace() 메서드를 사용하는 것이 좋다. */
			e.printStackTrace();
			//업로드 오류시 경고창을 띄우고 쓰기페이지로 이동한다.
			JSFunction.alertLocation(resp, "파일 업로드 오류입니다.", "../mvcboard/write.do");
			return;
		}
		
		MVCBoardDTO dto = new MVCBoardDTO();
		dto.setName(req.getParameter("name"));
		dto.setTitle(req.getParameter("title"));
		dto.setContent(req.getParameter("content"));
		dto.setPass(req.getParameter("pass"));
		
		if(originalFileName != "") {
			String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
			
			//원본과 변경된 파일명을 DTO에 저장한다.
			dto.setOfile(originalFileName);
			dto.setSfile(savedFileName);
		}
		
		//DAO를 통해 DB에 게시 내용 저장
		MVCBoardDAO dao = new MVCBoardDAO();
		int result = dao.insertWrite(dto);
		dao.close();
		
		if(result == 1) {
			resp.sendRedirect("../mvcboard/list.do");
		}
		else {
			JSFunction.alertLocation(resp, "글쓰기에 실패했습니다.", "../mvcboard/write.do");
		}
	}
}


































