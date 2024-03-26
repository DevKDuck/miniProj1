package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardController {
	BoardService boardService = new BoardService();
	
	public BoardController() {
		super();
	}
	
	public String list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardVO boardVO =  new BoardVO();
		List<BoardVO> list = boardService.list(boardVO);
		System.out.println(list.get(0));
		request.setAttribute("list", list);
		
		return "list";
	}

}
