package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Almighty;
import model.Answer;
import model.Question;

public class QuestionDAO {

	//登録するためのメソッド
	public boolean insert(String q_id, int to, String id, int anonymity, String b_category, String s_category,
			Timestamp date,
			String title, String content, int solution, int metoo, String images, String name) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "insert into Question values (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, to);
			pStmt.setString(2, id);
			pStmt.setInt(3, anonymity);
			pStmt.setString(4, b_category);
			pStmt.setString(5, s_category);
			pStmt.setTimestamp(6, date);
			pStmt.setString(7, title);
			pStmt.setString(8, content);
			pStmt.setInt(9, solution);
			pStmt.setInt(10, metoo);
			pStmt.setString(11, images);
			pStmt.setString(12, name);

			// SQL文を実行するexecuteUpdateはupdateした数を返す
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}

	//編集のためのメソッド
	public boolean update(String q_id, int to, String id, int anonymity, String b_category, String s_category,
			Timestamp date,
			String title, String content, int solution, int metoo, String images) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "update Question set to = ?, id = ?, anonymity = ?, b_category = ?, s_category = ?, date = ?, title = ?, content = ?, solution = ?, metoo = ?, images = ? where q_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, to);
			pStmt.setString(2, id);
			pStmt.setInt(3, anonymity);
			pStmt.setString(4, b_category);
			pStmt.setString(5, s_category);
			pStmt.setTimestamp(6, date);
			pStmt.setString(7, title);
			pStmt.setString(8, content);
			pStmt.setInt(9, solution);
			pStmt.setInt(10, metoo);
			pStmt.setString(11, images);
			pStmt.setString(12, q_id);

			// SQL文を実行するexecuteUpdateはupdateした数を返す
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}

	//削除するためのメソッド
	public boolean delete(String q_id) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "delete from Question where q_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる。
			pStmt.setString(1, q_id);

			// SQL文を実行するexecuteUpdateはupdateした数を返す
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}

	//category検索のためのメソッド
	public ArrayList<Almighty> cate_select(String b_category) {
		Connection conn = null;
		ArrayList<Almighty> questionList = new ArrayList<Almighty>();

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "SELECT * FROM question left outer join answer on question.q_id = answer.q_id WHERE  b_category = ? order by s_category asc";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, b_category);

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				Almighty cate = new Almighty();
				cate.setQ_id(rs.getString("question.q_id"));
				cate.setTo(rs.getInt("question.to"));
				cate.setQ_userId(rs.getString("question.id"));
				cate.setQ_name(rs.getString("question.name"));
				cate.setQ_anonymity(rs.getInt("question.anonymity"));
				cate.setB_category(rs.getString("question.b_category"));
				cate.setS_category(rs.getString("question.s_category"));
				cate.setQ_date(rs.getTimestamp("question.date"));
				cate.setTitle(rs.getString("question.title"));
				cate.setContent(rs.getString("question.content"));
				cate.setSolution(rs.getInt("question.solution"));
				cate.setMetoo(rs.getInt("question.metoo"));
				cate.setQ_images(rs.getString("question.images"));
				cate.setA_id(rs.getString("answer.a_id"));
				cate.setA_userId(rs.getString("answer.id"));
				cate.setA_name(rs.getString("answer.name"));
				cate.setA_anonymity(rs.getInt("answer.anonymity"));
				cate.setA_date(rs.getTimestamp("answer.date"));
				cate.setAnswer(rs.getString("answer.answer"));
				cate.setA_images(rs.getString("answer.images"));
				questionList.add(cate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			questionList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			questionList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					questionList = null;
				}
			}
		}

		// 結果を返す
		return questionList;
	}

	//SELECT * FROM BC WHERE  name LIKE ? OR company LIKE ?　OR　コンテンツ　like ?
	//あいまい検索
	public ArrayList<Almighty> select(String word) {
		Connection conn = null;
		ArrayList<Almighty> questionList = new ArrayList<Almighty>();

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "SELECT * FROM question left outer join answer on question.q_id = answer.q_id WHERE  title like ? OR content like ? OR b_category like ? OR s_category like ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, "%" + word + "%");
			pStmt.setString(2, "%" + word + "%");
			pStmt.setString(3, "%" + word + "%");
			pStmt.setString(4, "%" + word + "%");

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				Almighty mypage = new Almighty();
				mypage.setQ_id(rs.getString("question.q_id"));
				mypage.setTo(rs.getInt("question.to"));
				mypage.setQ_userId(rs.getString("question.id"));
				mypage.setQ_name(rs.getString("question.name"));
				mypage.setQ_anonymity(rs.getInt("question.anonymity"));
				mypage.setB_category(rs.getString("question.b_category"));
				mypage.setS_category(rs.getString("question.s_category"));
				mypage.setQ_date(rs.getTimestamp("question.date"));
				mypage.setTitle(rs.getString("question.title"));
				mypage.setContent(rs.getString("question.content"));
				mypage.setSolution(rs.getInt("question.solution"));
				mypage.setMetoo(rs.getInt("question.metoo"));
				mypage.setQ_images(rs.getString("question.images"));
				mypage.setA_id(rs.getString("answer.a_id"));
				mypage.setA_userId(rs.getString("answer.id"));
				mypage.setA_name(rs.getString("answer.name"));
				mypage.setA_anonymity(rs.getInt("answer.anonymity"));
				mypage.setA_date(rs.getTimestamp("answer.date"));
				mypage.setAnswer(rs.getString("answer.answer"));
				mypage.setA_images(rs.getString("answer.images"));
				// ArrayListに上記7つのデータを格納
				questionList.add(mypage);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			questionList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			questionList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					questionList = null;
				}
			}
		}

		// 結果を返す
		return questionList;
	}

	// マイページに自分の質問を一覧表示させる
	public List<Almighty> mypageQuestion(String id) {
		Connection conn = null;
		List<Almighty> mypageQuestionList = new ArrayList<Almighty>();

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SELECT文を準備する
			// idでDB検索
			String sql = "Select * from question left outer join answer on question.q_id = answer.q_id where question.id = ?; ";

			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, id);

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする(リスト)
			while (rs.next()) {
				Almighty mypage = new Almighty();
				mypage.setQ_id(rs.getString("question.q_id"));
				mypage.setTo(rs.getInt("question.to"));
				mypage.setQ_userId(rs.getString("question.id"));
				mypage.setQ_name(rs.getString("question.name"));
				mypage.setQ_anonymity(rs.getInt("question.anonymity"));
				mypage.setB_category(rs.getString("question.b_category"));
				mypage.setS_category(rs.getString("question.s_category"));
				mypage.setQ_date(rs.getTimestamp("question.date"));
				mypage.setTitle(rs.getString("question.title"));
				mypage.setContent(rs.getString("question.content"));
				mypage.setSolution(rs.getInt("question.solution"));
				mypage.setMetoo(rs.getInt("question.metoo"));
				mypage.setQ_images(rs.getString("question.images"));
				mypage.setA_id(rs.getString("answer.a_id"));
				mypage.setA_userId(rs.getString("answer.id"));
				mypage.setA_name(rs.getString("answer.name"));
				mypage.setA_anonymity(rs.getInt("answer.anonymity"));
				mypage.setA_date(rs.getTimestamp("answer.date"));
				mypage.setAnswer(rs.getString("answer.answer"));
				mypage.setA_images(rs.getString("answer.images"));
				// ArrayListに上記7つのデータを格納
				mypageQuestionList.add(mypage);
			}
		}

		catch (SQLException e) {
			// コンソール画面に例外状況を記す
			e.printStackTrace();
			mypageQuestionList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			mypageQuestionList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					mypageQuestionList = null;
				}
			}
		}
		// 結果を返す
		return mypageQuestionList;
	}

	public List<Almighty> unansweredQuestion() {
		Connection conn = null;
		List<Almighty> mypageQuestionList = new ArrayList<Almighty>();

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SELECT文を準備する
			// idでDB検索
			String sql = "Select * from question left outer join answer on question.q_id = answer.q_id where question.solution = 0; ";

			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする(リスト)
			while (rs.next()) {
				Almighty mypage = new Almighty();
				mypage.setQ_id(rs.getString("question.q_id"));
				mypage.setTo(rs.getInt("question.to"));
				mypage.setQ_userId(rs.getString("question.id"));
				mypage.setQ_name(rs.getString("question.name"));
				mypage.setQ_anonymity(rs.getInt("question.anonymity"));
				mypage.setB_category(rs.getString("question.b_category"));
				mypage.setS_category(rs.getString("question.s_category"));
				mypage.setQ_date(rs.getTimestamp("question.date"));
				mypage.setTitle(rs.getString("question.title"));
				mypage.setContent(rs.getString("question.content"));
				mypage.setSolution(rs.getInt("question.solution"));
				mypage.setMetoo(rs.getInt("question.metoo"));
				mypage.setQ_images(rs.getString("question.images"));
				mypage.setA_id(rs.getString("answer.a_id"));
				mypage.setA_userId(rs.getString("answer.id"));
				mypage.setA_name(rs.getString("answer.name"));
				mypage.setA_anonymity(rs.getInt("answer.anonymity"));
				mypage.setA_date(rs.getTimestamp("answer.date"));
				mypage.setAnswer(rs.getString("answer.answer"));
				mypage.setA_images(rs.getString("answer.images"));
				// ArrayListに上記7つのデータを格納
				mypageQuestionList.add(mypage);
			}
		}

		catch (SQLException e) {
			// コンソール画面に例外状況を記す
			e.printStackTrace();
			mypageQuestionList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			mypageQuestionList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					mypageQuestionList = null;
				}
			}
		}
		// 結果を返す
		return mypageQuestionList;
	}

	// マイページに自分の質問を一覧表示させる
	public List<Almighty> mypageQanswer(String id) {
		Connection conn = null;
		List<Almighty> mypageQuestionList = new ArrayList<Almighty>();

		try {

			AnswerDAO ans = new AnswerDAO();
			List<Answer> myAnswer = ans.mypageAnswer(id);
			for (Answer value : myAnswer) {

				// JDBCドライバを読み込む
				Class.forName("org.h2.Driver");

				// データベースに接続する
				conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

				// SELECT文を準備する
				// idでDB検索
				String sql = "Select * from question left outer join answer on question.q_id = answer.q_id where question.id = ?; ";

				PreparedStatement pStmt = conn.prepareStatement(sql);

				// SQL文を完成させる
				pStmt.setString(1, value.getQ_id());

				// SQL文を実行し、結果表を取得する
				ResultSet rs = pStmt.executeQuery();

				// 結果表をコレクションにコピーする(リスト)
				while (rs.next()) {
					Almighty mypage = new Almighty();
					mypage.setQ_id(rs.getString("question.q_id"));
					mypage.setTo(rs.getInt("question.to"));
					mypage.setQ_userId(rs.getString("question.id"));
					mypage.setQ_name(rs.getString("question.name"));
					mypage.setQ_anonymity(rs.getInt("question.anonymity"));
					mypage.setB_category(rs.getString("question.b_category"));
					mypage.setS_category(rs.getString("question.s_category"));
					mypage.setQ_date(rs.getTimestamp("question.date"));
					mypage.setTitle(rs.getString("question.title"));
					mypage.setContent(rs.getString("question.content"));
					mypage.setSolution(rs.getInt("question.solution"));
					mypage.setMetoo(rs.getInt("question.metoo"));
					mypage.setQ_images(rs.getString("question.images"));
					mypage.setA_id(rs.getString("answer.a_id"));
					mypage.setA_userId(rs.getString("answer.id"));
					mypage.setA_name(rs.getString("answer.name"));
					mypage.setA_anonymity(rs.getInt("answer.anonymity"));
					mypage.setA_date(rs.getTimestamp("answer.date"));
					mypage.setAnswer(rs.getString("answer.answer"));
					mypage.setA_images(rs.getString("answer.images"));
					// ArrayListに上記7つのデータを格納
					mypageQuestionList.add(mypage);
				}
			}
		}

		catch (SQLException e) {
			// コンソール画面に例外状況を記す
			e.printStackTrace();
			mypageQuestionList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			mypageQuestionList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					mypageQuestionList = null;
				}
			}
		}
		// 結果を返す
		return mypageQuestionList;
	}

	//	QuestionDAOで質問IDから検索できるメソッドを作る。★いらなくね
	public List<Question> mypageQuestionId(String q_id) {
		Connection conn = null;
		List<Question> mypageQuestionList = new ArrayList<Question>();

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SELECT文を準備する
			// idでDB検索
			String sql = "select * from question where ID = ?  ";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, q_id);

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする(リスト)
			while (rs.next()) {
				Question mypage = new Question(
						rs.getString("q_id"),
						rs.getInt("to"),
						rs.getString("id"),
						rs.getString("name"),
						rs.getInt("anonymity"),
						rs.getString("b_category"),
						rs.getString("s_category"),
						rs.getTimestamp("date"),
						rs.getString("title"),
						rs.getString("content"),
						rs.getInt("solution"),
						rs.getInt("metoo"),
						rs.getString("images"));

				// ArrayListに上記7つのデータを格納
				mypageQuestionList.add(mypage);
			}
		}

		catch (SQLException e) {
			// コンソール画面に例外状況を記す
			e.printStackTrace();
			mypageQuestionList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			mypageQuestionList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					mypageQuestionList = null;
				}
			}
		}
		// 結果を返す
		return mypageQuestionList;
	}

	public boolean solution(int solution, String q_id) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "update Question set solution=? where q_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, solution);
			pStmt.setString(2, q_id);
			// SQL文を実行するexecuteUpdateはupdateした数を返す
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}

	public boolean meToo(int meToo, String q_id) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "update Question set meToo=? where q_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, meToo);
			pStmt.setString(2, q_id);
			// SQL文を実行するexecuteUpdateはupdateした数を返す
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}
}
