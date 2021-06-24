package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.QuestionDAO;
import model.Almighty;
/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/OpenQA/LoginServlet");
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/OpenQA/LoginServlet");
			return;
		}

		// リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		String word = request.getParameter("word");

		QuestionDAO qDAO = new QuestionDAO();
		ArrayList<Almighty> list = qDAO.select(word);
		if(list.size() == 0) {
			request.setAttribute("msg", "検索した項目は見つかりませんでした");
			//遷移
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/searchResult.jsp");
			dispatcher.forward(request, response);
		}else {
			request.setAttribute("question",list);
			//遷移
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/searchResult.jsp");
			dispatcher.forward(request, response);
		}




	}

}
