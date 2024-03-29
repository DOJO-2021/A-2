package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.User;


public class UserDAO {

	// ログインできるならtrueを返す
	public User isLoginOK(String id, String pw) {
		Connection conn = null;
		User user = new User();
		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SELECT文を準備する
			String sql = "select * from user where ID = ? and PW = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, id);
			pStmt.setString(2, pw);

			// SELECT文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// ユーザーIDとパスワードが一致するユーザーがいた場合、ユーザーに情報を送る。
			while(rs.next()) {
				user.setId(rs.getString("id"));
				user.setName(rs.getString("name"));
				user.setType(rs.getInt("type"));
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
		return user;
	}



	public boolean insert(String id,String pw,String name,int type) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA","sa", "");
			// SQL文を準備する
			String sql = "insert into user (id, pw, name, type,) values (?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, id);
			pStmt.setString(2, pw);
			pStmt.setString(3, name);
			pStmt.setInt(4, type);
			int num = pStmt.executeUpdate();
			if(num == 1) {
				result = true;
			}else {
				result = false;
			}
		}catch (SQLException e) {
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

	//PW再設定
	public boolean update(String pw, String id) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SQL文を準備する
			String sql = "update user set pw=? where id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, pw);
			pStmt.setString(2, id);
			// SQL文を実行する
			int num = pStmt.executeUpdate();
			if(num == 1) {
				result = true;
			}else {
				result = false;
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

public boolean cheack(String id, String name) {
	Connection conn = null;
	boolean result = false;

	try {
		// JDBCドライバを読み込む
		Class.forName("org.h2.Driver");

		// データベースに接続する
		conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

		// SQL文を準備する
		String sql = "select count(*) from user where id = ? and name = ?";
		PreparedStatement pStmt = conn.prepareStatement(sql);
		pStmt.setString(1, id);
		pStmt.setString(2, name);
		ResultSet rs = pStmt.executeQuery();

		// ユーザーIDとパスワードが一致するユーザーがいたかどうかをチェックする
		rs.next();
		if (rs.getInt("count(*)") == 1) {
			result = true;
		}
	}
		catch (SQLException e) {
			e.printStackTrace();
		 result = false;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			result = false;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					result = false;
				}
			}
		}

		// 結果を返す
		return result;
	}


}


