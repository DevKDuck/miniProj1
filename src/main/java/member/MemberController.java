package member;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;


public class MemberController {
	
	MemberService memberService = new MemberService();

	public MemberController() {
		super();
	}

	public Object list(HttpServletRequest request, MemberVO member) throws ServletException, IOException {

		List<MemberVO> list = memberService.list(member);

		request.setAttribute("list", list);

		return "list";
	}

	public Object insertForm(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		System.out.println("등록화면");
		
		request.setAttribute("member", memberService.insertForm(member));
		request.setAttribute("hobbyList", memberService.getHobbyList());

		return "insertForm";
	}
	
	
	public Object insert(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		System.out.println("등록");
		Map<String, Object> map = new HashMap<>();
		
		if (member.getMember_id() == null  || member.getMember_id().length() == 0) {
			map.put("status", -1);
			map.put("statusMessage", "사용자 아이디는 null 이거나 길이가 0인 문자열을 사용할 수 없습니다");
		} else {
			//1. 처리
			int updated = memberService.insert(member);
			
			if (updated == 1) { //성공
				map.put("status", 0);
			} else {
				map.put("status", -99);
				map.put("statusMessage", "회원 가입이 실패하였습니다");
			}
		}
		return map;
	}

	public Object view(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		System.out.println("상세보기");

		request.setAttribute("view", memberService.view(member));
		return "view";
	}

	public Object delete(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		int updated = memberService.delete(member);

		Map<String, Object> map = new HashMap<>();
		if (updated == 1) { // 성공
			map.put("status", 0);
		} else {
			map.put("status", -99);
			map.put("statusMessage", "회원 정보 삭제 실패하였습니다");
		}

		return map;
	}

	public Object updateForm(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		System.out.println("수정화면");

		request.setAttribute("member", memberService.updateForm(member));
		request.setAttribute("hobbyList", memberService.getHobbyList());

		return "updateForm";
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
