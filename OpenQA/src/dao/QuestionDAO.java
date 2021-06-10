package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import model.Question;


public class QuestionDAO {

	//登録するためのメソッド
	public boolean insert(String q_id, int to, String id, int anonymity, String b_category, String s_category, Date date,
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
			pStmt.setDate(6, date);
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
	public boolean update(String q_id, int to, String id, int anonymity, String b_category, String s_category, Date date,
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
			pStmt.setDate(6, date);
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


	//SELECT * FROM BC WHERE  name LIKE ? OR company LIKE ?　OR　コンテンツ　like ?
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
			String sql = "SELECT * FROM Question WHERE  b_category = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, b_category);


			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				Question card = new Bc(
				rs.getString("BC_ID"),
				rs.getString("COMPANY"),
				rs.getString("DEPARTMENT"),
				rs.getString("POSITION"),
				rs.getString("NAME"),
				rs.getString("MAIL"),
				rs.getString("POSTCODE"),
				rs.getString("ADDRESS"),
				rs.getString("TEL"),
				rs.getString("FAX"),
				rs.getString("MOBILE_PHONE"),
				rs.getString("REMARKS")
				);
				cardList.add(card);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			cardList = null;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			cardList = null;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					cardList = null;
				}
			}
		}

		// 結果を返す
		return cardList;
	}
	}


}
