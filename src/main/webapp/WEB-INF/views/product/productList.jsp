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
 </style>
</head>
<body> <!-- product/productList.jsp -->
  <main>
  	<div class="main-top">
  		<div>${pos}</div>
  		<div>
  			<a href="productList?pcode=${pcode}&type=pansu&order=desc">판매량순</a>
  			<a href="productList?pcode=${pcode}&type=price&order=asc">가격낮은순</a>
  			<a href="productList?pcode=${pcode}&type=price&order=desc">가격높은순</a>
  			<a href="productList?pcode=${pcode}&type=star&order=desc">별점순</a>
  			<a href="productList?pcode=${pcode}&type=writeday&order=desc">최신상품</a>
  		</div>
  	</div>
   <table width="1100" align="center">
     <tr>
     
     
    <c:forEach items="${plist}" var="pdto" varStatus="sts">
         <td> 
           <div> <img src="../resources/pageimg/${pdto.pimg}" width="200" height="300"> </div> 
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
   </table>
  </main>
</body>
</html>





