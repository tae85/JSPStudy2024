package model1.board;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

//JDBC를 이용한 DB연결을 위해 클래스 상속
public class BoardDAO extends JDBConnect{
	
	//부모클래스의 생성자 호출을 통해 DB에 연결한다.
	public BoardDAO(ServletContext application) {
		/* 부모의 생성자에서 web.xml에 접근하기 위해 application 내장객체를 전달한다. */
		super(application);
	}
	
	//게시물의 개수를 카운트하여 int형으로 반환한다.
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		
		//게시물의 수를 얻어오기 위한 쿼리문 작성
		String query = "select count(*) from board";
		
		//검색어가 있는 경우 where절을 추가한다.
		if(map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " "
					+ " like '%" + map.get("searchWord") + "%'";
		}
		
		try {
			//정적쿼리문 실행을 위해 Statement 인스턴스 생성
			stmt = con.createStatement();
			
			//쿼리 실행 및 결과 반환
			rs = stmt.executeQuery(query);
			
			//ResultSet 객체에서 결과값을 읽음
			rs.next();
			
			//첫번째 컬럼의 값을 얻어온 후 변수에 저장
			totalCount = rs.getInt(1);
		} 
		catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	/*
	작성된 게시물을 인출하여 반환한다. 특히 반환값은 여러개의 레코드를 반환할 수 있고, 순서를 보장해야 하므로
	List 컬렉션을 사용한다. 
	*/
	public List<BoardDTO> selectList(Map<String, Object> map) {
		
		/*
		List 계열의 컬렉션을 생성. 이때 타입 매개변수는 board테이블을 대상으로 하므로 BoardDTO로 설정한다.
		 */
		List<BoardDTO> bbs = new Vector<BoardDTO>();
		
		/*
		레코드 인출을 위한 select 쿼리문 작성. 최근 게시물이 상단에 출력되야 하므로 일련번호의 내림차순으로 정렬한다.
		 */
		String query = "select * from board";
		if(map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " "
					+ " like '%" + map.get("searchWord") + "%'";
		}
		query += " order by num desc ";
		
		try {
			//쿼리문 실행을 인한 인스턴스 생성
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			//반환된 ResultSet의 개수만큼 반복한다.
			while(rs.next()) {
				//하나의 레코드를 저장할 수 있는 DTO 인스턴스 생성
				BoardDTO dto = new BoardDTO();
				
				//setter를 이용해서 각 컬럼의 값을 멤버변수에 저장
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				//List에 DTO를 추가한다.
				bbs.add(dto);
			}
		} 
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	//게시물 입력. 폼값이 저장된 DTO를 인수로 받는다.
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		try {
			/*
			인파라미터가 있는 동적쿼리문을 작성한 후 유저가 입력한 값으로 설정한다. 일련번호는 시퀀스로 자동부여하고,
			조회수는 0으로 입력한다.
			 */
			String query = "insert into board (num, title, content, id, visitcount) "
					+ " values (seq_board_num.nextval, ?, ?, ?, 0)";
			
			/*
			동적쿼리문이므로 prepared 인스턴스를 생성한 후 순서대로 인파라미터를 설정한다.
			 */
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			
			//쿼리문을 실행하여 입력처리한 후 결과값은 정수로 반환받는다.
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public BoardDTO selectView(String num) {
		BoardDTO dto = new BoardDTO();
		
		String query = "select B.*, M.name from member M inner join board B "
					+ " on M.id = B.id where num = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				dto.setName(rs.getString("name"));
			}
					
		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public void updateVisitCount(String num) {
		String query = "update board set visitcount = visitcount + 1 where num = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			psmt.executeQuery();
			
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	public int updateEdit(BoardDTO dto) {
		int result = 0;
		try {
			String query = "update board set title = ?, content =? where num = ?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			
			result = psmt.executeUpdate();
		} 
		catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int deletePost(BoardDTO dto) {
		int result = 0;
		
		try {
			String query = "delete from board where num=?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());
			
			result = psmt.executeUpdate();
		} 
		catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//게시물의 목록 출력시 페이징 기능 추가
	public List<BoardDTO> selectListPage(Map<String, Object> map) {
		List<BoardDTO> bbs = new Vector<BoardDTO>();
		
		/*
		검색조건에 일치하는 게시물을 얻어온 후 각 페이지에 출력할 구간까지 설정한 서브쿼리문 작성
		 */
		String query = 	" select * from "
					+	"	(select tb.*, rownum rNum from "
					+ 	"		(select * from board ";
		//검색어가 있는 경우에만 where절을 추가
		if(map.get("searchWord") != null) {
			query += " where " + map.get("searchField")
					+ " like '%" + map.get("searchWord") + "%' ";
		}
		/*
		게시물의 구간을 결정하기 위해 between 혹은 비교연산자를 사용할 수 있다. 아래의 where절은 'rNum>?'과
		같이 변경할 수 있다.
		 */
		query += " 		order by num desc "
				+ "   ) tb"
				+ " ) "
				+ " where rNum between ? and ?";
		
		try {
			//인파라미터가 있는 쿼리문이므로 prepared 인스턴스 생성
			psmt = con.prepareStatement(query);
			
			//인파라미터 설정(출력할 페이지의 구간)
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				//일련번호 ~ 조회수까지 DTO에 저장
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				//하나의 레코드를 저장한 DTO를 List에 추가
				bbs.add(dto);
			}
		} 
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
}


































