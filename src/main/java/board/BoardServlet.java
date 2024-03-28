package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Servlet implementation class memberController
 */
@WebServlet("/board.do")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	BoardController boardController = new BoardController();

	public BoardServlet() {
		super();

		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		doService(request, response);
		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doService(request, response);

		

	}

	private void doService(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String contentType = request.getContentType();
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String action = request.getParameter("action");
		String jspPage = switch(action) {
		case "list" -> boardController.list(request,response);
//		case "view" -> view(request, response);
//		case "delete" -> delete(request, response);
//		case "updateForm" -> updateForm(request, response);
//		case "update" -> update(request, response);
		case "insertForm" -> boardController.list(request,response);
//		case "insert" -> insert(request, response);
		default -> "";
		};
		request.getRequestDispatcher("/WEB-INF/board/" + jspPage + ".jsp").forward(request, response);
	}

}
