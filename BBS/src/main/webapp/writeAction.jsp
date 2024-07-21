<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

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

	// 비 로그인 
	if (userID == null) {
		script.println("<script>");
		script.println("alert('로그인 하세요.')");
		script.println("location.href='login.jsp'"); // 로그인된 사용자를 메인 페이지로 리디렉션
		script.println("</script>");
	} else {

		// 미입력 처리
		if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {

			// 입력이 모두 된 경우에만 데이터베이스 작업을 수행
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());

			if (result == -1) {
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다..')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				script.println("<script>");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}

	}
	%>
</body>
</html>