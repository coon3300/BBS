package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
//	private PreparedStatement psmt;
	private ResultSet rs;

	public BbsDAO() {
		try {
			// mysql
//			Class.forName("com.mysql.cj.jdbc.Driver"); //  Connector/J 8.x 버전 이상
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

//	public String getDate() {
//    	String SQL = "SELECT NOW()";
//    	
//    	try {
//    		
//    		PreparedStatement psmt = conn.prepareStatement(SQL);
//    		rs = psmt.executeQuery();
//    		
//    		if(rs.next()) {
//    			return rs.getString(1);
//    		}
//    		
//    	}catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	return "";
//	}

    public String getDate() {
        String SQL = "SELECT NOW()";
        try (PreparedStatement psmt = conn.prepareStatement(SQL);
             ResultSet rs = psmt.executeQuery()) {

            if (rs.next()) {
                return rs.getString(1); // 결과에서 첫 번째 값을 반환
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return ""; // 데이터베이스 오류 시 빈 문자열 반환
    }	
	
    	
//	public int write(String bbsTitle, String userID, String bbsContent) {
//    	String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";
//    	
//    	try {
//    		PreparedStatement psmt = conn.prepareStatement(SQL);
//    		psmt.setInt(1, getNext());
//    		psmt.setString(2, bbsTitle);
//    		psmt.setString(3, userID);
//    		psmt.setString(4, getDate());
//    		psmt.setString(5, bbsContent);
//    		psmt.setInt(6, 1);
//    		
//   			return psmt.executeUpdate();
//    		
//    	}catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return -1;
//	}
	
    // 게시물을 작성하는 메소드
    public int write(String bbsTitle, String userID, String bbsContent) {
        String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";
        try (PreparedStatement psmt = conn.prepareStatement(SQL)) {
            psmt.setInt(1, getNext());
            psmt.setString(2, bbsTitle);
            psmt.setString(3, userID);
            psmt.setString(4, getDate());
            psmt.setString(5, bbsContent);
            psmt.setInt(6, 1);

            return psmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류 시 -1 반환
    }	
	
//	public int getNext() {
//		
//		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
//		
//		try {
//			PreparedStatement psmt = conn.prepareStatement(SQL);
//			rs = psmt.executeQuery();
//			
//			if(rs.next()) {
//				return rs.getInt(1) + 1; // 가장 큰 bbsID + 1 리턴
//			}
//			
//			return 1; // 첫 번쨰 게시물인 경우 : 1 리턴
//			
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		return -1; // DB 오류
//	}

    // 다음 게시물 ID를 가져오는 메소드
    public int getNext() {
        String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
        try (PreparedStatement psmt = conn.prepareStatement(SQL);
             ResultSet rs = psmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1) + 1; // 가장 큰 bbsID에 1을 더한 값 반환
            }

            return 1; // 게시물이 없는 경우 첫 번째 게시물 ID로 1 반환

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류 시 -1 반환
    }	
	
	
//	public ArrayList<Bbs> getList(int pageNumber){
//    	String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
//    	ArrayList<Bbs> list = new ArrayList<>();
//    	try {
//    		PreparedStatement psmt = conn.prepareStatement(SQL);
//    		psmt.setInt(1, getNext() - (pageNumber - 1) * 10);
//    		rs = psmt.executeQuery();
//    		while(rs.next()) {
//    			Bbs bbs = new Bbs();
//                bbs.setBbsID(rs.getInt("bbsID"));
//                bbs.setBbsTitle(rs.getString("bbsTitle"));
//                bbs.setUserID(rs.getString("userID"));
//                bbs.setBbsDate(rs.getString("bbsDate"));
//                bbs.setBbsContent(rs.getString("bbsContent"));
//                bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
//    			list.add(bbs);
//    		}
//    		
//    	}catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return list;
//	}
	
	
    // 특정 페이지의 게시물 목록을 가져오는 메소드
    public ArrayList<Bbs> getList(int pageNumber) {
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
        ArrayList<Bbs> list = new ArrayList<>();
        try (PreparedStatement psmt = conn.prepareStatement(SQL)) {
            psmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            try (ResultSet rs = psmt.executeQuery()) {
                while (rs.next()) {
                    Bbs bbs = new Bbs();
                    bbs.setBbsID(rs.getInt("bbsID"));
                    bbs.setBbsTitle(rs.getString("bbsTitle"));
                    bbs.setUserID(rs.getString("userID"));
                    bbs.setBbsDate(rs.getString("bbsDate"));
                    bbs.setBbsContent(rs.getString("bbsContent"));
                    bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
                    list.add(bbs); // 게시물 객체를 리스트에 추가
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; // 게시물 리스트 반환
    }
    
	
//	public boolean nextPage(int pageNumber){
//		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
//		try {
//			PreparedStatement psmt = conn.prepareStatement(SQL);
//			psmt.setInt(1, getNext() - (pageNumber - 1) * 10);
//    		rs = psmt.executeQuery();
//			while(rs.next()) {
//				return true;
//			}
//			
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return false;
//	}

    // 다음 페이지가 있는지 확인하는 메소드
    public boolean nextPage(int pageNumber) {
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
        try (PreparedStatement psmt = conn.prepareStatement(SQL)) {
            psmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            try (ResultSet rs = psmt.executeQuery()) {
                if (rs.next()) {
                    return true; // 다음 페이지가 존재하면 true 반환
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // 다음 페이지가 존재하지 않으면 false 반환
    }    
    
}
