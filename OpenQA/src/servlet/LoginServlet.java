package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.QuestionDAO;
import dao.UserDAO;
import model.Almighty;
import model.User;


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
		User user = iDao.isLoginOK(id , pw);
		System.out.println(user.getName()+"aaa");

		//ログインできた場合
		if (user.getName() != null) {
			//セッションスコープにIDを格納する
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			//unanswered.jspにフォワードする
			QuestionDAO qDao = new QuestionDAO();
			List<Almighty> mypageQuestionList = qDao.unansweredQuestion();
			request.setAttribute("question", mypageQuestionList);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/unanswered.jsp");
			dispatcher.forward(request, response);
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
