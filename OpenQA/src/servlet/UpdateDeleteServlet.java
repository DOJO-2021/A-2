package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

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
import model.Almighty;
import model.User;

/**
 * Servlet implementation class UpdateDeleteServlet
 */
@MultipartConfig(location = "C:\\pleiades\\workspace\\A-2\\OpenQA\\WebContent\\images")
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
		System.out.println(mode);

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
					String preImages = request.getParameter("preImage");
					Part part = request.getPart("IMAGE");
					String images = null;
					if (part.getSize() != 0) {
						images = this.getFileName(part);
						part.write(images);
					} else {
						images = preImages;
					}

					QuestionDAO qDao = new QuestionDAO();

					qDao.update(q_id, to, id, anonymity, b_category, s_category, date, title, content, solution, meToo, images );

					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/close.jsp");
					dispatcher.forward(request, response);

				}
				if(request.getParameter("SUBMIT").equals("質問削除")) {
					String mode = request.getParameter("mode");
					QuestionDAO qDao = new QuestionDAO();



					if(mode.equals("mypage")) {
						qDao.delete(q_id);
						// データ格納
						List<Almighty> mypageQuestionList = qDao.mypageQuestion(user.getId());
						List<Almighty> mypageQanswerList = qDao.mypageQanswer(user.getId());

						request.setAttribute("question", mypageQuestionList);
						request.setAttribute("answer", mypageQanswerList);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPage.jsp");
						dispatcher.forward(request, response);
					} else if (mode.equals("category")) {
						qDao.delete(q_id);

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


						request.setAttribute("list", list);


						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/category.jsp");
						dispatcher.forward(request, response);

					} else if (mode.equals("unans")) {
						qDao.delete(q_id);

						QuestionDAO unqDao = new QuestionDAO();
						List<Almighty> unanswer = unqDao.unansweredQuestion();
						request.setAttribute("question", unanswer);

						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/unanswered.jsp");
						dispatcher.forward(request, response);

					}

				}
				//解答　編集と削除
				if(request.getParameter("SUBMIT").equals("回答編集")) {
					String a_id = request.getParameter("a_id");
					int anonymity = Integer.parseInt(request.getParameter("anonymity"));
					Timestamp date =  new Timestamp(System.currentTimeMillis());
					String answer = request.getParameter("content");
					String preImages = request.getParameter("preImage");
					Part part = request.getPart("IMAGE");
					String images = null;
					if (part.getSize() != 0) {
						images = this.getFileName(part);
						part.write(images);
					} else {
						images = preImages;
					}

					AnswerDAO aDao = new AnswerDAO();

					aDao.update(a_id, id, anonymity, date, answer, images, q_id);

					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/close.jsp");
					dispatcher.forward(request, response);
				}
				if(request.getParameter("SUBMIT").equals("回答削除")) {
					String a_id = request.getParameter("a_id");
					String mode = request.getParameter("mode");
					AnswerDAO aDao = new AnswerDAO();
					QuestionDAO qDao = new QuestionDAO();




					if(mode.equals("mypage")) {
						aDao.delete(a_id);

						// データ格納
						List<Almighty> mypageQuestionList = qDao.mypageQuestion(user.getId());
						List<Almighty> mypageQanswerList = qDao.mypageQanswer(user.getId());

						request.setAttribute("question", mypageQuestionList);
						request.setAttribute("answer", mypageQanswerList);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPage.jsp");
						dispatcher.forward(request, response);
					} else if (mode.equals("category")) {
						aDao.delete(a_id);

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

					} else if (mode.equals("unans")) {
						aDao.delete(a_id);
						QuestionDAO unqDao = new QuestionDAO();
						List<Almighty> unanswer = unqDao.unansweredQuestion();
						request.setAttribute("question", unanswer);

						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/unanswered.jsp");
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
