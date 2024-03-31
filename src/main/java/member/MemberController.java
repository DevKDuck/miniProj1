package member;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


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
	
	public Object existUserId(HttpServletRequest request, MemberVO memberVO) throws ServletException, IOException {
		//1. 처리
		System.out.println("existUserId userid->" + memberVO.getMember_id());
		
		
		Map<String, Object> map = new HashMap<>();
		

	    MemberVO existMember = memberService.view(memberVO);
	    if (existMember == null) { // 사용 가능한 아이디
	    	map.put("existMember", false);
	        
	    } else { // 사용 불가능 아이디
	        map.put("existMember", true);
	    }
	    return map;
	}
	
	public Object loginForm(HttpServletRequest request) {
		return "loginForm";
	}
	public String login(HttpServletRequest request, MemberVO memberVO, HttpServletResponse response) throws ServletException, IOException {
		MemberVO loginVO = memberService.view(memberVO);
				System.out.println();
				
		System.out.println("loginVO" + loginVO);
		if (memberVO.isEqualPassword(loginVO)) {
			//로그인 사용자의 정보를 세션에 기록한다
			HttpSession session = request.getSession();
			session.setAttribute("loginVO", loginVO);
			
			if ("bituser".equals(loginVO.getMember_id())) {
				System.out.println("bituser!!!!!!!");
				
				session.setAttribute("managerID", true);	
			}else {
				
				System.out.println("bituser아님!!!!");
				session.setAttribute("managerID", null);
			}
			
			session.setMaxInactiveInterval(30*60*1000);
			
			if (memberVO.getAutologin().equals("Y")) {
				//1. UUID를 생성하여 사용자 테이블의 uuid을 변경한다
				String uuid = UUID.randomUUID().toString();
				memberVO.setMember_uuid(uuid);
				
				memberService.updateUUID(memberVO);
				
				
				//2. uuid값을 쿠키에 기록한다
				Cookie uuidCookie = new Cookie("uuidCookie", uuid);
				uuidCookie.setMaxAge(24 * 60 * 60); //24시간
				uuidCookie.setPath("/");
				
				response.addCookie(uuidCookie);
				
			}
			
			
		} else {
			//map.put("statusMessage", "아이디 또는 비밀번호가 잘못되었습니다");
			return "redirect:member.do?action=loginForm&err=invalidUserId";
		}


		return "redirect:main.jsp";

		
	}

	public Object logout(HttpServletRequest request) {
//		Map<String, Object> map = new HashMap<>();
		
		//로그인 사용자의 정보를 세션에 제거한다
		HttpSession session = request.getSession();
		//세션에서 로그인 정보를 얻는다
		MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
		//로그아웃시 uuid값을 제거한다 
		loginVO.setMember_uuid("");
		memberService.updateUUID(loginVO);
		
		
		System.out.println("logout session id = " + session.getId());
		session.removeAttribute("loginVO"); //특정 이름을 제거한다
		
		session.invalidate(); //세션에 저장된 모든 자료를 삭제한다 
		
		return "redirect:main.jsp";
	}
	
	public Object mypage(HttpServletRequest request, MemberVO member) throws ServletException, IOException {
		System.out.println("상세보기");
		
		
		HttpSession session = request.getSession();
		MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
		if (loginVO == null) {
			return "redirect:member.do?action=loginForm";
		}

		//2. jsp출력할 값 설정
		request.setAttribute("loginVO", loginVO);
		return "mypage";
	}
}
