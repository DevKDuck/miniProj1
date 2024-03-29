package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;


public class BoardService {
	
	BoardDAO boardDAO = new BoardDAO();
	
	
	public BoardService() {
		super();
	}
	
	public List<BoardVO> list(BoardVO board) throws ServletException, IOException {
		return boardDAO.list(board);
	}
	
	public BoardVO view(BoardVO board) throws ServletException, IOException {
		return boardDAO.read(board);
	}
	public int delete(BoardVO board) throws ServletException, IOException {
		return boardDAO.delete(board);
	}
	public BoardVO updateForm(BoardVO board) throws ServletException, IOException {
		BoardVO result = boardDAO.read(board);

		return result;
	}
	public int update(BoardVO board) throws ServletException, IOException {
		return boardDAO.update(board);

	}
//	public int insert(BoardVO board) throws ServletException, IOException {
//		//memberDAO.insert(member);
//	
//		return boardDAO.insert(board);
//	}
//	
//	public BoardVO insertForm(BoardVO board) throws ServletException, IOException {
//		BoardVO result = boardDAO.read(board);
//		return result;
//	}
//	
	
	

}
