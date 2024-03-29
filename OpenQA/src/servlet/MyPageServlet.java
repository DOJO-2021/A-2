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

import dao.AnswerDAO;
import dao.QuestionDAO;
import model.Almighty;
import model.User;


/**
 * Servlet implementation class MyPageServlet
 */
@WebServlet("/MyPageServlet")
public class MyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// myページにフォワードする
//		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPage.jsp");
//		dispatcher.forward(request, response);
//	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/OpenQA/LoginServlet");
			return;
		}

			// 自分のした質問
			// Questionテーブルはセッションスコープのidと一致するquestionを持ってくる。
			// QuestionDAOの内容をごっそりとってきてListに入れる。
			QuestionDAO qDao = new QuestionDAO();
			User user = (User) session.getAttribute("user");
			List<Almighty> mypageQuestionList = qDao.mypageQuestion(user.getId());

			//	自分が回答した質問の一覧
			List<Almighty> mypageQanswerList = qDao.mypageQanswer(user.getId());

			request.setAttribute("question", mypageQuestionList);
			request.setAttribute("answer", mypageQanswerList);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPage.jsp");
			dispatcher.forward(request, response);
		}
}
