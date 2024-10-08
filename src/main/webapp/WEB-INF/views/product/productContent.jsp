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
	
	main #allMenu {
		width: 1100px;
		height: 50px;
		
	}
	
	main #allMenu ul {
		width: 1100px;
		height: 60px;
		padding-left: 0px;
		text-align: center;
		background: #ccc;
		vertical-align: center;
	}
	
	main #allMenu ul li {
		list-style-type: none;
		display: inline-block;
		width: 24%;
		height: 50px;
		border: 1px solid black;
		text-align: center;
		line-height: 60px;
		background:white;
	}
	
	.myReview {
		border:1px solid black;
	}
	
	main h3 {
		margin: 20px 0;
	}
	
	main #second {		/* 상품상세 */
		
	}
	
	main #third {
		margin-bottom: 30px;
	}
	
	main #fourth {
		position: relative;
	}
	
	main #fourth #qwform {
		display:none;
		width: 300px;
		height: 300px;
		
		position: absolute;
		left:50%;
		top:30px;
		transform: translate(-50%);
	}
	
	#qwform textarea {
		width:100%;
		height: 150px;
		resize: vertical;
	}
	#qwform input {
		width:100%;
		height: 30px;
	}
	
	#quest-container {
		width:800px;
		border-bottom:1px solid black;
		margin: auto;
	}
	
	main #fifth {
	
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

	function scrollMove() {
		var st=document.documentElement.scrollTop;
		
		if(st>=691) {
			document.getElementById("allMenu").style.position="fixed";
			document.getElementById("allMenu").style.top="0px";
			
		} else {
			document.getElementById("allMenu").style.position="relative";
			document.getElementById("allMenu").style.top="0px";
		}
	}
	
	window.onscroll=scrollMove;
	
	function questWrite() {
		document.getElementById("qwform").style.display="block";
	}
	
	function goLogin(pcode) {
		var cookie='/product/productContent?pcode='+pcode;
		
		setCookie("url", cookie, 5);
		
		location="../login/login";
	}
	
	function setCookie(name, value, minutes) {
	    var date = new Date();
	    date.setTime(date.getTime() + (minutes * 60 * 1000)); // 분 단위로 만료 시간 설정
	    alert(date);
	    var expires = "expires=" + date.toUTCString();
	    document.cookie = name + "=" + value + ";" + expires + ";path=/";
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
						<c:forEach begin="1" end="${ystar }">
						<img src="../resources/uploads/star1.png" width="10">
						</c:forEach>
						<c:if test="${hstar==1 }">
						<img src="../resources/uploads/star3.png" width="10">
						</c:if>
						<c:forEach begin="1" end="${gstar }">
						<img src="../resources/uploads/star2.png" width="10">
						</c:forEach>
						${review.size() }개 상품평
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
					<div><input type="text" value="1" readonly name="su" id="su"></div>
					<div id="ju1">
						<input type="button" onclick="addCart()" id="btn1" value="장바구니">
						<div id="cartview">
							<div>장바구니에 담겼습니다.</div>
							<div><input type="button" value="장바구니로 이동" onclick="location='../member/cartView'"></div>
						</div>
					</div>
					<div><button type="submit" id="btn2">구매하기</button></div>
				</div>
			</div>
		</section>
		</form>
		
		<div id="allMenu">
			<ul>
				<a href="#second"><li> 상품상세 </li></a>
				<a href="#third"><li> 상품평 </li></a>
				<a href="#fourth"><li> 상품문의 </li></a>
				<a href="#fifth"><li> 배송/교환/취소 </li></a>
			</ul>
		</div>
		
		<section id="second">
			<h3 class="cmenu"> 상품 상세 </h3>
			<img src="/resources/pageimg/${pdto.dimg }" width="1100">
		</section>
		<section id="third">
			<h3 class="cmenu"> 상품평 </h3>
			<div>평균별점
			<c:forEach begin="1" end="${ystar }">
			<img src="../resources/uploads/star1.png" width="10">
			</c:forEach>
			<c:if test="${hstar==1 }">
			<img src="../resources/uploads/star3.png" width="10">
			</c:if>
			<c:forEach begin="1" end="${gstar }">
			<img src="../resources/uploads/star2.png" width="10">
			</c:forEach> (총 리뷰 ${review.size() }개)
			</div>
			<c:forEach var="review" items="${review }">
			<div class="myReview">
				<div>
					${review.user } (${review.writeday })
					<c:if test="${userid==review.userid }">
						<a href="reviewDel?pcode=${review.pcode}&id=${review.id}">삭제</a>
					</c:if>
				</div>
				<c:forEach begin="1" end="${review.star }">
					<img src="../resources/uploads/star1.png" width="10">
				</c:forEach>
				<c:forEach begin="1" end="${5-review.star }">
					<img src="../resources/uploads/star2.png" width="10">
				</c:forEach>
				<div>${review.oneLine }</div>
				<div>${review.content }</div>
			</div>
			</c:forEach>
		</section>
		<section id="fourth">
			<div id="qwform">
				<form method="post" action="questWriteOk">
					<input type="hidden" name="pcode" value="${pdto.pcode}">
					<textarea name="content"></textarea><br>
					<input type="submit" value="문의하기">
				</form>
			</div>
			<h3 class="cmenu">
				상품문의
				<c:if test="${!empty userid }"> 
				<input type="button" value="문의하기" onclick="questWrite()">
				</c:if>
				<c:if test="${empty userid }">
				<input type="button" value="문의하기" onclick="goLogin('${pdto.pcode}')">
				</c:if> 
			</h3>
			<c:forEach var="qdto" items="${questAll}">
				<table id="quest-container">
					<tr>
						<c:if test="${qdto.qna==0}">
						<td width="10%">질문</td>
						<td align="left">
						${qdto.content}
						</td>
						</c:if>
						<c:if test="${qdto.qna==1}">
						<td width="10%">답변</td>
						<td style="padding-left:20px; ">
						ㄴ${qdto.content}
						</td>
						</c:if>
						<td align="right">${qdto.writeday}</td>
					</tr>
				</table>			
			</c:forEach>
		</section>
		<section id="fifth">
			<h3 class="cmenu"> 배송/교환/취소 </h3>
			<img src="../resources/uploads/exch.png">
		</section>
		<section id="sixth"></section>
		
	</main>
</body>
</html>