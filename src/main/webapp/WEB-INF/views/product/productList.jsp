<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
</style>
</head>
<body>
	<section>
   <table width="1100" align="center">
     <tr>
    <c:forEach items="${plist}" var="pdto" varStatus="sts">

         <td> 
           <div> <img src="../resources/pageimg/${pdto.pimg }" width="200" height="300"> </div> 
           <div> ${pdto.title} </div>
         </td>
         <c:if test="${sts.count%4 == 0}">
           </tr><tr>
         </c:if>
    </c:forEach>
     </tr>
   </table>
	</section>
</body>
</html>