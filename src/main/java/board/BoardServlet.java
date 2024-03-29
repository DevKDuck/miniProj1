package board;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
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

		BoardVO boardVO = null;

		if (contentType == null || contentType.startsWith("application/x-www-form-urlencoded")) {
			boardVO = objectMapper.convertValue(convertMap(request.getParameterMap()), BoardVO.class);
		} else if (contentType.startsWith("application/json")) {
			boardVO = objectMapper.readValue(request.getInputStream(), BoardVO.class);
			System.out.println("boardVO = " + boardVO);
		}
		
		String action = boardVO.getAction();
		Object result = switch(action) {
		case "list" -> boardController.list(request,boardVO);
		case "view" -> boardController.view(request, boardVO);
		case "delete" -> boardController.delete(request, boardVO);
		case "updateForm" -> boardController.updateForm(request, boardVO);
		case "update" -> boardController.update(request, boardVO);
//		case "insertForm" -> boardController.list(request,BoardVO);
//		case "insert" -> boardController.insert(request, BoardVO);
		default -> "";
		};
		if (result instanceof Map map) {
			// json 문자열을 리턴
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().append(objectMapper.writeValueAsString(map));
		} else if (result instanceof String url) {
			if (url.startsWith("redirect:")) {
				// 리다이렉트
				response.sendRedirect(url.substring("redirect:".length()));
			} else {
				// 3. jsp 포워딩
				// 포워딩
				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/board/" + url + ".jsp");
				rd.forward(request, response);
			}
		}
	}

	private Map<String,Object> convertMap(Map<String, String[]> map) {
		Map<String, Object> result = new HashMap<>();

		for (var entry : map.entrySet()) {
			if (entry.getValue().length == 1) {
				// 문자열 1건
				result.put(entry.getKey(), entry.getValue()[0]);
			} else {
				// 문자열 배열을 추가한다
				result.put(entry.getKey(), entry.getValue());
			}
		}

		return result;
	}
}
