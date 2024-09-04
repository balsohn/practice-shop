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
	
	
	function viewSub(n) {
		var sub=document.getElementsByClassName("sub");
		for(i=0;i<sub.length;i++) {
			sub[i].style.display="none";
		}
		
		sub[n].style.display="block";
	}
	
	function viewOther(my) {
		var other=document.getElementById("other");
		if(other.style.display!="block") {
			other.style.display="block";
			my.innerText="▲";
		} else {
			other.style.display="none";
			my.innerText="▼";
		}
	}
	
	var jukImsi=${juk};
	var chongPrice=${halinPrice+baePrice};
	function numChk(my) {
		my.value=my.value.replace(/[^0-9]/g,"");
	}
	
	function init(my) {
		if(my.value.trim()=="0") {
			my.value="";
		}
	}
	
	function jukCal(my) {
		if(my.value.trim()=="") {
			my.value="0";
			document.getElementById("chong").innerText=chongPrice.toLocaleString();
		} else {
			if(my.value>jukImsi) {
				alert("보유 포인트를 초과합니다.");
				my.value="0";
				document.getElementById("point").innerText=jukImsi.toLocaleString();
				document.getElementById("chong").innerText=chongPrice.toLocaleString();
			} else {
				document.getElementById("point").innerText=(jukImsi-my.value).toLocaleString();
				document.getElementById("chong").innerText=(chongPrice-my.value).toLocaleString();
			}
		}
	}
	
	function chgPhone() {
		var mPhone=document.getElementById("phone");
		
		if(mPhone.value.trim().length==0) {
			alert('전화번호가 없습니다.');
		} else {
			var chk=new XMLHttpRequest();
			chk.onload=function() {
				if(chk.responseText==1) {
					alert('변경 완료');
				}
			}
			chk.open("get","chgPhone?phone="+mPhone.value);
			chk.send();
		}
	}
	
	document.addEventListener('DOMContentLoaded', function() {
	    // 여기서 필요한 초기화 코드를 넣습니다.
	    // 예를 들어 처음에 보여줄 sub 항목을 처리할 수 있습니다.
	    var sub = document.getElementsByClassName("sub");
	    for (i = 0; i < sub.length; i++) {
	        sub[i].style.display = "none";
	    }
	    
	    // 첫 번째 옵션 기본 표시
	    sub[0].style.display = "block";
	});
</script> 
 <style>
   main {
     width:700px;
     margin:auto;
     margin-top :30px;
    font-family: 'GmarketSansMedium';
    
   }
   section {margin:20px auto; width: 700px;}
   main #sudan #other {
     display:none;
   }
   main #sudan #fsub {
     display:block;
   }
   main #sudan #sudan-first {
     width:700px;
     border:1px solid purple;
     padding:10px;
     margin-top :5px;
     border-radius: 5px;
   }
   main #sudan #sudan-second {
     width:700px;
     border:1px solid purple;
     padding:10px;
     margin-top :10px;
     border-radius: 5px;
   }
   main #sudan .subMain {
     display:none;
   }
   main #sudan #up {
     display:none;
   }
   main #sudan #down {
   
   }
   main #sudan select {
     width:120px;
     height:28px;
     margin-left:10px;
   }
   
   main table {
      border-spacing:0px;
      margin-top:10px;
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
   main table tr td:first-child {
      background:#efefef;
      
   }
   main table  #useJuk {  /* 적립금 input태그 */
      width:50px;
      outline:none;
      text-align:right;
   }
   
   button {border:none; background: none; font-size: 18px;}
 </style>
</head>
<body>	<!-- product/gumae.jsp -->
	<main>
	    <h2 style="border-bottom:3px solid purple; margin-bottom: 20px;"> 주문 / 결제 </h2>
		<section id="member"> <!-- 구매자정보 -->
			<table width="700" align="center">
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
						<input type="text" name="phone" id="phone" value="${mdto.phone }">
						<input type="button" onclick="chgPhone()" value="수정">
					</td>
				</tr>
			</table>
		</section>
		<section id="baesong">
			<table width="700" align="center">
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
					<td> 상품가격 </td>
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
						<input type="text" name="useJuk" value="0" onfocus="init(this)" onblur="jukCal(this)" oninput="numChk(this)" style="width:100px; height: 28px;"> / 
						<span id="point"><fmt:formatNumber value='${juk }' type='number'/></span> 포인트 
					</td>
				</tr>
				<tr>	
					<td> 총 결제 금액 </td>
					<td> 
						<span id="chong"><fmt:formatNumber value='${halinPrice+baePrice}' type='number'/></span> 원 
					</td>
				</tr>
			</table>
		</section>
		<section id="sudan">
			<h3>결제수단</h3>
			<div id="sudan-first">
				<div> 
					<label><input type="radio" name="sudan" class="sudan" onclick="viewSub(0)" checked> 신용 / 체크카드 </label>
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
					<label><input type="radio" name="sudan" class="sudan" onclick="viewSub(1)" > 쿠페이머니 </label>
					<div class="sub">
						0원
					</div>
				</div>
			</div>
			<div id="sudan-second">
				<div><label>다른결제 수단 <button onclick="viewOther(this)">▼</button></label></div>
					<div id="other">
					<div> 
						<label><input type="radio" name="sudan" class="sudan" onclick="viewSub(2)" > 계좌이체 </label> 
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
						<label><input type="radio" name="sudan" class="sudan" onclick="viewSub(3)" > 법인카드 </label>
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
						<label><input type="radio" name="sudan" class="sudan" onclick="viewSub(4)" > 휴대폰 </label> 
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
						<label><input type="radio" name="sudan" class="sudan" onclick="viewSub(5)" > 무통장입금 </label> 
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
			</div>
		</section>
	</main>
</body>
</html>