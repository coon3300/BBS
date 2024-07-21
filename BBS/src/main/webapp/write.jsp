<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>JSP 게시판 웹사이트</title>
<!-- Bootstrap CSS 3.3.7 -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/custom.css" rel="stylesheet">
</head>
<body>
		<%
			String userID = null;
			if(session.getAttribute("userID") != null){
				userID = (String) session.getAttribute("userID");
			}
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
				<form method="post" action="writeAction.jsp" >
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddd">
						<thead>
							<tr>
								<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
							</tr>
							<tr>
								<td><textarea type="text" class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350px"></textarea></td>
							</tr>
							
						</tbody>
					</table>
					<input type="submit" class="btn btn-primary pull-right" value="글쓰기">	
				</form>
			</div>
		</div>

    
    <!-- jQuery 3.1.1 -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <!-- Bootstrap JS 3.3.7 -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>