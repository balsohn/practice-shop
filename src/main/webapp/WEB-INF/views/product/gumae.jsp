<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function juso_search() {  // 우편번호 버튼 클릭시 호출 함수명
		open("jusoWrite","","width=450,height=500");
	}
	
	function juso_select() {
		open("jusoList","","width=450,height=500");
	}
	
	
	
</script> 
<style>
	main {margin: 30px auto; width:1100px;}
	h3 {background: black; color:white; padding:15px 20px; width:700px;
		border-radius: 5px;}
	section {margin: 30px auto; }
	input[type='button'] {
		border: none; 
		background: #ccc; 
		padding: 5px; 
		margin-left:3px;
		border-radius: 5px;
	}
</style>
</head>
<body>	<!-- product/gumae.jsp -->
	<main>
		<section id="member"> <!-- 구매자정보 -->
			<table width="1100" align="center">
				<h3 align="left"> 구매자 정보 </h3>
				<tr>
					<td>이 름 </td>
					<td>${mdto.name }</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>${mdto.email }</td>
				</tr>
				<tr>
					<td>전화번호 </td>
					<td>
						<input type="text" name="phone" value="${mdto.phone }">
						<input type="button" value="수정">
					</td>
				</tr>
			</table>
		</section>
		<section id="baesong">
			<table width="1100" align="center">
				<h3 align="left">
					배송지 정보
					<c:if test="${bdto!=null }">
					<input type="button" value="배송지 변경" onclick="juso_select()">
					</c:if>
					<c:if test="${bdto==null }">
					<input type="button" value="배송지 등록" id="fbtn" onclick="juso_search()">
					</c:if>
				</h3>
				<tr>
					<td>이름 </td>
					<td> <span id="bname"> ${bdto.name} </span></td>
				</tr>
				<tr>
					<td>배송주소</td>
					<td> <span id="bjuso"> ${bdto.juso } ${bdto.jusoEtc } </span></td>
				</tr>
				<tr>
					<td>연락처</td>
					<td><span id="bphone">${bdto.phone }</span></td>
				</tr>
				<tr>
					<td> 배송요청사항 </td>
					<td><span id="breq"> ${bdto.breq}</span></td>
				</tr>
			</table>
		</section>
		<section id="product">
			<table width="700" align="center">
				<h3>구매 상품 정보</h3>
				<c:forEach items="${plist }" var="pdto">
				<tr>
					<td colspan="2"style="background:#ccc;">${pdto.baeEx}</td>
				</tr>
				<tr>
					<td width="500">${pdto.title }</td>
					<td>
						수량 ${pdto.su}개 /
						<c:if test="${pdto.baeprice==0}">
						무료배송
						</c:if>  
						<c:if test="${pdto.baeprice!=0}">
						<fmt:formatNumber value="${pdto.baeprice}" type="number"/> 원
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</table>
		</section>
		<section id="price">
			<table width="700">
				<h3>결제 정보</h3>
				<tr>
					<td>총 상품가격 </td>
					<td><fmt:formatNumber value="${halinPrice }" type="number"/> 원</td>
				</tr>
				<tr>
					<td> 배송비 </td>
					<td>
					<c:if test="${baePrice==0}">
					무료배송
					</c:if>  
					<c:if test="${baePrice!=0}">
					<fmt:formatNumber value="${baePrice}" type="number"/> 원
					</c:if>
					</td>
				</tr>
				<tr>
					<td>적립 예정 포인트</td>
					<td> <fmt:formatNumber value="${jukPrice }" type="number" /> 포인트 </td>
				</tr>
				<tr>	
					<td> 사용가능한 포인트 </td>
					<td>
						<input type="text" name="useJuk" value="0"> / 
						<fmt:formatNumber value='${juk }' type='number'/> 포인트 
					</td>
				</tr>
			</table>
		</section>
		<section id="sudan">
			<h3>결제수단</h3>
			<div> 
				<label><input type="radio" name="sudan" class="sudan"> 신용 / 체크카드 </label>
				<div class="sub">
					<select name="card">
						<option> 선택 </option>
						<option> 신한카드 </option>
						<option> 농협카드 </option>
						<option> 우리카드 </option>
						<option> 국민카드 </option>
						<option> 하나카드 </option>
					</select>
					<select name="halbu">
						<option> 일시불 </option>
						<option> 2개월 </option>
						<option> 3개월 </option>
						<option> 6개월 </option>
						<option> 12개월 </option>
					</select>
				</div>
			</div>
			<div> 
				<label><input type="radio" name="sudan" class="sudan"> 쿠페이머니 </label>
				<div class="sub">
					
				</div>
			</div>
			<div>
				<div>다른결제 수단</div>
				<div> 
					<label><input type="radio" name="sudan" class="sudan"> 계좌이체 </label> 
					<div class="sub">
						<select name="bank">
							<option> 선택 </option>
							<option> 신한은행 </option>
							<option> 농협은행 </option>
							<option> 우리은행 </option>
							<option> 국민은행 </option>
							<option> 하나은행 </option>
						</select>
					</div>
				</div>
				<div> 
					<label><input type="radio" name="sudan" class="sudan"> 법인카드 </label>
					<div class="sub">
						<select name="lcard">
							<option> 선택 </option>
							<option> 신한카드 </option>
							<option> 농협카드 </option>
							<option> 우리카드 </option>
							<option> 국민카드 </option>
							<option> 하나카드 </option>
						</select>
					</div> 
				</div>
				<div> 
					<label><input type="radio" name="sudan" class="sudan"> 휴대폰 </label> 
					<div class="sub">
						<select name="tong">
							<option> 선택 </option>
							<option> SKT </option>
							<option> KT </option>
							<option> LG </option>
							<option> 별정통신 </option>
						</select>
					</div> 
				</div>
				<div> 
					<label><input type="radio" name="sudan" class="sudan"> 무통장입금 </label> 
					<div class="sub">
						<select name="nbank">
							<option> 선택 </option>
							<option> 신한은행 </option>
							<option> 농협은행 </option>
							<option> 우리은행 </option>
							<option> 국민은행 </option>
							<option> 하나은행 </option>
						</select>
					</div> 
				</div>
			</div>
		</section>
	</main>
</body>
</html>