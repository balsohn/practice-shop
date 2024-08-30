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
main {
  width:1100px;
  height:600px;
  margin:auto;
  font-family:'GmarketSansMedium';
}
main table {
  margin-top:50px;     
  margin-bottom:50px;
  border-spacing:0px;
}
main table td {
  border-bottom:1px solid purple;
  padding-top:5px;
  padding-bottom:5px;
}
main table tr:first-child td {
  border-top:2px solid purple;
}
.su {width:30px;}
.allClick {
	position: fixed; 
	bottom: 0px; 
	background: white; 
	width:1100px; 
	border-top: 1px solid black;
	
}
label {margin-right: 30px;}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script>
	function allChk() {
		var mainChk=document.getElementById("mainChk");
		var subChk=document.getElementsByClassName("subChk");
		if(mainChk.checked){
			for(i=0; i<subChk.length;i++) {
				subChk[i].checked=true;
			} 
		} else {
			for(i=0; i<subChk.length;i++) {
				subChk[i].checked=false;
			} 
		}
	}
	
	function subChk() {
		var mainChk=document.getElementById("mainChk");
		var subChk=document.getElementsByClassName("subChk");
		var allChk=true;
		
		for(i=0; i<subChk.length;i++) {
			if(!subChk[i].checked) {
				allChk=false;
				break;
			}
		} 
		mainChk.checked=allChk;
		totalChk();
	}
	
	function totalChk() {
		var subChk=document.getElementsByClassName("subChk");
		var hp=document.getElementsByClassName("hp");
		var jp=document.getElementsByClassName("jp");
		var bp=document.getElementsByClassName("bp");
		
		var totalHp=0;
		var totalJp=0;
		var totalBp=0;
		
		for(i=0; i<subChk.length;i++) {
			if(subChk[i].checked) {
				totalHp += parseInt(hp[i].innerHTML.replace(/,/g,''));
				totalJp += parseInt(jp[i].innerHTML.replace(/,/g,''));
				if(bp[i].innerHTML!='무료배송'){
					totalBp += parseInt(bp[i].innerHTML.replace(/,/g,''));
				}
			}
		}
		
		document.getElementById('chong').innerText="총삼품금액 "+totalHp+"원 + 배송비 "+totalBp+"원 = 총결제금액 "+(totalHp+totalBp)+"원 (적립예정 :"+totalJp+"원)";
		
	}
	
	function selDel() {
		var subChk=document.getElementsByClassName('subChk');
		var pcode='';
		
		for(i=0;i<subChk.length;i++) {
			if(subChk[i].checked){
				pcode=pcode+subChk[i].value+"/";
			}
		}
		if(pcode!=''){
			location="cartDel?pcode="+pcode;
			
		}
	}
	
	$(function() {
		$('.su').spinner({
			min: 1,
			max: 10,
			spin: function(e, ui) {
				
				var pri=document.getElementsByClassName("price");
	            var hp=document.getElementsByClassName("hp");
	            var jp=document.getElementsByClassName("jp");
	            var bp=document.getElementsByClassName("bp");
	            var hal=document.getElementsByClassName("hal");
	            var juk=document.getElementsByClassName("juk");
	            
	            // 현재 스핀 이벤트가 발생한 인덱스를 찾기 위해 사용
	            var index=$('.su').index(e.target);
	            var su=ui.value;
	            
	            // 할인율과 적립금 계산
	            var originalPrice=parseInt(pri[index].value.replace(/,/g, ''));
	            var halin=parseInt(hal[index].value.replace(/,/g, '')) / 100;
	            var jukRate=parseInt(juk[index].value.replace(/,/g, '')) / 100;

	            // 계산된 가격 및 적립금
	            var newHp=Math.floor(originalPrice * (1 - halin) * su);
	            var newJp=Math.floor(originalPrice * jukRate * su);
	            
	            // 값 업데이트
	            hp[index].innerText=newHp.toLocaleString();
	            jp[index].innerText=newJp.toLocaleString();

	            // 총합계 업데이트
	            totalChk();
	            
			}
		});
		
		
		
	});

	
</script>
</head>
<body>
	<main>
		<table width="1100" align="center">
		<caption> <h2> 장바구니 현황 </h2> </caption>
		<tr style="text-align:center;">
			<td colspan="3"> 제품 </td>
			<td> 도착 예정일 </td>
			<td> 총가격 </td>
			<td> 적립금 </td>
			<td> 수량 </td>
			<td> 배송비 </td>
		</tr>
		<c:set var="cnum" value="0"/>
		<c:forEach items="${pMapAll}" var="map" varStatus="sts">
		<input type="hidden" class="price" value="${map.price}">
		<input type="hidden" class="juk" value="${map.juk }">
		<input type="hidden" class="hal" value="${map.halin }">
		<c:if test="${map.days<=1}">
			<c:set var="cnum" value="${cnum+1}"/>
		</c:if>
		<tr height="80">
			<td> <input type="checkbox" ${map.days<2?'checked':''} value="${map.pcode}" class="subChk" onclick="subChk()"> </td>
			<td width="100" align="center"> <img src="../resources/pageimg/${map.pimg}" height="80" width="80"> </td>
			<td align="left"> ${map.title} </td>
			<td width="140"> ${map.baeEx} </td>
			<td width="110" align="right"> <span class="hp"><fmt:formatNumber value="${map.halinprice}" type="number"/></span>원 </td>
			<td width="110" align="right"> <span class="jp"><fmt:formatNumber value="${map.jukprice}" type="number"/></span>원 </td>
			<td width="60" align="right"> <input type="text" value="${map.cart_su}" name="su" class="su"> </td>
			<td width="110" align="right"> 
			<c:if test="${map.baeprice==0}">
			<span class="bp">무료배송</span>
			</c:if>
			<c:if test="${map.baeprice!=0}">
			<span class="bp"><fmt:formatNumber value="${map.baeprice}" type="number"/></span>원
			</c:if>
			<br> <input type="button" value="삭제" onclick="location='cartDel?pcode=${map.pcode}'">
			</td>
		</tr>
		</c:forEach>
		<tr class="allClick" align="center">
			<td> <label><input type="checkbox" ${cnum==pMapAll.size()?'checked':''} id="mainChk" onclick="allChk()"> 전체 선택</label> </td>
			<td> <input type="button" value="선택상품 삭제" onclick="selDel()"> </td>
			<td colspan="5" id="chong">
				총상품금액 
				<fmt:formatNumber value="${halinpriceTot}" type="number"/>원 
				+ 배송비 
				<fmt:formatNumber value="${baepriceTot}" type="number"/>원 = 총결제금액 
				<fmt:formatNumber value="${halinpriceTot+baepriceTot}" type="number"/>원  
				(적립예정 : <fmt:formatNumber value="${jukpriceTot}" type="number"/>원) 
			</td>
			<td> 구매하기 </td>
		</tr>
		</table>

	</main>
</body>
</html>