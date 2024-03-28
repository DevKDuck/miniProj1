package member;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class MemberController {
	MemberService memberService = new MemberService();
	
	public MemberController() {
		super();
	}
	
	public Object list(HttpServletRequest request, MemberVO member)  throws ServletException, IOException {
	
		List<MemberVO> list = memberService.list(member);
		
		request.setAttribute("list", list);
		
		return "list";
	}

	public Object insertForm(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		System.out.println("등록화면");

		request.setAttribute("hobbyList", memberService.getHobbyList());

		return "insertForm";
	}
	
	public Object updateForm(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		System.out.println("수정화면");

		request.setAttribute("member", memberService.updateForm(member));
		request.setAttribute("hobbyList", memberService.getHobbyList());

		return "updateForm";
	}

	public Object view(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		System.out.println("상세보기");
		
		
		request.setAttribute("view", memberService.view(member));
		return "view";
	} 
	public Object delete(HttpServletRequest request, MemberVO member ) throws ServletException, IOException {
int updated = memberService.delete(member);
		
		Map<String, Object> map = new HashMap<>();
		if (updated == 1) { //성공
			map.put("status", 0);
		} else {
			map.put("status", -99);
			map.put("statusMessage", "회원 정보 삭제 실패하였습니다");
		}
		
		return map;
	}

	public Object update(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		System.out.println("수정");
		System.out.println("member->" + member);

		int updated = memberService.update(member);

		Map<String, Object> map = new HashMap<>();
		if (updated == 1) { // 성공
			map.put("status", 0);
		} else {
			map.put("status", -99);
			map.put("statusMessage", "회원 정보 수정 실패하였습니다");
		}

		return map;
	}
	
	
}
