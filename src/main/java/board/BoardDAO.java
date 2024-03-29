package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import member.MemberVO;



public class BoardDAO {
	private static Connection conn = null;
	private static PreparedStatement boardListPstmt = null;
	private static PreparedStatement boardDetailPstmt = null;
	private static PreparedStatement boardInsertPstmt = null;
	private static PreparedStatement boardDeletePstmt = null;
	private static PreparedStatement boardUpdatePstmt = null;
	
	static {
		try {
			Class.forName("org.mariadb.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/miniProj-db", "bituser", "1004");
			System.out.println("연결 성공");
			

			 boardListPstmt = conn.prepareStatement("SELECT B.*, M.member_name bwriter FROM TB_BOARD B inner join TB_MEMBER M on B.member_id = M.member_id");
			 boardDetailPstmt = conn.prepareStatement("SELECT B.*, M.member_name bwriter FROM TB_BOARD B inner join TB_MEMBER M on B.member_id = M.member_id where B.bno = ?");
			 boardDeletePstmt = conn.prepareStatement("DELETE FROM TB_BOARD WHERE bno = ?");
			 boardUpdatePstmt = conn.prepareStatement("UPDATE TB_BOARD  SET btitle = ?, bcontent  = ?,  bdate = NOW(),  bViewCount = 1 WHERE bno = ?");
//			 boardInsertPstmt = conn.prepareStatement("insert into TB_BOARD (bno , btitle, bcontent , member_id , bdate , bViewCount) values (?, ?, ?, ? ,?, ?);");
			 
			 
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
	  
}
