<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
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
	
		// 미입력 처리
	if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
			|| user.getUserGender() == null || user.getUserEmail() == null) {
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {

		// 입력이 모두 된 경우에만 데이터베이스 작업을 수행
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);

		if (result == -1) {
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			// 회원가입 성공 시 세션 부여
			session.setAttribute("userID", user.getUserID());
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}

	}
	%>
</body>
</html>