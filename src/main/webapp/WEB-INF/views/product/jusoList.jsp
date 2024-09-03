<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach var="bdto" items="${bdto }">
	<div class="baeJuso">
		<div>${bdto.name }</div>
		<div>${bdto.juso } ${bdto.jusoEtc }</div>
		<div>${bdto.phone }</div>
		<div>${bdto.breq }</div>
	</div>
	</c:forEach>
	<div> <input type="button" value="배송지 추가" onclick="location='jusoWrite?tt=1'"></div>
</body>
</html>