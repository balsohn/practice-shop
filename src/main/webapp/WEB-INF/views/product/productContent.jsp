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
	main #first { width: 100%; height:500px; display: flex; justify-content: space-around; }
	main #first #left {height: 100%; width: 50%; border-radius: 5px; margin-top:30px;}
	main #first #left img {margin: auto; height:100%; width:100%; object-fit: contain;}
	main #first #right {height: 100%; width:40%; margin-left:20px; padding-top:30px; }
	#con-title {display:flex; justify-content: space-between; align-items: center;}
	#con-title img {width:30px; height: 30px;}
	#ju {display:flex; align-items: center; gap: 10px; margin-top:20px;}
	#su {width: 50px; outline: none;}
	#btn1 {height: 33px; width:50%; border:1px solid purple; background:white; color:purple; border-radius: 5px;}
	#btn2 {height: 33px; width:50%; border:none; background:purple; color:white; border-radius: 5px;}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script>
	$(function() {
		$('#su').spinner({
			min:1,
			max:10,
			spin:function(e,ui) {
				
			}
		});
		
		var pcode="${pdto.pcode}";
		
		var xhr=new XMLHttpRequest();
		xhr.onload=function() {
			if(xhr.responseText=='1'){
				document.getElementById("jjim").src="../resources/uploads/jjim2.png";
			} else {
				document.getElementById("jjim").src="../resources/uploads/jjim1.png";
			}
		}
		xhr.open("get","jjimChk?pcode="+pcode);
		xhr.send();

	})

	function jjimOk(pcode) {

	    var chk = new XMLHttpRequest();
	    chk.onload = function() {
	        if (chk.responseText == 0) {
	            location = "../login/login";
	        } else {
	        	var ele = document.getElementById("jjim");
	        	if (ele.src.includes("jjim1.png")) {
	    	        ele.src = "../resources/uploads/jjim2.png";
	    	    } else {
	    	        ele.src = "../resources/uploads/jjim1.png";
	    	    }
	        }
	    };
	    
	    chk.open("GET", "jjimOk?pcode=" + pcode);
	    chk.send();
	    
	    
	}

</script>
</head>
<body>

	<main>
		<section id="first">
			<div id="left"> 
				<img src="../resources/pageimg/${pdto.pimg}">
			</div>
			<div id="right">
				<div id="con-title"> 
					<h1>${pdto.title}</h1>
					<a href="javascript:jjimOk('${pdto.pcode}')"><img src="../resources/uploads/jjim1.png" alt="사진" id="jjim"></a>
				</div>
				<div>
					<c:forEach begin="1" end="5">
					<img src="../resources/uploads/star1.png" width="10">
					</c:forEach>
					${pdto.review}개 상품평
				</div>
				<c:if test="${pdto.halin!=0}">
				<div> ${pdto.halin}% SALE</div><div> 원가 <s><fmt:formatNumber value="${pdto.price}" type="number"/></s> 원</div>
				<div><span  style="color:red;">할인가 </span><fmt:formatNumber value="${pdto.halinPrice}" type="number"/> 원</div>
				</c:if>
				<c:if test="${pdto.halin==0}">
				<div>할인가 <fmt:formatNumber value="${pdto.halinPrice}" type="number"/> 원</div>
				</c:if>
				<c:if test="${pdto.baeprice==0}">
				<div>무료배송</div>
				</c:if>
				<c:if test="${pdto.baeprice!=0}">
				<div>배송비 <fmt:formatNumber value="${pdto.baeprice}" type="number"/> 원</div>
				</c:if>
				${pdto.baeEx }
				<div id="ju">
					<input type="text" value="1" readonly id="su">
					<button onclick="loaction.href:'asdfasdf'" id="btn1">장바구니</button>
					<button onclick="loaction:''" id="btn2">구매하기</button>
				</div>
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