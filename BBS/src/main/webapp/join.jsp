<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <li><a href="bbs.jsp">게시판</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <!-- 접속하기 드롭다운 버튼 -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle"
                        data-toggle="dropdown" role="button" aria-haspopup="true"
                        aria-expanded="false">접속하기<span class="caret"></span></a>
                    <!-- 드롭다운 메뉴 -->
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li class="active"><a href="join.jsp">회원가입</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </nav>
    
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <!-- 로그인 폼을 포함한 점보트론 -->
            <div class="jumbotron" style="padding-top: 20px">
                <form method="post" action="joinAction.jsp">
                    <h3 style="text-align:center;">회원가입 화면</h3>
                    <div class="form-group">
                        <!-- 아이디 입력 필드 -->
                        <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
                    </div>
                    <div class="form-group">
                        <!-- 비밀번호 입력 필드 -->
                        <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
                    </div>
                    <div class="form-group">
                        <!-- 이름 입력 필드 -->
                        <input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
                    </div>
                    <div class="form-group" style="text-align: center;">
                        <!-- 성별 입력 필드 -->
                        <div class="btn-group" data-toggle="buttons">
                        	<label class="btn btn-primary active">
                        		<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
                        	</label>
                        	<label class="btn btn-primary">
                        		<input type="radio" name="userGender" autocomplete="off" value="여자">여자
                        	</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <!-- 이메일 입력 필드 -->
                        <input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
                    </div>                    
                    <!-- 로그인 버튼 -->
                    <input type="submit" class="btn btn-primary form-control" value="회원가입">
                </form>
            </div>
        </div>
    </div>

    <!-- jQuery 3.1.1 -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <!-- Bootstrap JS 3.3.7 -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>