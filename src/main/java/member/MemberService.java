package member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;




public class MemberService {
	
	MemberDAO memberDAO = new MemberDAO();
	HobbyDAO hobbyDAO = new HobbyDAO();
	
	public MemberService() {
		super();
	}
	
	public List<MemberVO> list(MemberVO member) throws ServletException, IOException {
		return memberDAO.list(member);
	}
	public int insert(MemberVO member) throws ServletException, IOException {
		return memberDAO.insert(member);
	}
	public MemberVO view(MemberVO member) throws ServletException, IOException {
		return memberDAO.read(member);
	}
	public int delete(MemberVO member) throws ServletException, IOException {
		return memberDAO.delete(member);
	}
	public MemberVO updateForm(MemberVO member) throws ServletException, IOException {
		MemberVO result = memberDAO.read(member);
		if (result != null) {
			result.setMember_hobbies(memberDAO.getMemberHobbies(member));
		}
		return result;
	}
	public int update(MemberVO member) throws ServletException, IOException {
		memberDAO.updateMemberHobby(member);
		return memberDAO.update(member);

	}
	
	public List<HobbyVO> getHobbyList() throws ServletException, IOException {
		return hobbyDAO.list();
	}
	
}

