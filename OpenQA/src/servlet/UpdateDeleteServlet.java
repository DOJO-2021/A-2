package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;

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
				if(request.getParameter("SUBMIT").equals("質問編集")) {
					int to = Integer.parseInt(request.getParameter("to"));
					int anonymity = Integer.parseInt(request.getParameter("anonymity"));
					String b_category = request.getParameter("b_category");
					String s_category = request.getParameter("s_category");
					Timestamp date =  new Timestamp(System.currentTimeMillis());
					String title = request.getParameter("title");
					String content = request.getParameter("content");
					String images = request.getParameter("IMAGE");
					String preImages = request.getParameter("preImage");
					if (images.equals("") && preImages.equals("")) {//画像なしの場合

					} else if(!images.equals("") && !preImages.equals("")) {//画像を変更した場合

					} else if(!images.equals("") && preImages.equals("")) {//画像を変更しなかった場合
						images = preImages;
					} else if(images.equals("") && !preImages.equals("")) {//画像を追加した場合

					}


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
					System.out.println("aa");
					String mode = request.getParameter("mode");
					AnswerDAO aDao = new AnswerDAO();
					aDao.delete(a_id);
					if(mode.equals("mypage")) {
						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPage.jsp");
						dispatcher.forward(request, response);
					} else if (mode.equals("category")) {

						//リクエストパラメータを取得
						request.setCharacterEncoding("UTF-8");
						String b_category = request.getParameter("bcategory");
						System.out.println(b_category);
						QuestionDAO qDAO = new QuestionDAO();
						ArrayList<Almighty> questions = qDAO.cate_select(b_category);
						ArrayList<ArrayList<Almighty>>list = new ArrayList<>();
						ArrayList<Almighty>s_list = null;

						for(Almighty a : questions) {
							System.out.println(a.getS_category());
						}

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

						for (ArrayList<Almighty> a : list) {
							System.out.println("から");
							for (Almighty b : a) {
								System.out.println(b.getS_category()+"から");
							}
						}

						request.setAttribute("list", list);


						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/category.jsp");
						dispatcher.forward(request, response);
					}
				}
			}
				//solutionが押されたら動く
			if(so.equals("123")) {
				System.out.println(q_id);

				QuestionDAO qDao = new QuestionDAO();
				qDao.solution(solution, q_id);

				System.out.println(solution);

			}
			//metooが押されたら動く
			if(meto.equals("999")) {
				System.out.println(meToo);
				QuestionDAO qDao = new QuestionDAO();
				qDao.meToo(meToo, q_id);
			}



			}catch(Exception e){

			}

	}


}
