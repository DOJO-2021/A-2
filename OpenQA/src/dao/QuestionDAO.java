package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;



public class QuestionDAO {

	//登録するためのメソッド
		public boolean insert(String q_id, int to, String id, int anonymity, String b_category, String s_category, Date date,
				String title, String content, int solution, int metoo, String images) {
			Connection conn = null;
			boolean result = false;

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
		}

}
