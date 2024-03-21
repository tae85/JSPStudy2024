import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JdbcConnect {
	public static void main(String[] args) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			Connection con = DriverManager.getConnection(
					"jdbc:oracle:thin:@127.0.0.1:1521:xe",
					"musthave", "1234");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from tb");
			while (rs.next()) {
				System.out.println("row = " + rs.getString("idx") + 
									" : " + rs.getString("name"));
			}
			rs.close();
			stmt.close();
			con.close();
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
