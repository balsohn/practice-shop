<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>         
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역</title>
 <style>
   main {
     width:800px;
     margin:auto;
     font-family: 'GmarketSansMedium';
   }
   
   h3{ margin-top: 30px;}
   main table {
		width:100%;
      border-spacing:0px;
      margin-top:30px;
   }
   main table tr:first-child td {
      border-top:2px solid purple;
   }
   main table tr:last-child td {
      border-bottom:1px solid purple;
   }
   main table td {
      font-size:14px;
      height:40px;
      padding-left:10px;
      border-bottom:1px solid purple;
   }
   main #btn {
      font-size:11px;
      background:purple;
      color:white;
      border:1px solid purple;
      padding:10px 20px;
   }
   </style>
</head>
<body>
	<main>
		<c:set var="prevDate" value="${map[0].writeday }"/>
		<c:set var="chong" value="0"/>

		<c:forEach var="map" items="${mapAll}">
			<c:if test="${prevDate != map.writeday}">
				<!-- 이전 날짜의 테이블 종료 -->
				<c:if test="${not empty prevDate}">
					<tr>
						<td colspan="5" style="text-align:right;">
							<strong>사용한 적립금 : ${map.useJuk }  </strong>
							<strong>총결제 금액: ${chong }</strong>
						</td>
					</tr>
					</table>
				</c:if>

				<!-- 새로운 날짜의 테이블 시작 -->
				<h3>${map.writeday}</h3>
				<table>
					<tr>
						<td>상 태</td>
						<td>주문상품</td>
						<td>결제금액</td>
						<td>수 량</td>
						<td>비 고</td>
					</tr>

				<!-- 총결제 금액 초기화 -->
				<c:set var="chong" value="0"/>
				<c:set var="prevDate" value="${map.writeday}"/>
			</c:if>

			<!-- 주문 항목 출력 -->
			<tr>
				<td>${map.stat}</td>
				<td align="left" valign="baseline">
					<img src="../resources/pageimg/${map.pimg}" width="80" height="80">
					${map.title}
				</td>
				<td>${map.price}</td>
				<td>${map.su}</td>
				<td>
				<c:if test="${map.state==0}">
					<input type="button" value="취소신청" id="btn" onclick="location='chgState?state=4&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3}">
					<input type="button" value="반품신청" id="btn" onclick="location='chgState?state=5&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3}">
					<input type="button" value="교환신청" id="btn" onclick="location='chgState?state=7&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3 && map.isReview==0}">
					<input type="button" value="리뷰쓰기" id="btn" onclick="location='reviewWrite?pcode=${map.pcode}&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3 && map.isReview==1}">
				<input type="button" value="리뷰보기" id="btn">
				</c:if>
				<c:if test="${map.state==5}"> 
					<input type="button" value="반품취소" id="btn" onclick="location='chgState?state=3&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==7}"> 
					<input type="button" value="교환취소" id="btn" onclick="location='chgState?state=3&id=${map.id}'">
				</c:if>  
				</td>
			</tr>

			<!-- 총결제 금액 업데이트 -->
			<c:set var="chong" value="${map.chongPrice}"/>
		</c:forEach>

		<!-- 마지막 테이블의 총결제 금액 출력 -->
		<c:if test="${not empty prevDate}">
			<tr>
				<td colspan="5" style="text-align:right;">
					<strong>사용한 적립금 : ${map.useJuk }  </strong>
					<strong>총결제 금액: ${chong}</strong>
				</td>
			</tr>
			</table>
		</c:if>
	</main>
</body>
</html>
