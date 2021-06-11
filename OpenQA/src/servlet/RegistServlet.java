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
import model.Result;
/**
 * Servlet implementation class RegistServlet
 */
@WebServlet("/RegistServlet")
public class RegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// セッションスコープを破棄する ★これ何？

		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/OpenQA/LoginServlet");
			return;
		}

		// modeという変数にもらってきた値を代入する 「どこから来たか」の情報が入っている
		String mode = request.getParameter("mode");

		// if文でどのjspにフォワードするか分岐する
		// userRegist.jspにフォワードする
		if(mode.equals ("userResist")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp");
			dispatcher.forward(request, response);
		// questionPost.jspにフォワードする
		} else if(mode.equals("question")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/questionPost.jsp");
			dispatcher.forward(request, response);
		// answerPost.jspにフォワードする
		} else if(mode.equals("answer")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/answerPost.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/OpenQA/LoginServlet");
			return;
		}

		String buttonID =request.getParameter("regist");
 		// もしもuserRegistのregistボタンが押されたら以下の処理を行う
		if(buttonID.equals("登録")) {

			// userRegist.jspのリクエストパラメータを取得する
			request.setCharacterEncoding("UTF-8");
			String id = request.getParameter("ID");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			int type = Integer.parseInt(request.getParameter("type"));
			String ins_pw = request.getParameter("ins_pw");

			/*
			int intType=0;
			if(type.equals("teacher")) {
				intType=1;
			}*/


			// 講師用PWが合っているか確認
			if(type == 1) {
				if(ins_pw.equals("HiguchiIsGod")) {
					// 登録処理を行う
					UserDAO bDao = new UserDAO();
					// 登録成功したらresult.javaに表示
					if (bDao.insert(id, pw, name, type)) {
						request.setAttribute("result",
								new Result("会員登録が成功しました。", "welcome～の画像パスを挿入", "/OpenQA/RegistServlet"));
					}
				}
			}

			// 登録処理を行う
			UserDAO bDao = new UserDAO();
			// 登録成功したらresult.javaに表示
			if (bDao.insert(id, pw, name, type)) {
				request.setAttribute("result",
						new Result("会員登録が成功しました。", "welcome～の画像パスを挿入", "/OpenQA/RegistServlet"));
			}
		}

		// もしもquestionPost.jspのボタンが押されたら以下の処理を行う
		String  =request.getParameter("");

		// もしもanswerPost.jspのボタンが押されたら以下の処理を行う

	}

}
