package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BcDAO;
import model.Bc;

/**
 * Servlet implementation class MyPageServlet
 */
@WebServlet("/MyPageServlet")
public class MyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// myページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPage.jsp");
		dispatcher.forward(request, response);
	}

	// 自分のした質問
	// Questionテーブルはセッションスコープのidと一致するquestionを持ってくる。
	// QuestionDAOの内容をごっそりとってきてListに入れる。
	request.setAttribute("mypageQuestionList", mypageQuestionList);

	//	自分が回答した質問の一覧
	//	１、answerテーブルのセッションスコープのidと一致するanswerを持ってくる。
	//	２、answerのq_idと一致するquestionを持ってくる。
	//	QuestionDAOで質問IDから検索できるメソッドを作る。
	//	その引数はmypageAnswerメソッドで入手したq_id
	//	３、その持ってきたq_idと一致するanswerをすべて持ってくる。

}
