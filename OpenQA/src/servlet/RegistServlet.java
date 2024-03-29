package servlet;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.AnswerDAO;
import dao.QuestionDAO;
import dao.UserDAO;
import model.Result;
import model.User;

/**
 * Servlet implementation class RegistServlet
 */
@WebServlet("/RegistServlet")
@MultipartConfig(location = "C:\\pleiades\\workspace\\A-2\\OpenQA\\WebContent\\images") // アップロードファイルの一時的な保存先
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
		String mode = request.getParameter("mode");
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if(!mode.equals("userRegist") && !mode.equals("reset")) {
			if (session.getAttribute("user") == null) {
				response.sendRedirect("/OpenQA/LoginServlet");
				return;
			}
		}
		// modeという変数にもらってきた値を代入する 「どこから来たか」の情報が入っている

		// if文でどのjspにフォワードするか分岐する
		// userRegist.jspにフォワードする
		if(mode.equals ("userRegist")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp");
			dispatcher.forward(request, response);
		// reset.jspにフォワードする
		} else if(mode.equals ("reset")) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/reset.jsp");
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
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("SUBMIT"));

		//String mode = request.getParameter("mode");
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
//		//if(!mode.equals("userRegist")) {
//			if (session.getAttribute("user") == null) {
//				response.sendRedirect("/OpenQA/LoginServlet");
//				return;
//			}
//		//}

		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("SUBMIT"));
 		// ①もしもuserRegistのregistボタンが押されたら以下の処理を行う
		if(request.getParameter("SUBMIT").equals("登録")) {

			// userRegist.jspのリクエストパラメータを取得する
			request.setCharacterEncoding("UTF-8");
			String id = request.getParameter("ID");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			int type = Integer.parseInt(request.getParameter("type"));
			String ins_pw = request.getParameter("ins_pw");
			UserDAO bDao = new UserDAO();


			// 講師用PWが合っているか確認
			if(type == 1) {
				if(ins_pw.equals("HiguchiIsGod")) {
					// 登録成功したらresult.javaに表示
					if (bDao.insert(id, pw, name, type)) {
						request.setAttribute("result",
								new Result("会員登録が成功しました。", "あり", "aa"));
						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/result.jsp");
						dispatcher.forward(request, response);
					}
				}
			} else {
				// 登録成功したらresult.javaに表示
				if (bDao.insert(id, pw, name, type)) {
					request.setAttribute("result",
						new Result("会員登録が成功しました。", "あり", "aa"));
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/result.jsp");
					dispatcher.forward(request, response);
				}
			}
		}

		// ②もしもquestionPost.jspのボタンが押されたら以下の処理を行う

		else if(request.getParameter("SUBMIT").equals("質問投稿")) {

			if (session.getAttribute("user") == null) {
				response.sendRedirect("/OpenQA/LoginServlet");
				return;
			}

			// questionPost.jspのリクエストパラメータを取得する
			request.setCharacterEncoding("UTF-8");
			int to = Integer.parseInt(request.getParameter("to"));
			// userのidをセッションスコープから持ってくる
			User user = (User)session.getAttribute("user");
			String id = user.getId();
			int anonymity = Integer.parseInt(request.getParameter("anonymity"));
			String b_category = request.getParameter("b_category");
			String s_category = request.getParameter("s_category");
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			Part part = request.getPart("IMAGE");
			String images = null;
			if (part.getSize() != 0) {
				images = this.getFileName(part);
				part.write(images);
			}

			String name = user.getName();

			// 登録処理を行う
			QuestionDAO bDao = new QuestionDAO();

			// 登録成功したら...
			bDao.insert("", to, id, anonymity, b_category, s_category, timestamp, title, content, 0, 0, images, name);
			System.out.println("aa");
		}

		// ③もしもanswerPost.jspのボタンが押されたら以下の処理を行う

		else if(request.getParameter("SUBMIT").equals("回答投稿")) {
			System.out.println("aaa");
			// answerPost.jspのリクエストパラメータを取得する
			request.setCharacterEncoding("UTF-8");

			if (session.getAttribute("user") == null) {
				response.sendRedirect("/OpenQA/LoginServlet");
				return;
			}
			// userのidをセッションスコープから持ってくる
			User user = (User)session.getAttribute("user");
			String id = user.getId();
			int anonymity = Integer.parseInt(request.getParameter("anonymity"));
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			String content = request.getParameter("content");
			String q_id = request.getParameter("q_id");
			String name = user.getName();
			System.out.println(content);
			Part part = request.getPart("IMAGE");
			String images = null;
			if (part.getSize() != 0) {
				images = this.getFileName(part);
				part.write(images);
			}

			// 登録処理を行う
			AnswerDAO bDao = new AnswerDAO();

			// 登録成功したら...
			bDao.insert(id, anonymity,  timestamp, content, images, q_id, name);
			System.out.println("aaa");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/close.jsp");
		dispatcher.forward(request, response);

	}

	//ファイルの名前を取得してくる
		private String getFileName(Part part) {
	        String name = null;
	        for (String dispotion : part.getHeader("Content-Disposition").split(";")) {
	            if (dispotion.trim().startsWith("filename")) {
	                name = dispotion.substring(dispotion.indexOf("=") + 1).replace("\"", "").trim();
	                name = name.substring(name.lastIndexOf("\\") + 1);
	                break;
	            }
	        }		// TODO 自動生成されたメソッド・スタブ
			return name;
		}

}
