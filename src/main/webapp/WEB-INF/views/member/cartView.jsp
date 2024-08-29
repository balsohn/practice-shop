<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	main {display:grid; grid-template-cloumns: 5fr 3fr; width:800px;}
	.item-container {display: grid; grid-template-columns:9fr 1fr; border:1px solid black;}
</style>
</head>
<body>
	<main>
	<div class="item-container">
		<c:forEach var="map" items="${pMapAll}">
		<div> <img src="../resources/pageimg/${map.pimg}"> </div>
		<div>
			<div>asdf</div>
			<div>asfd</div>
			<div>asdf</div>
		</div>
		</c:forEach>
	</div>
	<div>
		<div>asfdasdfaf</div>
	</div>
	</main>
</body>
</html>
