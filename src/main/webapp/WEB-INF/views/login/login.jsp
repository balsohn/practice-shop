<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section { width:400px; margin:auto;}
	#txt {width: 100%; padding: 5px; margin-top:10px;}
	#txt2 {width: 31%; padding:5px; margin-top:10px;}
	#chkpwd1, #chkpwd2 {font-size:12px; color:red;}
	#btn {border:none; width:120px; height: 30px; background: purple; color: white; margin-top:20px;}
</style>
</head>
<body>
	<section>
	<form method="post" action="loginOk" name="mform">
		<div> <input type="text" name="userid" placeholder="아이디" id="txt"></div>
		<div> <input type="password" name="pwd" placeholder="비밀번호" id="txt"> </div>
		<c:if test="${param.err==1}">
		<div style="font-size:13px;color:red;">아이디 또는 비밀번호를 확인해주세요.</div>
		</c:if>
		<div align="center"> <input type="submit" value="로그인" id="btn"> </div>
	</form>
	</section>
</body>  
</html>