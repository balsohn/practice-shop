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
 
 
   main #juk {
     border:1px solid #cccccc;
     padding:2px;
     padding-left:8px;
     padding-right:8px;
     border-radius:15px;
     font-size:12px;
   }
   main {width: 1100px; margin: auto; margin-top: 50px;}
   .main-top {display:flex; justify-content: space-between; margin-right:10px;}
   .main-top > div > a {text-decoration: none; color:black;}
   main table td {cursor: pointer; border:2px solid transparent;}
   table { margin-top: 20px;}
   td {padding: 10px;}
   td:hover {border-color:#ccc; border-radius: 5px; padding:10px;}
 </style>
 <script>
 /*
 function sel(){
	document.getElementsByClassName("type")[${param.order}].style.color="red";
 }
 */
 </script>
</head>
<body> <!-- product/productList.jsp -->
  <main>
  	<div class="main-top">
  		<div>${pos}</div>
  		<div>
  			<a href="productList?pcode=${pcode}&order=0" class="type">판매량순</a>
  			<a href="productList?pcode=${pcode}&order=1" class="type">가격낮은순</a>
  			<a href="productList?pcode=${pcode}&order=2" class="type">가격높은순</a>
  			<a href="productList?pcode=${pcode}&order=3" class="type">별점순</a>
  			<a href="productList?pcode=${pcode}&order=4" class="type">최신상품</a>
  		</div>
  	</div>
   <table width="1100" align="center">
     <tr>
     
     
    <c:forEach items="${plist}" var="pdto" varStatus="sts">
    	
         <td onclick="location='productContent?pcode=${pdto.pcode}'" width="20%"> 
           <div style="text-align:center;"> <img src="../resources/pageimg/${pdto.pimg}" width="200" height="300"> </div> 
           <div> ${pdto.title} </div>
          <c:if test="${pdto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
           <div> ${pdto.halin}%  <s> <fmt:formatNumber value="${pdto.price}" type="number"/>원  </s></div> 
          </c:if> 
           <div> <fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원 </div>
           <div> ${pdto.baeEx} </div>     
           <div style="letter-spacing:-4px"> 
             <c:forEach begin="1" end="5">
               <img src="../resources/uploads/star1.png" width="10">
             </c:forEach>
           </div>   
          <c:if test="${pdto.juk!=0}"> <!-- 적립금이 있다면 -->   
           <div> 
             <span id="juk"> <img src="../resources/uploads/juk.png" width="10">  
              최대 <fmt:formatNumber value="${pdto.jukPrice}" type="number"/>원 적립
             </span>
           </div>
          </c:if>
         </td>
         <c:if test="${sts.count%4 == 0}">
           </tr><tr>
         </c:if>
    </c:forEach>
     </tr>
     <tr>	
     	<td colspan="4" align="center">
     	<c:if test="${pstart!=1}">
     	<a href="productList?pcode=${param.pcode}&order=${order}&page=1">처음</a>
     	<a href="productList?pcode=${param.pcode}&order=${order}&page=${pstart-1}">이전</a>
     	</c:if>
     	<c:forEach var="i" begin="${pstart}" end="${pend}">
     	<a href="productList?pcode=${param.pcode}&order=${order}&page=${i}" <c:if test="${i==page}">style='color:red;'</c:if>>${i}</a>
     	
     	</c:forEach>
     	<c:if test="${chong!=pend}">
     	<a href="productList?pcode=${param.pcode}&order=${order }&page=${pend+1}">다음</a>
     	<a href="productList?pcode=${param.pcode}&order=${order}&page=${chong}">마지막</a>
     	</c:if>
		</td>
     </tr>
   </table>
  </main>
</body>
</html>





