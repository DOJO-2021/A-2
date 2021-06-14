package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class MenuServlet
 */
@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public MenuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//もしもログインしてなかったらログインサーブレットにリダイレクト
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/OpenQA/LoginServlet");
			return;
		}
		// modeという変数にもらってきた値を代入する 「どこから来たか」の情報が入っている
		String mode = request.getParameter("mode");

		// if文でどのjspにフォワードするか分岐する
		// category.jspにフォワードする
		if(mode.equals ("category")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/category.jsp");
			dispatcher.forward(request, response);
		// guide.jspにフォワードする
		} else if(mode.equals("guide")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/guide.jsp");
			dispatcher.forward(request, response);
		//unanswered.jspにフォワードする
		} else if(mode.equals("unanswered")) {




			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/unanswered.jsp");
			dispatcher.forward(request, response);
		} else {//ログイン画面に戻る
			response.sendRedirect("/OpenQA/LoginServlet");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
