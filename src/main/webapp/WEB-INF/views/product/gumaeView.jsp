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
	main {width:800px; margin:auto;}
	h2 {margin-top:30px;}
	table {margin-top:20px; width:100%;}
	
</style>
</head>
<body>
	<main>
		<div id="product">
			<h2>상품정보</h2>
			<table>
				<c:forEach var="map" items="${map}">
				<tr>
					<td	> <img src="../resources/pageimg/${map.pimg}" width="90" height="90"></td>
					<td> ${map.title} </td>
					<td> <fmt:formatNumber value="${map.halinPrice }" type="number"/> 원</td>
					<td> ${map.baeEx } </td>
					<td> 수량 : ${map.su }개 </td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<div id="baesong">
			<h2>배송지 정보</h2>
			<table>
				<tr>
					<td> 받는사람 </td>
					<td> ${map[0].name }</td>
				</tr>
				<tr>
					<td> 배송 주소 </td>
					<td> ${map[0].juso } </td>
				</tr>
				<tr>
					<td>요청 사항</td>
					<td>${map[0].breq }</td>
				</tr>
			</table>
		</div>
		<div id="pay">
			<h2>결제 정보</h2>
			<table>
				<tr>	
					<td> 주문금액 </td>
					<td> <fmt:formatNumber value="${chong }" type="number"/> 원</td>
				</tr>
				<tr>	
					<td>배송비 </td>
					<td> <fmt:formatNumber value="${baesong }" type="number"/> 원</td>
				</tr>
				<tr>
					<td> 사용 적립금 </td>
					<td> <fmt:formatNumber value="${map[0].useJuk }" type="number" /> 포인트 </td>
				</tr>
				<tr>
					<td> 총 결제금액 </td>
					<td> <fmt:formatNumber value="${chong+baesong-map[0].useJuk}" type="number"/> 원 </td>
				</tr>
			</table>
		</div>
	</main>
</body>
</html>