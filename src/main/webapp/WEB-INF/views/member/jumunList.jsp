<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>         
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역</title>
 <style>
   main {
     width:800px;
     margin:20px auto;
     font-family: 'GmarketSansMedium';
   }
   
   h3{ margin-top: 30px;}
   main table {
		width:100%;
      border-spacing:0px;
      margin-top:30px;
   }
   
   #cal table {
   		margin:0;
   }
   
   table {border-spacing: 0px;}
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
   main #btn {
      font-size:11px;
      background:purple;
      color:white;
      border:1px solid purple;
      padding:10px 20px;
   }
   
   main #pkc {
   		position: relative;
   }
   
   main #cal {
   		position: absolute;
   		background: white;
   		padding: 10px;
   		border: 1px solid purple;
   		display: none;
   		left: 350px;
   }
   
   
   </style>
   <script>
   function calView(y,m,chk)
 {

	  // 달력 생성시 필요한 값 : 1일의요일, 총일수, 몇주
	  // 1일의 요일 => ?년 ?월 1일의 날짜 객체가 필요
	  if(!y) // 값이 없다면
	  {

	     var today=new Date();		  
	     var y=today.getFullYear();
	     var m=today.getMonth(); // 0~11
	  }
	  
	  // 월이 -1이 오면
	  if(m==-1)
	  {
		  y=y-1;
		  m=11;
	  }	  
	  
	  // 월이 12가 오면
	  if(m==12)
	  {
		  y=y+1;
		  m=0;
	  }	  
	  
	  var xday=new Date(y,m,1);
	  var yoil=xday.getDay(); //0~6(일~토)
	  
	  var month=[31,28,31,30,31,30,31,31,30,31,30,31];
	  var chong=month[m];
	  
	  if( (y%4==0 && y%100!=0) || y%400==0 )  // 4의 배수 100의 배수는 아니다   단 400의 배수는 윤년
	  {
		  if(m==1)
		    chong=chong+1;
	  }	  
	  
	  var ju=Math.ceil( (chong+yoil)/7 );
	  

	  
	  var calData="<table width='200' height='180' border='0'>";
	  calData=calData+"<caption>";
	  calData=calData+" <span onclick='calView("+y+","+(m-1)+","+chk+")'> << </span>";  
	  calData=calData+y+"년 "+(m+1)+"월";                                                
	  calData=calData+" <span onclick='calView("+y+","+(m+1)+","+chk+")'> >> </span>";  
	  calData=calData+"</caption>";
	  calData=calData+"<tr>";
	  calData=calData+"<td> 일 </td>";
	  calData=calData+"<td> 월 </td>";
	  calData=calData+"<td> 화 </td>";
	  calData=calData+"<td> 수 </td>";
	  calData=calData+"<td> 목 </td>";
	  calData=calData+"<td> 금 </td>";
	  calData=calData+"<td> 토 </td>";
	  calData=calData+"</tr>";
	  var day=1;
	  for(i=1;i<=ju;i++)
	  {
		  calData=calData+"<tr>";
		  
		  for(j=0;j<7;j++)
		  {
			  if( (i==1 && j<yoil)  || chong<day  )  // 첫주에 1일의 요일보다 적은 j , 총일수보다 많은 day값일때
			  {	  
			      calData=calData+"<td> &nbsp; </td>";
			  }
			  else
			  {	  
				  calData=calData+"<td onclick='moveNalja("+y+","+m+","+day+","+chk+")'>"+day+"</td>";
				                      
			      day++;
			  }
  	      }	  
		  
		  calData=calData+"</tr>";
	  }
	  calData=calData+"</table>";

	  document.getElementById("cal").innerHTML=calData;
	  document.getElementById("cal").style.display="block";
	
 }
   
   function moveNalja(y,m,d,chk) {
	   var gigan=document.getElementsByClassName("gigan");
	   var nalja=y+"-"+String(m+1).padStart(2, "0")+"-"+String(d).padStart(2, "0");
	   var start=new Date(gigan[0].value);
	   var end=new Date(nalja);
	   if(chk==0) {
		   gigan[chk].value=nalja;		   
	   } else {
		   if((end-start)<0) {
			   alert("기간을 확인해주세요.");
			   gigan[chk].value="";
		   } else {
			   gigan[chk].value=nalja;		 
		   }
	   }
	   document.getElementById("cal").style.display="none";
   }
 </script>
