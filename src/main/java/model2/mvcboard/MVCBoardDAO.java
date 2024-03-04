package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

//MVC 게시판은 DBCP(커넥션풀)를 통해 DB에 연결한다.
public class MVCBoardDAO extends DBConnPool	{
	//기본생성자 호출로 커넥션풀을 사용한다. 
	public MVCBoardDAO() {
		super();
	}
	
	//게시물의 개수 카운트
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "select count(*) from mvcboard ";
		if(map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " "
					+ " like '%" + map.get("searchWord") + "%'";
		}
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		} 
		catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	//목록에 출력할 실제 게시물을 인출(페이징 기능 추가) 
	public List<MVCBoardDTO> selectListPage(Map<String, Object> map) {
		/*
		모델1에서 사용했던 테이블 board에서 mvcboard로 변경되었으므로 DTO 객체와 컬럼명에 대한 수정을 해야 한다.
		 */
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		
		String query = 	" select * from "
					+	"	(select tb.*, rownum rNum from "
					+ 	"		(select * from mvcboard ";
		if(map.get("searchWord") != null) {
			query += " where " + map.get("searchField")
					+ " like '%" + map.get("searchWord") + "%' ";
		}
		query += " 		order by idx desc "
				+ "   ) tb"
				+ " ) "
				+ " where rNum between ? and ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				
				board.add(dto);
			}
		} 
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}
	
	//글쓰기 처리
	public int insertWrite(MVCBoardDTO dto) {
		int result = 0;
		
		try {
			/* 쿼리문의 일련번호는 모델1 게시판에서 생성한 시퀀스를 그대로 사용한다. 나머지 값들은 
			컨트롤러(서블릿)에서 받은 후 모델(DAO)로 전달한다. */
			String query = "insert into mvcboard "
					+ " (idx, name, title, content, ofile, sfile, pass) "
					+ " values (seq_board_num.nextval, ?, ?, ?, ?, ?, ?)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	//내용 보기
	public MVCBoardDTO selectView(String idx) {
		MVCBoardDTO dto = new MVCBoardDTO();
		
		//일련번호와 일치하는 게시물 1개 인출
		String query = "select * from mvcboard where idx = ?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
			}
		} 
		catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	//조회수 증가 
	public void updateVisitCount(String idx) {
		String query = "update mvcboard set visitcount = visitcount + 1 where idx = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
		} 
		catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	//파일 다운로드 수 증가
	public void downCountPlus(String idx) {
		String sql = "update mvcboard set downcount = downcount + 1 where idx = ?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		} 
		catch (Exception e) {}
	}
	
	//패스워드 검증
	public boolean confirmPassword(String pass, String idx) {
		boolean isCorr = true;
		try {
			//일련번호와 패스워드의 조건에 만족하는 레코드가 있는지 확인 
			String sql = "select count(*) from mvcboard where pass=? and idx=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);
			psmt.setString(2, idx);
			rs = psmt.executeQuery();
			
			/* count()함수는 반드시 결과값이 있으므로 if문 없이 next()를 호출한다. 조건에 만족하지 않으면
			0, 만족하면 1을 반환한다. */
			rs.next();
			if(rs.getInt(1) == 0) {
				//조건에 만족하는 레코드가 없는 경우
				isCorr = false;
			}
		} 
		catch (Exception e) {
			//쿼리문 실행 도중 예외가 발생되면 catch절로 넘어오므로 이 경우에도 false로 설정해야 한다.
			isCorr = false;
			e.printStackTrace();
		}
		return isCorr;
	}

	//게시물 삭제
	public int deletePost(String idx) {
		int result = 0;
		try {
			//일련번호에 해당하는 게시물 1개 삭제
			String query = "delete from mvcboard where idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
		} 
		catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	//게시물 수정
	public int updatePost(MVCBoardDTO dto) {
		int result = 0;
		try {
			/*
			비회원제 게시판은 패스워드를 통해 검증을 진행한 후 수정이나 삭제를 해야한다. 따라서 아래와 같이 where절에는
			idx와 pass까지 조건을 추가하는 것이 좋다.
			 */
			String query = "update mvcboard"
					+ " set title = ?, name = ?, content =?, ofile = ?, sfile = ? "
					+ " where idx = ? and pass = ?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getIdx());
			psmt.setString(7, dto.getPass());
			
			result = psmt.executeUpdate();
		} 
		catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
}









