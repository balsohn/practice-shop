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
	#right-first {padding-bottom: 10px; border-bottom: 2px solid purple;}
	#con-title {display:flex; justify-content: space-between; align-items: center;}
	#con-title img {width:30px; height: 30px; margin-right: 10px;}
/*	#ju {display:flex; align-items: center; gap: 10px; margin-top:20px;}
	#su {width: 50px; outline: none;}
	#btn1 {height: 33px; width:100%; border:1px solid purple; background:white; color:purple; border-radius: 5px; position: relative;}
	#btn2 {height: 33px; width:35%; border:none; background:purple; color:white; border-radius: 5px;}*/
	#ju {display: grid; grid-template-columns:0.5fr 1fr 1fr; gap:10px;}
	#su {width: 50px; outline: none;}
	#btn1 {height:33px;width:100%; border:1px solid purple; background:white; color:purple; border-radius: 5px; position: relative;}
	#btn2 {height:33px;width:100%; border:1px solid purple; background:purple; color:white; border-radius: 5px;}
	#ju1 {position: relative;}
	#cartview{
		text-align: center;
		border: 1px solid black;
		width: 200px;
		position: absolute;
		left: -50%;
		transform: translate(22%, -92px);
		background: white;
		visibility: hidden;
	}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script>
	$(function() {
		var price=${pdto.price};
		var halin=${pdto.halin};
		var juk=${pdto.halin};
		
		$('#su').spinner({
			min:1,
			max:10,
			spin:function(e,ui) {
				var su2=ui.value;
				var jsprice=price*su2;
				var jshalinprice=(price-(price*halin/100))*su2;
				var jsjukprice=((price-(price*halin/100))*(juk/100))*su2;
				
				$('#input1').text(jsprice);
				$('#input2').text(jshalinprice);
				$('#input3').text(jsjukprice);
				
				/*
				document.getElementById("input1").innerText=jsprice;
				document.getElementById("input2").innerText=jshalinprice;
				document.getElementById("input3").innerText=jsjukprice;
				*/
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
	
	
	function addCart() {
		var pcode='${pdto.pcode}';
		var su=document.getElementById("su").value;
		
		var chk=new XMLHttpRequest();
		chk.onload=function() {
			if(chk.responseText=="-1") {
				alert("오류");
			} else {
				document.getElementById("cartview").style.visibility="visible";
				setTimeout(function(){
					document.getElementById("cartview").style.visibility="hidden";
				},3000)
				
				document.getElementById("cartNum").innerText=chk.responseText;
			}
		}
		chk.open("get","addCart?pcode="+pcode+"&su="+su);
		chk.send();
	}

</script>
</head>
<body>
	<main>
		<form method="post" action="gumae">
		<input type="hidden" name="pcode" value="${pdto.pcode}">
		<section id="first">
			<div id="left"> 
				<img src="../resources/pageimg/${pdto.pimg}">
			</div>
			<div id="right">
				<div id="right-first">
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
				</div>
				<c:if test="${pdto.halin!=0}">
				<div> ${pdto.halin}% SALE</div><div> 원가 <s id="input1"><fmt:formatNumber value="${pdto.price}" type="number"/></s> 원</div>
				<div><span  style="color:red;">할인가 </span> <span id="input2"><fmt:formatNumber value="${pdto.halinPrice}" type="number"/></span> 원</div>
				</c:if>
				<c:if test="${pdto.halin==0}">
				<div>할인가 <span id="input2"><fmt:formatNumber value="${pdto.halinPrice}" type="number"/></span> 원</div>
				</c:if>
				<c:if test="${pdto.baeprice==0}">
				<div>무료배송</div>
				</c:if>
				<c:if test="${pdto.baeprice!=0}">
				<div>배송비 <fmt:formatNumber value="${pdto.baeprice}" type="number"/> 원</div>
				</c:if>
				${pdto.baeEx }
				<div id="pjuk"> 적립예정 : <span id="input3"><fmt:formatNumber value="${pdto.jukPrice}" type="number"/></span>원 </div>
				<div id="ju">
					<div><input type="text" value="1" readonly id="su"></div>
					<div id="ju1">
						<input type="button" onclick="addCart()" id="btn1" value="장바구니">
						<div id="cartview">
							<div>장바구니에 담겼습니다.</div>
							<div><input type="button" value="장바구니로 이동" onclick="location='../member/cartView'"></div>
						</div>
					</div>
					<div><button onclick="location:''" id="btn2">구매하기</button></div>
				</div>
			</div>
		</section>
		</form>
		<section id="second"></section>
		<section id="third"></section>
		<section id="fourth"></section>
		<section id="fifth"></section>
		<section id="sixth"></section>
		
	</main>
</body>
</html>