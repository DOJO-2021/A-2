package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.LoginUser;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// セッションスコープを破棄する
		HttpSession session = request.getSession();
		session.invalidate();

		// ログインページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("ID");
		String pw = request.getParameter("PW");

		//ログイン処理
		UserDAO iDao = new UserDAO();

		//ログインできた場合
		if (iDao.isLoginOK(id, pw)) {
			//セッションスコープにIDを格納する
			HttpSession session = request.getSession();
			session.setAttribute("id", new LoginUser(id));

			//unanswered.jspにリダイレクトする
			response.sendRedirect("/WEB-INF/jsp/unanswered.jsp");
		}
		//ログインできなかった場合
		else {
			//リクエストスコープにエラーメッセージを格納
			String errMsg = "※IDかPWが間違えています。";
			request.setAttribute("errMsg", errMsg);
			this.doGet(request, response);
		}



	}

}
