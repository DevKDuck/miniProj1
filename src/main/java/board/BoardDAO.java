package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class BoardDAO {
	private static Connection conn = null;
	private static PreparedStatement boardListPstmt = null;
//	private static PreparedStatement memberDetailPstmt = null;
	
	static {
		try {
			Class.forName("org.mariadb.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/miniProj-db", "bituser", "1004");
			System.out.println("연결 성공");
			
			boardListPstmt = conn.prepareStatement("SELECT * FROM TB_BOARD");
//			memberDetailPstmt = conn.prepareStatement("");
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} catch (SQLException e) {
			e.printStackTrace();

		}
	}
	
//	  public List<MemberVO> list(MemberVO member) {
	  public List<BoardVO> list(BoardVO board) {
	        List<BoardVO> list = new ArrayList<>();
	        try {
	        	ResultSet rs = null;
//	        	if (user != null && !user.isEmptySearchKey()) {
//	        		//검색 키워드 설정 
//	        		userListPstmt2.setString(1, user.getSearchKey());
//	        		rs = userListPstmt2.executeQuery();
//	        	} else {
	                rs = boardListPstmt.executeQuery();
//	        	}
	            while (rs.next()) {
	            	BoardVO members = new BoardVO(rs.getInt("bno")
	                        , rs.getString("btitle")
	                        , rs.getString("bcontent")
	                        , rs.getString("bwriter")
	                        , rs.getString("bdate")
	                        , rs.getInt("bViewCount"));
	                
	                list.add(members);
	            }
	            rs.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    } 
}
