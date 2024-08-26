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
	main {width:1000px; margin: auto; margin-top: 20px;}
	main #first { width: 100%; height:500px; display: flex;}
	main #first #left {border:1px solid black; height: 100%; width: 50%; border-radius: 5px;}
	main #first #left img {margin: auto; height:100%;}
	main #first #right {height: 100%; width:40%; margin-left:20px;}
</style>
</head>
<body>

	<main>
		<section id="first">
			<div id="left"> 
				<img src="../resources/pageimg/${pdto.pimg}">
			</div>
			<div id="right">
				<div> ${pdto.title}</div>
				<div>
					<c:forEach begin="1" end="5">
					<img src="../resources/uploads/star1.png" width="10">
					</c:forEach>
					???개 상품평
				</div>
				<c:if test="${pdto.halin!=0}">
				<div> ${pdto.halin}% <fmt:formatNumber value="${pdto.price}" type="number"/> 원</div>
				</c:if>
				<div><fmt:formatNumber value="${pdto.halinPrice}" type="number"/> 원</div>
				<c:if test="${pdto.baeprice==0}">
				<div>무료배송</div>
				</c:if>
				<c:if test="${pdto.baeprice!=0}">
				<div><fmt:formatNumber value="${pdto.baeprice}" type="number"/> 원</div>
				</c:if>
			</div>
		</section>
		<section id="second"></section>
		<section id="third"></section>
		<section id="fourth"></section>
		<section id="fifth"></section>
		<section id="sixth"></section>
	</main>
</body>
</html>