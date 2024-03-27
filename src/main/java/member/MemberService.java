package member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;




public class MemberService {
	
	MemberDAO memberDAO = new MemberDAO();
	
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
		return memberDAO.read(member);
	}
	
}

