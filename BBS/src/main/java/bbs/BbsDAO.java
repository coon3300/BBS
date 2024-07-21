package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;

	public BbsDAO() {
		try {
			// mysql
			Class.forName("com.mysql.jdbc.Driver");
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "root";

//        	// oracle
//            Class.forName("oracle.jdbc.driver.OracleDriver");
//            String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
//            String dbID = "bbs";
//            String dbPassword = "bbs";

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			System.out.println("DB 접속 성공");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getDate() {
    	String SQL = "SELECT NOW()";
    	
    	try {
    		
    		PreparedStatement psmt = conn.prepareStatement(SQL);
    		rs = psmt.executeQuery();
    		
    		if(rs.next()) {
    			return rs.getString(1);
    		}
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return ""; // 데이터 베이스 오류
	}
	
	public int getNext() {
		
    	String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
    	
    	try {
    		PreparedStatement psmt = conn.prepareStatement(SQL);
    		rs = psmt.executeQuery();
    		
    		if(rs.next()) {
    			return rs.getInt(1) +1;
    		}
    		
    		return 1; // 첫 번쨰 게시물인 경우
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return -1; // 데이터 베이스 오류
	}
    	
	public int write(String bbsTitle, String userID, String bbsContent) {
    	String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";
    	
    	try {
    		PreparedStatement psmt = conn.prepareStatement(SQL);
    		psmt.setInt(1, getNext());
    		psmt.setString(2, bbsTitle);
    		psmt.setString(3, userID);
    		psmt.setString(4, getDate());
    		psmt.setString(5, bbsContent);
    		psmt.setInt(6, 1);
    		
   			return psmt.executeUpdate();
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    	return -1; // 데이터 베이스 오류
	}
	
    
}
