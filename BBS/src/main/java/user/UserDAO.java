package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private Connection conn;
    private PreparedStatement psmt;
    private ResultSet rs;

    public UserDAO() {
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
            // 간단한 쿼리 테스트
            testConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void testConnection() {
        String testSQL = "SELECT 1 FROM DUAL";
        try {
            psmt = conn.prepareStatement(testSQL);
            rs = psmt.executeQuery();
            if (rs.next()) {
                System.out.println("쿼리 테스트 성공");
            } else {
                System.out.println("쿼리 테스트 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psmt != null) psmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM user WHERE userID = ?";
//        // 오라클
//        String SQL = "SELECT userPassword FROM tbl_user WHERE userID = ?";
        try {
            psmt = conn.prepareStatement(SQL);
            psmt.setString(1, userID);
            rs = psmt.executeQuery();

            if (rs.next()) {  // 커서를 첫 번째 행으로 이동
                String getPassword = rs.getString("userPassword");
                System.out.println("비밀번호 : " + getPassword);
                if (getPassword.equals(userPassword)) {
                    System.out.println("로그인 성공.");
                    return 1; // 로그인 성공
                } else {
                    System.out.println("비밀번호 불일치.");
                    return 0; // 비밀번호 불일치
                }
            } else {
                System.out.println("ID를 찾을 수 없음.");
            }
            return -1; // 아이디가 없음
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 정리
            try {
                if (rs != null) rs.close();
                if (psmt != null) psmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return -2; // 데이터베이스 오류
    }
    
    public int join(User user) {
    	String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
    	
    	try {
    		psmt = conn.prepareStatement(SQL);
    		psmt.setString(1, user.getUserID());
    		psmt.setString(2, user.getUserPassword());
    		psmt.setString(3, user.getUserName());
    		psmt.setString(4, user.getUserGender());
    		psmt.setString(5, user.getUserEmail());
    		return psmt.executeUpdate();
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    	return -1; // 데이터 베이스 오류
    }
    
}
