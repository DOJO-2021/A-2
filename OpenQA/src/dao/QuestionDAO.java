package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Question;


public class QuestionDAO {

	//登録するためのメソッド
	public boolean insert(String q_id, int to, String id, int anonymity, String b_category, String s_category, Timestamp date,
			String title, String content, int solution, int metoo, String images) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql =
					"insert into Question values (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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

			// SQL文を実行するexecuteUpdateはupdateした数を返す
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}

		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}

	//編集のためのメソッド
	public boolean update(String q_id, int to, String id, int anonymity, String b_category, String s_category, Timestamp date,
			String title, String content, int solution, int metoo, String images) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql =
					"update Question set to = ?, id = ?, anonymity = ?, b_category = ?, s_category = ?, date = ?, title = ?, content = ?, solution = ?, metoo = ?, images = ? where q_id = ?";
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

		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
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
			String sql =
					"delete from Question where q_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる。
			pStmt.setString(1, q_id);

			// SQL文を実行するexecuteUpdateはupdateした数を返す
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}

		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}



	//category検索のためのメソッド
	public List<Question> cate_select(String b_category) {
		Connection conn = null;
		List<Question> questionList = new ArrayList<Question>();


		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "SELECT * FROM Question WHERE  b_category = ? order by s_category asc";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, b_category);


			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				Question card = new Question(
				rs.getString("q_id"),
				rs.getInt("to"),
				rs.getString("id"),
				rs.getInt("anonymity"),
				rs.getString("b_category"),
				rs.getString("s_category"),
				rs.getDate("date"),
				rs.getString("title"),
				rs.getString("content"),
				rs.getInt("solution"),
				rs.getInt("metoo"),
				rs.getString("images")
				);
				questionList.add(card);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			questionList = null;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			questionList = null;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
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
	public List<Question> select(String word) {
		Connection conn = null;
		List<Question> questionList = new ArrayList<Question>();


		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "SELECT * FROM Question WHERE  title like ? OR content like ? OR b_category like ? OR s_category like ?";
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
				Question card = new Question(
				rs.getString("q_id"),
				rs.getInt("to"),
				rs.getString("id"),
				rs.getInt("anonymity"),
				rs.getString("b_category"),
				rs.getString("s_category"),
				rs.getDate("date"),
				rs.getString("title"),
				rs.getString("content"),
				rs.getInt("solution"),
				rs.getInt("metoo"),
				rs.getString("images")
				);
				questionList.add(card);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			questionList = null;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			questionList = null;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					questionList = null;
				}
			}
		}

		// 結果を返す
		return questionList;
	}

}
