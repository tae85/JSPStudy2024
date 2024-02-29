package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.BoardPage;

/*
게시판 목록을 위한 컨트롤러 클래스(서블릿). 매핑은 web.xml에서 설정.
 */
public class ListController extends HttpServlet{
	//목록 진입은 get 방식이므로 doGet() 메서드 오버라이딩
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		//커넥션풀을 통해 DB연결
		MVCBoardDAO dao = new MVCBoardDAO();
		
		//Map 컬렉션(파라미터 저장 및 그외정보 저장) 
		Map<String, Object> map = new HashMap<String, Object>();

		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");

		if(searchWord != null) {
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		int totalCount = dao.selectCount(map);

		/*
		서블릿 클래스에서는 내장객체를 사용하기 위해 별도의 메서드를 통해 얻어와야 한다. 아래에서는 application 
		내장객체를 얻어온다.
		 */
		ServletContext application = getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

		int totalPage = (int)Math.ceil((double)totalCount / pageSize);

		int pageNum = 1;
		String pageTemp = req.getParameter("pageNum");
		if(pageTemp != null && !pageTemp.equals("")){
			pageNum = Integer.parseInt(pageTemp);
		}
		int start = (pageNum -1) * pageSize + 1;
		int end = pageNum * pageSize;
		map.put("start", start);
		map.put("end", end);
		
		List<MVCBoardDTO> boardLists = dao.selectListPage(map);
		dao.close();
		
		/*
		모델1 방식에서는 JSP 상단에서 요청을 처리한 후 하단에서 출력하는 방식이므로 즉시 사용할 수 있다. 하지만
		모델2 방식은 Servlet에서 요청을 처리하고 출력을 위해 JSP로 데이터를 전달해야 하므로 아래와 같이 request
		영역에 데이터를 저장 후 JSP로 포워드해서 출력한다.
		 */
		String pagingImg = BoardPage.pagingStr
				(totalCount, pageSize, blockPage, pageNum, "../mvcboard/list.do");
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}
}






















