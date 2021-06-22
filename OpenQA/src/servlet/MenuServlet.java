package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
			QuestionDAO qDAO = new QuestionDAO();
			List<Almighty> list = qDAO.unansweredQuestion();

			request.setAttribute("unans",list);

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
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/OpenQA/LoginServlet");
			return;
		}

		//リクエストパラメータを取得
		request.setCharacterEncoding("UTF-8");
		String b_category = request.getParameter("b_category");

		QuestionDAO qDAO = new QuestionDAO();
		ArrayList<Almighty> questions = qDAO.cate_select(b_category);
		ArrayList<ArrayList<Almighty>>list = new ArrayList<>();
		ArrayList<Almighty>s_list = null;

		String cate = "";
		int count = 0;
		for (int i=0; i<questions.size(); i++) {
			if (!questions.get(i).getS_category().equals(cate) && count!=0) {
				list.add(s_list);
				count = 0;
			}

			if (!questions.get(i).getS_category().equals(cate) && count==0) {
				s_list = new ArrayList<>();
				s_list.add(questions.get(i));
				cate = questions.get(i).getS_category();
				count++;

			} else if  (questions.get(i).getS_category().equals(cate)) {
				s_list.add(questions.get(i));
			}

			if (i == questions.size() - 1) {
				list.add(s_list);
			}

		}

		request.setAttribute("list", list);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/category.jsp");
		dispatcher.forward(request, response);



	}

}
