package board;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;



public class BoardController {
	BoardService boardService = new BoardService();

	public BoardController() {
		super();
	}

	public Object list(HttpServletRequest request, BoardVO board) throws ServletException, IOException {

		List<BoardVO> list = boardService.list(board);

		request.setAttribute("list", list);

		return "list";
	}

	public Object insertForm(HttpServletRequest request, BoardVO board) throws ServletException, IOException {
		System.out.println("등록화면");
		
		request.setAttribute("board", boardService.insertForm(board));
		

		return "insertForm";
	}
	

	public Object insert(HttpServletRequest request, BoardVO board) throws ServletException, IOException {
		System.out.println("등록");
		Map<String, Object> map = new HashMap<>();
		
		if (board.getMember_id() == null  || board.getMember_id().length() == 0) {
			map.put("status", -1);
			map.put("statusMessage", "사용자 아이디는 null 이거나 길이가 0인 문자열을 사용할 수 없습니다");
		} else {
			//1. 처리
			int updated = boardService.insert(board);
			
			if (updated == 1) { //성공
				map.put("status", 0);
			} else {
				map.put("status", -99);
				map.put("statusMessage", "회원 가입이 실패하였습니다");
			}
		}
		return map;
	}
//
	public Object view(HttpServletRequest request, BoardVO board) throws ServletException, IOException {
		System.out.println("상세보기");

		request.setAttribute("view", boardService.view(board));
		return "view";
	}

	public Object delete(HttpServletRequest request, BoardVO member) throws ServletException, IOException {
		int updated = boardService.delete(member);

		Map<String, Object> map = new HashMap<>();
		if (updated == 1) { // 성공
			map.put("status", 0);
		} else {
			map.put("status", -99);
			map.put("statusMessage", "회원 정보 삭제 실패하였습니다");
		}

		return map;
	}

	public Object updateForm(HttpServletRequest request, BoardVO board) throws ServletException, IOException {
		System.out.println("수정화면");

		request.setAttribute("board", boardService.updateForm(board));
		return "updateForm";
	}

	public Object update(HttpServletRequest request, BoardVO board) throws ServletException, IOException {
		System.out.println("수정");
		System.out.println("member->" + board);

		int updated = boardService.update(board);

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

