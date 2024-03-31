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
	private static PreparedStatement boardDetailPstmt = null;
	private static PreparedStatement boardInsertPstmt = null;
	private static PreparedStatement boardDeletePstmt = null;
	private static PreparedStatement boardUpdatePstmt = null;
	private static PreparedStatement boardViewCountUpdatePstmt = null;
	static {
		try {
			Class.forName("org.mariadb.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/miniProj-db", "bituser", "1004");
			System.out.println("연결 성공");
			

			 boardListPstmt = conn.prepareStatement("SELECT B.*, M.member_name bwriter FROM TB_BOARD B inner join TB_MEMBER M on B.member_id = M.member_id");
			 boardDetailPstmt = conn.prepareStatement("SELECT B.*, M.member_name bwriter FROM TB_BOARD B inner join TB_MEMBER M on B.member_id = M.member_id where B.bno = ?");
			 boardDeletePstmt = conn.prepareStatement("DELETE FROM TB_BOARD WHERE bno = ?");
			 boardUpdatePstmt = conn.prepareStatement("UPDATE TB_BOARD  SET btitle = ?, bcontent  = ?,  bdate = NOW(),  bViewCount = 1 WHERE bno = ?");
			 boardInsertPstmt = conn.prepareStatement("INSERT INTO TB_BOARD (btitle, bcontent, member_id, bdate, bViewCount) VALUES (?, ?, ?, NOW(), ?)");
			 boardViewCountUpdatePstmt = conn.prepareStatement("UPDATE TB_BOARD SET bViewCount = bViewCount + 1 WHERE bno = ? ");
			 
			 
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} catch (SQLException e) {
			e.printStackTrace();

		}
	}
	
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
	            	BoardVO boards = new BoardVO(rs.getInt("bno")
	                        , rs.getString("btitle")
	                        , rs.getString("bcontent")
	                        , rs.getString("bwriter"));
	                
	                list.add(boards);
	            }
	            rs.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    } 
	  
	  public BoardVO read(BoardVO board) {
		  BoardVO boards = null;
	        try {
	        	boardViewCountUpdatePstmt.setInt(1,board.getBno());
	        	
	            boardViewCountUpdatePstmt.executeQuery();
	            
	        	boardDetailPstmt.setInt(1, board.getBno());

	            ResultSet rs = boardDetailPstmt.executeQuery();
	            if (rs.next()) {
	            	boards = new BoardVO(rs.getInt("bno")
	                        , rs.getString("btitle")
	                        , rs.getString("bcontent")
	                        , rs.getString("member_id")
	                        , rs.getString("bdate")
	                        , rs.getInt("bViewCount")
	                        , rs.getString("bwriter")
	                        );
	            }
	            rs.close();
	            
	            

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return boards;
	    }
	  
	  public int delete(BoardVO board) {
	        int updated = 0;

	        try {
	        	boardDeletePstmt.setInt(1, board.getBno());
	            updated = boardDeletePstmt.executeUpdate();
	            conn.commit();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return updated;
	    }
	  
	  public int update(BoardVO board) {
	        int updated = 0;
	        try {
	        	boardUpdatePstmt.setString(1, board.getBtitle());
	        	boardUpdatePstmt.setString(2, board.getBcontent());
	        	boardUpdatePstmt.setInt(3, board.getBno());
	        	
	            updated = boardUpdatePstmt.executeUpdate();
	            conn.commit();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return updated;
	    }
	  
	  public int insert(BoardVO board){
	        int updated = 0;
	        try{
	        	boardInsertPstmt.setString(1, board.getBtitle()); // 첫 번째 ? 에 btitle 값을 설정
	        	boardInsertPstmt.setString(2, board.getBcontent()); // 두 번째 ? 에 bcontent 값을 설정
	        	boardInsertPstmt.setString(3, board.getMember_id()); // 세 번째 ? 에 member_id 값을 설정

	        	boardInsertPstmt.setInt(4, 0); //

	            updated = boardInsertPstmt.executeUpdate();
	            conn.commit();
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        return updated;
	    }
	  
}
