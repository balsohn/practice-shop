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
	@font-face {
		font-family: 'GmarketSansMedium';
		src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		font-weight: normal;
		font-style: normal;
	}
	
	.baeJuso {
		width:420px;
		height:auto;
		margin:auto;
		border:1px solid purple;
		margin-top:5px;
		padding:4px;
		font-family: 'GmarketSansMedium';
	}
	.baeJuso > div {
		margin-top:4px;
	}
	#btn {
		width:430px;
		height:36px;
		background:purple;
		border:1px solid purple;
		color:white;
		font-family: 'GmarketSansMedium';
		
	}
	#submit {
		text-align:center;
		margin-top:5px;
	}
	#gibon {
		border:1px solid purple;
		padding:1px 4px;
		font-size:12px;
		border-radius:10px;
	}
</style>
<script>
	function transJuso(n) {
		opener.document.getElementById("bname").innerText=document.getElementsByClassName("bname")[n].innerText;
		opener.document.getElementById("bjuso").innerText=document.getElementsByClassName("bjuso")[n].innerText;
		opener.document.getElementById("bphone").innerText=document.getElementsByClassName("bphone")[n].innerText;
		opener.document.getElementById("breq").innerText=document.getElementsByClassName("breq")[n].innerText;
		
		close();
	}
</script>
</head>
<body>
	<c:forEach var="bdto" items="${bdto }" varStatus="sts">
	<div class="baeJuso">
		<div class="bname">${bdto.name }</div>
		<c:if test="${bdto.gibon==1 }">
		<div> <span id="gibon">기본 배송지</span> </div>
		</c:if>
		<div class="bjuso">${bdto.juso } ${bdto.jusoEtc }</div>
		<div class="bphone">${bdto.phone }</div>
		<div style="display:flex; justify-content: space-between;">
			<div class="breq">${bdto.breq }</div>
			<div>
				<input type="button" value="수정" onclick="location='jusoUpdate?id=${bdto.id}'">
				<input type="button" value="삭제" onclick="location='jusoDel?id=${bdto.id}'">
				<input type="button" value="선택" onclick="transJuso(${sts.index})">
			</div>
		</div>
	</div>
	</c:forEach>
	<div> <input type="button" id="btn" value="배송지 추가" onclick="location='jusoWrite?tt=1'"></div>
</body>
</html>