</head>
<body>
	<main>	
		<h2>주문목록</h2>
		<div align="center" id="pkc">
			<form method="post" action="jumunList">
				<input type="hidden" name="month" value="-1">
				<input type="button" onclick="location='jumunList?month=3'" value="3개월">
				<input type="button" onclick="location='jumunList?month=6'" value="6개월">
				<input type="button" onclick="location='jumunList?month=12'" value="12개월">
				<input type="text" readonly name="start" class="gigan" onfocus="calView(null,null,0)">-
				<input type="text" readonly name="end" class="gigan" onfocus="calView(null,null,1)">
				<input type="submit" value="조회">
			</form>
			<div id="cal"></div>
		</div>
		<c:set var="prevDate" value="${map[0].writeday }"/>
		<c:set var="chong" value="0"/>
		
		<c:forEach var="map" items="${mapAll}">
			<c:if test="${prevDate != map.writeday}">
				<!-- 이전 날짜의 테이블 종료 -->
				<c:if test="${not empty prevDate}">
					<tr>
						<td colspan="5" style="text-align:right;">
							<strong>사용한 적립금 : ${map.useJuk }  </strong>
							<strong>총결제 금액: ${chong }</strong>
						</td>
					</tr>
					</table>
				</c:if>

				<!-- 새로운 날짜의 테이블 시작 -->
				<h3>${map.writeday}</h3>
				<table class="hi">
					<tr>
						<td>상 태</td>
						<td>주문상품</td>
						<td>결제금액</td>
						<td>수 량</td>
						<td>비 고</td>
					</tr>

				<!-- 총결제 금액 초기화 -->
				<c:set var="chong" value="0"/>
				<c:set var="prevDate" value="${map.writeday}"/>
			</c:if>

			<!-- 주문 항목 출력 -->
			<tr>
				<td>${map.stat}</td>
				<td align="left" valign="baseline">
					<img src="../resources/pageimg/${map.pimg}" width="80" height="80">
					${map.title}
				</td>
				<td>${map.price}</td>
				<td>${map.su}</td>
				<td>
				<c:if test="${map.state==0}">
					<input type="button" value="취소신청" id="btn" onclick="location='chgState?state=4&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3}">
					<input type="button" value="반품신청" id="btn" onclick="location='chgState?state=5&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3}">
					<input type="button" value="교환신청" id="btn" onclick="location='chgState?state=7&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3 && map.isReview==0}">
					<input type="button" value="리뷰쓰기" id="btn" onclick="location='reviewWrite?pcode=${map.pcode}&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3 && map.isReview==1}">
				<input type="button" value="리뷰보기" id="btn">
				</c:if>
				<c:if test="${map.state==5}"> 
					<input type="button" value="반품취소" id="btn" onclick="location='chgState?state=3&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==7}"> 
					<input type="button" value="교환취소" id="btn" onclick="location='chgState?state=3&id=${map.id}'">
				</c:if>  
				</td>
			</tr>

			<!-- 총결제 금액 업데이트 -->
			<c:set var="chong" value="${map.chongPrice}"/>
		</c:forEach>

		<!-- 마지막 테이블의 총결제 금액 출력 -->
		<c:if test="${not empty prevDate}">
			<tr>
				<td colspan="5" style="text-align:right;">
					<strong>사용한 적립금 : ${map.useJuk }  </strong>
					<strong>총결제 금액: ${chong}</strong>
				</td>
			</tr>
			</table>
		</c:if>
	</main>
</body>
</html>
