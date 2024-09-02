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
      margin:auto;
      font-family:'GmarketSansMedium';
    }
    main table {
      width: 100%;
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
    main #mainChk {
      width:18px;
      height:18px;
    }
    main .subChk {
    
    }
  </style>
<script>
	function mainChk() {
		var mainChk=document.getElementById("mainChk");
		var subChk=document.getElementsByClassName("subChk");
		for(i=0;i<subChk.length;i++) {
			if(mainChk.checked){
				subChk[i].checked=true;				
			} else {
				subChk[i].checked=false;
			}
		}
	}
	
	function subChk() {
		var mainChk=document.getElementById("mainChk");
		var subChk=document.getElementsByClassName("subChk");
		var allChk=true;
		
		for(i=0;i<subChk.length;i++) {
			if(!subChk[i].checked){
				allChk=false;
				break;
			}
		}
		mainChk.checked=allChk;
	}
	
	function chkDel(pcode) {
		var del="";
		if(pcode) {
			del=pcode;
		} else {
			var mainChk=document.getElementById("mainChk");
			var subChk=document.getElementsByClassName("subChk");
			
			for(i=0;i<subChk.length;i++) {
				if(subChk[i].checked) {
					del+=subChk[i].value+"/";
				}
			}
		}
		
		location="jjimDel?del="+del;
	}
	
	function addCart(pcode) {
		var chk=new XMLHttpRequest();
		chk.onload=function() {
			if(confirm("장바구니로 이동하시겠습니까?")) {
				location="cartView";
			} else {
				window.location.reload();
			}
		}
		chk.open("get","addCart?pcode="+pcode);
		chk.send();
	}
</script>
</head>
<body>
	<main>
		<table>
		<caption><h2>찜리스트 현황</h2></caption>
		<tr>
			<td colspan="3" align="center">상품</td>
			<td> 배송비 </td>
			<td colspan="2"> 가격 </td>
		</tr>
		<c:forEach var="pdto" items="${pdto}">
		<tr>
			<td width="40"align="center"> <input type="checkbox" class="subChk" value="${pdto.pcode }" onclick="subChk()"></td>
			<td width="200" align="center"> <img src="../resources/pageimg/${pdto.pimg }" width="80" height="80"> </td>
			<td> ${pdto.title } </td>
			<td>
			<c:if test="${pdto.baeprice==0 }">
			무료배송
			</c:if>
			<c:if test="${pdto.baeprice!=0 }">
			<fmt:formatNumber value="${pdto.baeprice }" type="number"/> 원
			</c:if>
			</td>
			<td> <fmt:formatNumber value="${pdto.halinPrice }" type="number" /> 원</td>
			<td>
				<input type="button" value="장바구니" style="margin-bottom: 5px; width:100px;" onclick="addCart('${pdto.pcode}')"> <br>
				<input type="button" value="삭제" style="width:100px;" onclick="chkDel('${pdto.pcode}')">
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="6">
			전체선택 <input type="checkbox" id="mainChk" onclick="mainChk()"> <input type="button" value="선택상품 삭제" onclick="chkDel()">
			</td>
		</tr>
		</table>
	</main>
</body>
</html>