<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>

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
			String userID = null;
			if(session.getAttribute("userID") != null){
				userID = (String) session.getAttribute("userID");
			}
			
			int bbsID = 0;
			if(request.getParameter("bbsID") != null){
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
			}
			
			if (bbsID == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다..')");
				script.println("location.href='bbs.jsp'"); // 로그인된 사용자를 메인 페이지로 리디렉션
				script.println("</script>");
			}
			
			//BbsDAO bDAO = new BbsDAO();
			//bDAO.getBbs(bbsID);
			
			Bbs bbs = new BbsDAO().getBbs(bbsID);
			
		%>

    <nav class="navbar navbar-default">
        <!-- 브랜드와 토글 버튼을 모바일 화면에 맞게 그룹화 -->
        <div class="navbar-header">
            <!-- 네비게이션 토글 버튼 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <!-- 브랜드 링크 -->
            <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
        </div>
        <!-- 네비게이션 링크, 폼, 기타 콘텐츠를 그룹화 -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <!-- 메인 링크 -->
                <li><a href="main.jsp">메인</a></li>
                <!-- 게시판 링크 -->
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>

						<%
							if(userID == null){
						%>
		            <ul class="nav navbar-nav navbar-right">
		                <!-- 접속하기 드롭다운 버튼 -->
		                <li class="dropdown">
		                    <a href="#" class="dropdown-toggle"
		                        data-toggle="dropdown" role="button" aria-haspopup="true"
		                        aria-expanded="false">접속하기<span class="caret"></span></a>
		                    <!-- 드롭다운 메뉴 -->
		                    <ul class="dropdown-menu">
		                        <li><a href="login.jsp">로그인</a></li>
		                        <li><a href="join.jsp">회원가입</a></li>
		                    </ul>
		                </li>
		            </ul>
            <%
            	}else{
            %>
		            <ul class="nav navbar-nav navbar-right">
		                <!-- 접속하기 드롭다운 버튼 -->
		                <li class="dropdown">
		                    <a href="#" class="dropdown-toggle"
		                        data-toggle="dropdown" role="button" aria-haspopup="true"
		                        aria-expanded="false">회원관리<span class="caret"></span></a>
		                    <!-- 드롭다운 메뉴 -->
		                    <ul class="dropdown-menu">
		                        <li><a href="logoutAction.jsp">로그아웃</a></li>
		                    </ul>
		                </li>
		            </ul>
         		<%		
            	}
            %>
        </div>
        <!-- /.navbar-collapse -->
    </nav>


		<div class="container">
			<div class="row">
			
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddd">
						<thead>
							<tr>
								<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 20%;">글 제목</td>
								<td colspan="2"><%=bbs.getBbsTitle()
																	.replace(" ", "%nbsp")
																	.replace("\t", "%nbsp%nbsp")
																	.replace("\n", "<br>")
																	.replace("&", "&amp;")
									                .replace("<", "&lt;")
									                .replace(">", "&gt;")
									                .replace("\"", "&quot;")
									                .replace("'", "&#39;")%></td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="2"><%=bbs.getUserID() %></td>
							</tr>
							<tr>
								<td>작성일자</td>
								<td colspan="2"><%=bbs.getBbsDate().substring(0,11)
								+ bbs.getBbsDate().substring(11,13) + "시"
								+ bbs.getBbsDate().substring(14,16) + "분" %></td>
							</tr>
							<tr>
								<td>내용</td>
								<!-- min-height: 200px 적용 안됨 -->
								<td colspan="2" style="height: 200px; text-align: left;"><%=bbs.getBbsContent()
								.replaceAll(" ", "%nbsp").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
							</tr>
						</tbody>
					</table>
					<a href="bbs.jsp" class="btn btn-primary">목록</a>
					<%
						if(userID != null && userID.equals(bbs.getUserID())){
					%>
							<a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
							<a onclick="return confirm('정말 삭제 하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">삭제</a>
					<%
						}
					%>
			</div>
		</div>

    
    <!-- jQuery 3.1.1 -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <!-- Bootstrap JS 3.3.7 -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>