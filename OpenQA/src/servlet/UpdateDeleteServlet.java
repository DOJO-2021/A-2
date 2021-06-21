package servlet;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AnswerDAO;
import dao.QuestionDAO;
import model.User;

/**
 * Servlet implementation class UpdateDeleteServlet
 */
@WebServlet("/UpdateDeleteServlet")
public class UpdateDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/OpenQA/LoginServlet");
			return;

		}
		//ページ遷移系
		// modeという変数にもらってきた値を代入する 「どこから来たか」の情報が入っている
		String mode = request.getParameter("mode");

		if(mode.equals ("question")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/questionEdit.jsp");
			dispatcher.forward(request, response);
		// guide.jspにフォワードする
		}
		if(mode.equals("answer")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/answerEdit.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/OpenQA/LoginServlet");
			return;
		}
		int solution = Integer.parseInt(request.getParameter("solution"));
		int meToo = Integer.parseInt(request.getParameter("meToo"));
		String so = request.getParameter("so");
		String q_id = request.getParameter("q_id");
		String meto = request.getParameter("meto");
		User user = (User)session.getAttribute("user");
		String id = user.getId();
		try {//質問　編集と削除
			if(request.getParameter("SUBMIT")!=null) {
				if(request.getParameter("SUBMIT").equals("q_update")) {
					int to = Integer.parseInt(request.getParameter("to"));
					int anonymity = Integer.parseInt(request.getParameter("anonymity"));
					String b_category = request.getParameter("b_category");
					String s_category = request.getParameter("s_category");
					Timestamp date =  new Timestamp(System.currentTimeMillis());
					String title = request.getParameter("title");
					String content = request.getParameter("content");
					String images = request.getParameter("images");


					QuestionDAO qDao = new QuestionDAO();

					qDao.update(q_id, to, id, anonymity, b_category, s_category, date, title, content, solution, meToo, images );
				}
				if(request.getParameter("SUBMIT").equals("質問削除")) {
					String mode = request.getParameter("mode");
					QuestionDAO qDao = new QuestionDAO();

					qDao.delete(q_id);

					if(mode.equals("mypage")) {
						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPage.jsp");
						dispatcher.forward(request, response);
					}

				}
				//解答　編集と削除
				if(request.getParameter("SUBMIT").equals("a_update")) {
					String a_id = request.getParameter("a_id");
					int anonymity = Integer.parseInt(request.getParameter("anonymity"));
					Timestamp date =  new Timestamp(System.currentTimeMillis());
					String answer = request.getParameter("answer");
					String images = request.getParameter("images");

					AnswerDAO aDao = new AnswerDAO();

					aDao.update(a_id, id, anonymity, date, answer, images, q_id);
				}
				if(request.getParameter("SUBMIT").equals("回答削除")) {
					String a_id = request.getParameter("a_id");
					AnswerDAO aDao = new AnswerDAO();
					aDao.delete(a_id);
				}
			}
				//solutionが押されたら動く
			if(so.equals("123")) {
				System.out.print(solution);

				QuestionDAO qDao = new QuestionDAO();
				qDao.solution(solution, q_id);

				System.out.print(solution);

			}
			//metooが押されたら動く
			if(meto.equals("999")) {
				QuestionDAO qDao = new QuestionDAO();
				qDao.meToo(meToo, q_id);
			}



			}catch(Exception e){

			}

	}


}
