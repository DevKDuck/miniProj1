package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class MemberDAO {
	private static Connection conn = null;
	private static PreparedStatement memberListPstmt = null;
	private static PreparedStatement memberInsertPstmt = null;
	private static PreparedStatement memberDetailPstmt = null;
	private static PreparedStatement memberDeletePstmt = null;
	private static PreparedStatement memberHobbiesPstmt = null;

	private static PreparedStatement memberUpdatePstmt = null;
	private static PreparedStatement memberHobbiesUpdatePstmt = null;
	private static PreparedStatement memberHobbiesInsertPstmt = null;

	private static PreparedStatement memberFormUUIDPstmt = null;
    private static PreparedStatement memberUpdateUUIDPstmt = null; 
	
	private static PreparedStatement member_idValidationPstmt = null;
	private static PreparedStatement member_pwdValidationPstmt = null;
	static {
		try {
			Class.forName("org.mariadb.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/miniProj-db", "bituser", "1004");
			System.out.println("연결 성공");
			
			memberListPstmt = conn.prepareStatement("SELECT * FROM TB_MEMBER");
			memberInsertPstmt = conn.prepareStatement("insert into TB_MEMBER (member_id, member_pwd, member_name, member_address, member_phone_number, member_gender) values (?, ?, ?, ?,?,?)");
			
			member_idValidationPstmt = conn.prepareStatement("select member_id from TB_MEMBER where member_id=?");
			member_pwdValidationPstmt  = conn.prepareStatement("select member_pwd from TB_MEMBER whrere member_pwd=? ");
			
			memberDetailPstmt = conn.prepareStatement("SELECT M.*, GROUP_CONCAT(H.hobby_name SEPARATOR ', ') AS hobby_name FROM TB_MEMBER M INNER JOIN TB_MEMBERHOBBY MH ON M.member_id = MH.member_id INNER JOIN TB_HOBBY H ON MH.hobby_id = H.hobby_id WHERE M.member_id = ? GROUP BY M.member_id, M.member_name");
			
			memberDeletePstmt = conn.prepareStatement("delete from TB_MEMBER where member_id=?");
			memberHobbiesPstmt = conn.prepareStatement("SELECT H.hobby_id, H.hobby_name FROM TB_MEMBERHOBBY MH INNER JOIN TB_MEMBER M ON M.member_id = MH.member_id INNER JOIN TB_HOBBY H ON MH.hobby_id = H.hobby_id WHERE M.member_id = ?");

			memberUpdatePstmt = conn.prepareStatement("UPDATE TB_MEMBER SET member_pwd = ?, member_name = ?, member_address = ?, member_phone_number = ?, member_gender = ? WHERE member_id = ?");
			memberHobbiesUpdatePstmt = conn.prepareStatement("DELETE FROM TB_MemberHobby WHERE member_id = ?");
			memberHobbiesInsertPstmt  = conn.prepareStatement("INSERT INTO TB_MemberHobby (member_id, hobby_id) VALUES (?, ?)");
			
			memberFormUUIDPstmt = conn.prepareStatement("select * from TB_MEMBER where member_uuid=?");
			memberUpdateUUIDPstmt = conn.prepareStatement("update TB_MEMBER set member_uuid=? where member_id=?");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} catch (SQLException e) {
			e.printStackTrace();

		}
	}
	
//	  
	  public List<MemberVO> list(MemberVO member) {
	        List<MemberVO> list = new ArrayList<>();
	        try {
	        	ResultSet rs = null;
//	        	if (user != null && !user.isEmptySearchKey()) {
//	        		//검색 키워드 설정 
//	        		userListPstmt2.setString(1, user.getSearchKey());
//	        		rs = userListPstmt2.executeQuery();
//	        	} else {
	                rs = memberListPstmt.executeQuery();
//	        	}
	            while (rs.next()) {
	            	MemberVO members = new MemberVO(rs.getString("member_id")
	            		      , rs.getString("member_pwd")
	            		      , rs.getString("member_name")
	            		      , rs.getString("member_address")
	            		      , rs.getString("member_phone_number")
	            		      , rs.getString("member_gender")
	            		      );
	                list.add(members);
	            }
	            rs.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    } 
	  
	  public MemberVO read(MemberVO member) {

		  MemberVO members = null;
	        try {
	        	memberDetailPstmt.setString(1, member.getMember_id());

	            ResultSet rs = memberDetailPstmt.executeQuery();
	            if (rs.next()) {
	            	members = new MemberVO(rs.getString("member_id")
	                        , rs.getString("member_pwd")
	                        , rs.getString("member_name")
	                        , rs.getString("member_address")
	                        , rs.getString("member_phone_number")
	                        , rs.getString("member_gender")
	                        , rs.getString("hobby_name")
	            			);
	            	
	            }
	            rs.close();

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return members;
	    }
	  
	  public int delete(MemberVO member) {
	        int updated = 0;

	        try {
	        	memberDeletePstmt.setString(1, member.getMember_id());
	            updated = memberDeletePstmt.executeUpdate();
	            conn.commit();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return updated;
	    }
	  
	  
	  public int insert(MemberVO member){
	        int updated = 0;
	        try{
	        	memberInsertPstmt.setString(1, member.getMember_id());
	        	memberInsertPstmt.setString(2, member.getMember_pwd());
	        	memberInsertPstmt.setString(3, member.getMember_name());
	        	memberInsertPstmt.setString(4, member.getMember_address());
	        	memberInsertPstmt.setString(5, member.getMember_phonenumber());
	        	memberInsertPstmt.setString(6, member.getMember_gender());
	            updated = memberInsertPstmt.executeUpdate();
	            insertMemberHobby(member);
	            conn.commit();
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        return updated;
	    }

	  
	  public int update(MemberVO member) {
	        int updated = 0;
	        try {
	        	memberUpdatePstmt.setString(1, member.getMember_pwd());
	        	memberUpdatePstmt.setString(2, member.getMember_name());
	        	memberUpdatePstmt.setString(3, member.getMember_address());
	        	memberUpdatePstmt.setString(4, member.getMember_phonenumber());
	        	memberUpdatePstmt.setString(5, member.getMember_gender());
	        	memberUpdatePstmt.setString(6, member.getMember_id());
	            updated = memberUpdatePstmt.executeUpdate();
	            conn.commit();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return updated;
	    }
	  
	  
	  public void updateMemberHobby(MemberVO member) {
		  try {
			  memberHobbiesUpdatePstmt.setString(1,member.getMember_id());
			  memberHobbiesUpdatePstmt.executeUpdate();
			  conn.commit();
		  } catch (Exception e) {
	            e.printStackTrace();
          }
	  }
	  
	  public void insertMemberHobby(MemberVO member) {
		  try {
			  memberHobbiesInsertPstmt.setString(1,member.getMember_id());
			  for (String hobby_id: member.getHobbies()) {
				  memberHobbiesInsertPstmt.setString(2,hobby_id);
				  memberHobbiesInsertPstmt.addBatch();
			  }
			  memberHobbiesInsertPstmt.executeBatch();
			  conn.commit();
		  } catch (Exception e) {
	            e.printStackTrace();
          }	  
		  
	  }
	  
	  public List<HobbyVO> getMemberHobbies(MemberVO member) {
	        List<HobbyVO> list = new ArrayList<>();
	        try {
	        	memberHobbiesPstmt.setString(1, member.getMember_id());
	        	ResultSet rs = memberHobbiesPstmt.executeQuery();
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
	  
	  public boolean validationId(String member_id){
	        boolean result = false;
	        try {
	        	member_idValidationPstmt.setString(1, member_id);
	            ResultSet rs = member_idValidationPstmt.executeQuery();
	            if (rs.next()) {
	                result = true;
	            }
	            rs.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	    }
	        return result;
	    }

	    public boolean  validationPassword(String member_pwd){
	        boolean result = false;
	        try {
	        	member_pwdValidationPstmt.setString(1, member_pwd);
	            ResultSet rs = member_pwdValidationPstmt.executeQuery();
	            if (rs.next()) {
	                result = true;
	            }
	            rs.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return result;
	    }
	    
	    public int updateUUID(MemberVO members) {
	        int updated = 0;
	        try {
	        	memberUpdateUUIDPstmt.setString(1, members.getMember_uuid());
	        	memberUpdateUUIDPstmt.setString(2, members.getMember_id());
	            updated = memberUpdateUUIDPstmt.executeUpdate();
	            conn.commit();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return updated;

	    }   
	    
	    public MemberVO getUserVOFromUUID(MemberVO member) {

	    	MemberVO members = null;
	        try {
	        	memberFormUUIDPstmt.setString(1, member.getMember_uuid());

	            ResultSet rs = memberFormUUIDPstmt.executeQuery();
	            if (rs.next()) {
	                members = MemberVO.builder()
	                		.member_id(rs.getString("member_id"))
	                		.member_pwd(rs.getString("member_pwd"))
	                		.member_name(rs.getString("member_name"))
	                		.member_address(rs.getString("member_address"))
	                		.member_phonenumber(rs.getString("member_phonenumber"))
	                		.member_uuid(rs.getString("member_uuid"))
	                		.build();
	            }
	            rs.close();

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return members;
	    }
	   
}
