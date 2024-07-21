<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
// 요청의 인코딩을 UTF-8로 설정
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>JSP 게시판 웹사이트</title>
<!-- Bootstrap CSS 3.3.7 -->
<link href="css/bootstrap.css" rel="stylesheet">
</head>
<body>
	<%
		// PrintWriter 객체 생성, 클라이언트에게 HTML에 스크립트 출력 준비.
		PrintWriter script = response.getWriter();
	
		// 로그인 확인을 위해 세션에서 userID를 가져옴
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	
		// 이미 로그인된 상태인 경우
		if (userID != null) {
			script.println("<script>");
			script.println("alert('이미 로그인 되어있습니다.')");
			script.println("location.href='main.jsp'"); // 로그인된 사용자를 메인 페이지로 리디렉션
			script.println("</script>");
		}
	
		// UserDAO 객체를 생성하고, 로그인 메서드 호출.
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
	
		// 로그인 처리
		if (result == 1) {
			// 로그인 성공 시, 세션에 사용자 ID를 저장하고 메인 페이지로 리디렉션합니다.
			session.setAttribute("userID", user.getUserID());
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else if (result == 0) {
			// 비밀번호가 틀린 경우, 경고 메시지를 출력하고 이전 페이지로 돌아갑니다.
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == -1) {
			// 존재하지 않는 아이디인 경우, 경고 메시지를 출력하고 이전 페이지로 돌아갑니다.
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == -2) {
			// 데이터베이스 오류가 발생한 경우, 경고 메시지를 출력하고 이전 페이지로 돌아갑니다.
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>
