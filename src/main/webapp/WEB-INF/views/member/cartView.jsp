<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>     

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<<<<<<< HEAD
<style>
	main {display:grid; grid-template-cloumns: 5fr 3fr; width:800px;}
	.item-container {display: grid; grid-template-columns:9fr 1fr; border:1px solid black;}
</style>
</head>
<body>
	<main>
	<div class="item-container">
		<c:forEach var="map" items="${pMapAll}">
		<div> <img src="../resources/pageimg/${map.pimg}"> </div>
		<div>
			<div>asdf</div>
			<div>asfd</div>
			<div>asdf</div>
		</div>
		</c:forEach>
	</div>
	<div>
		<div>asfdasdfaf</div>
	</div>
=======
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
.allClick {position: fixed; bottom: 0px; background: white; width:1100px; border-top: 1px solid black;}
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
	}
	
	$(function() {
		$('.su').spinner({
			min: 1,
			max: 10,
			spin: function(e, ui) {
				// 현재 스피너 요소의 인덱스를 구함
				var index = $('.su').index($(e.target));
				// 해당 인덱스의 .hal 요소 값을 가져옴
				var halValue = $('.hal').eq(index).val();
				alert(halValue);
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
		<c:forEach items="${pMapAll}" var="map" varStatus="sts">
		<input type="hidden" value="${map.halinprice}" class="hal">
		<input type="hidden" value="${map.jukprice}" class="juk">
		<input type="hidden" value="${map.price}" class="pri">
		<tr height="80">
			<td> <input type="checkbox" class="subChk" onclick="subChk()"> </td>
			<td width="100" align="center"> <img src="../resources/pageimg/${map.pimg}" height="80" width="80"> </td>
			<td align="left"> ${map.title} </td>
			<td width="140"> ${map.baeEx} </td>
			<td width="110" align="right"> <div class="halinprice"> <fmt:formatNumber value="${map.halinprice}" type="number"/>원 </div></td>
			<td width="110" align="right"> <div class="jukprice"><fmt:formatNumber value="${map.jukprice}" type="number"/>원 </div></td>
			<td width="60" align="right"> <input type="text" value="${map.cart_su}" name="su" class="su"> </td>
			<td width="110" align="right"> 
			<c:if test="${map.baeprice==0}">
			무료배송
			</c:if>
			<c:if test="${map.baeprice!=0}">
			<fmt:formatNumber value="${map.baeprice}" type="number"/>원
			</c:if>
			</td>
		</tr>
		</c:forEach>
		<tr class="allClick">
			<td> <label><input type="checkbox" id="mainChk" onclick="allChk()"> 전체 선택</label> </td>
			<td> 구매하기 </td>
		</tr>
		</table>
>>>>>>> origin/sub
	</main>
</body>
</html>