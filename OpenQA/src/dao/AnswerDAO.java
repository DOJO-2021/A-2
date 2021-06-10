package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;

public class AnswerDAO {

	public Answer () {
		Connection conn = null;
		Answer user = new User();
		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/OpenQA", "sa", "");

			// SELECT文を準備する
			String sql = "select * from answer where ID = ? "; // ID以外のカラム何？
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, id);

			// SELECT文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();
		}
	}
}
