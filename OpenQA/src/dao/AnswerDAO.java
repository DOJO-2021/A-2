package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Answer;

public class AnswerDAO {

	// ①マイページに自分の回答結果を一覧表示
	public List<Answer> mypageAnswer(Answer param) { // ★保留！
		Connection conn = null;
		List<Answer> mypageAnswerList = new ArrayList<Answer>();


		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SELECT文を準備する
			// idでDB検索
			String sql = "select * from answer where ID = ?  ";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			if (param.getId() != null) {
				pStmt.setString(1, "%" + param.getId() + "%");
			}
			else {
				pStmt.setString(1, "%");
			}

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする(リスト)
			while (rs.next()) {
				Answer mypage = new Answer(
						rs.getString("a_id"),
						rs.getString("id"),
						rs.getInt("anonymity"),
						rs.getTimestamp("date"),
						rs.getString("answer"),
						rs.getString("images"),
						rs.getString("q_id")
						);

				// ArrayListに上記7つのデータを格納
				mypageAnswerList.add(mypage);
			}
		}

		catch (SQLException e) {
			// コンソール画面に例外状況を記す
			e.printStackTrace();
			mypageAnswerList = null;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			mypageAnswerList = null;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					mypageAnswerList = null;
				}
			}
		}
		// 結果を返す
		return mypageAnswerList;
	}

	// ②回答投稿（登録）
	// 引数cardで指定されたレコードを登録し、成功したらtrueを返す
	public boolean insert(String id, int anonymity, Timestamp date, String answer, String images, String q_id) {
		Connection conn = null;
		// 処理の結果を入れる変数
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SELECT文を準備する
			// idでDB検索
			String sql = "insert into answer values(?, ?, ?, ?, ?, ?, ?) ";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setString(1, id);
			pStmt.setInt(2, anonymity);
			pStmt.setTimestamp(3, date);
			pStmt.setString(4, answer);
			pStmt.setString(5, images);
			pStmt.setString(6, q_id);

			// 登録できたら1でtrue
			int num = pStmt.executeUpdate();
			if(num == 1) {
				result = true;
			} else {
				result = false;
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
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}

	// 回答編集 update
	// 引数cardで指定されたレコードを更新し、成功したらtrueを返す

	public boolean update(String a_id, String id, int anonymity, Timestamp date, String answer, String images, String q_id) {
		Connection conn = null;
		// 処理の結果を入れる変数
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SELECT文を準備する
			// idでDB検索
			String sql = "update answer set anonymity=?, date=?, answer=?, images=? where a_id=? ";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setInt(1, anonymity);
			pStmt.setTimestamp(2, date);
			pStmt.setString(3, answer);
			pStmt.setString(4, images);

			// 登録できたら1でtrue
			int num = pStmt.executeUpdate();
			if(num == 1) {
				result = true;
			} else {
				result = false;
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
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}

	// ④回答削除
	public boolean delete(String a_id) {
		Connection conn = null;
		// 処理の結果を入れる変数
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SELECT文を準備する
			// idでDB検索
			String sql = "delete from answer where a_id=? ";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, a_id);

			// 登録できたら1でtrue
			int num = pStmt.executeUpdate();
			if(num == 1) {
				result = true;
			} else {
				result = false;
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
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}

}
