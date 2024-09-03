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
		
		</section>
		<section id="price">
		
		</section>
		<section id="sudan">
		
		</section>
	</main>
</body>
</html>