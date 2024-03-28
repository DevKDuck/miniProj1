package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class HobbyDAO {
	private static Connection conn = null;
	private static PreparedStatement listPstmt = null;
	
	
	static {
		try {
			Class.forName("org.mariadb.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mariadb://localhost:53306/miniProj-db", "bituser", "1004");
			System.out.println("연결 성공");
			
			listPstmt = conn.prepareStatement("SELECT * FROM TB_HOBBY order by hobby_name");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} catch (SQLException e) {
			e.printStackTrace();

		}
	}
	
//	  
	 public List<HobbyVO> list() {
	        List<HobbyVO> list = new ArrayList<>();
	        try {
	        	ResultSet rs = listPstmt.executeQuery();
	            while (rs.next()) {
	                list.add(HobbyVO.builder()
	            		     .hobby_id(rs.getString("hobby_id"))
	            		     .hobby_name(rs.getString("hobby_name"))
	            		     .build());
	            }
	            rs.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	} 
	
}
