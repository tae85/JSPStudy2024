package membership;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

/*
DAO(Data Access Object) : 데이터베이스에 접근하여 기본적인 CRUD를 하기 위한 객체이다. DB접속 및 select와
	같은 쿼리문을 실행한 후 결과를 반환받는 역할을 한다.
 */
public class MemberDAO extends JDBConnect {
	
	/*
	JDBC를 통해 오라클에 연결한다. 부모클래스의 매개변수 4개로 정의된 생성자를 호출한다.
	 */
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	
	//application 내장객체를 인수로 전달한 후 DB 연결
	public MemberDAO(ServletContext application) {
		super(application);
	}
	
	/*
	사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 select한 후 존재하는 회원정보인 경우 DTO 객체에
	레코드를 담아 반환한다.
	 */
	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = new MemberDTO();
		/* 로그인 폼에서 입력한 아이디, 패스워드를 통해 인파라미터를 설정할 수 있도록 쿼리문을 작성 */
		String query = "select * from member where id=? and pass=?";
		
		try {
			//쿼리문 실행과 인파라미터 설정을 위한 prepared 인스턴스 생성
			psmt = con.prepareStatement(query);
			
			//인파라미터를 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			
			//쿼리문을 실행한 후 결과는 ResultSet을 통해 반환
			rs = psmt.executeQuery();
			
			//반환된 ResultSet에 회원정보가 저장되어 있는지 확인
			if(rs.next()) {
				//정보가 있다면 DTO에 저장한다.
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
}


























