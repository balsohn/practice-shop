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
    article {
       width: 1500px;
       height: 402px;
       margin: auto;
       display: flex;
       overflow: hidden;
       position: relative;
    }

    article img {
       width: 100%;
       height: 100%;
       position: absolute;
       top: 0;
       left: 0;
       opacity: 0;
       transition: opacity 1s ease-in-out;
    }

    article img.active {
       opacity: 1;
       z-index: 1;
    }

    main {
       width: 1100px;
       margin: auto;
    }

    main section {
        width: 1100px;
        margin: 20px auto; /* 섹션 간 간격 추가 */
        padding: 20px;
        background: #f9f9f9;
        border-radius: 10px; /* 둥근 모서리 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 약간의 그림자 추가 */
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    main section:hover {
        transform: scale(1.02); /* 살짝 확대 */
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15); /* 그림자 증가 */
    }

    /* 각 섹션별 배경색 설정 */
    main #p1 {
        background-color: #ffe0e0; /* 부드러운 핑크 */
    }

    main #p2 {
        background-color: #e0ffe0; /* 부드러운 연두색 */
    }

    main #p3 {
        background-color: #e0e0ff; /* 부드러운 하늘색 */
    }

    main #p4 {
        background-color: #fff0e0; /* 부드러운 주황색 */
    }

    /* 테이블 스타일 */
    main section table {
        width: 100%;
        border-spacing: 10px; /* 셀 간의 간격 추가 */
    }

    main section td {
        text-align: center;
        padding: 10px;
        border-radius: 10px;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* 테이블 셀에 살짝 그림자 추가 */
        transition: box-shadow 0.3s ease;
    }

    main section td:hover {
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 테이블 셀 호버 시 그림자 강조 */
        transform: translateY(-5px); /* 살짝 떠오르는 효과 */
    }

    /* 테이블 제목 스타일 */
    main section caption h2 {
        font-size: 24px;
        font-weight: bold;
        color: #333;
        margin-bottom: 20px;
        text-align: left;
    }

</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
    $(function() {
        let currentIndex = 0;
        const images = $('article img');
        const imageCount = images.length;

        function showNextImage() {
            images.eq(currentIndex).removeClass('active');
            currentIndex = (currentIndex + 1) % imageCount;
            images.eq(currentIndex).addClass('active');
        }

        images.eq(currentIndex).addClass('active'); // 첫 번째 이미지를 표시

        setInterval(showNextImage, 3000); // 3초마다 슬라이드 변경
		
        isTime();
        let ss=setInterval(isTime,1000);
    });
    
    function isTime() {
	  	var xday=new Date('${time[0].salesDay }');
    	var today=new Date();
    	var sigan=xday-today;
    	
    	if(sigan<=0) {
    		clearInterval(ss);
    	}
    	sigan=Math.floor(sigan/1000);
    	var sec=sigan%60;
    	
    	sigan=Math.floor(sigan/60);
    	var min=sigan%60;
    	
    	sigan=Math.floor(sigan/60);
    	var hour=sigan%24;
    	
    	sigan=Math.floor(sigan/24);
    	document.getElementById("countdown").innerText=sigan+"일 "+hour+"시간 "+min+"분 "+sec+"초";
    }
</script>
</head>
<body> <!-- main/index.jsp -->

    <article>
        <img src="/resources/uploads/s2.png" alt="Image 1">
        <img src="/resources/uploads/s3.png" alt="Image 2">
        <img src="/resources/uploads/s4.png" alt="Image 3">
        <img src="/resources/uploads/s5.png" alt="Image 4">
        <img src="/resources/uploads/s6.png" alt="Image 5">
        <img src="/resources/uploads/s7.png" alt="Image 6">
    </article>
    
    
    <main>
        <section id="p1">
        <table>
		<h2>타임세일</h2>
        <span id="countdown" style="color:red;"></span>
        	<tr>
        	<c:forEach var="timedto" items="${time }">
				<td onclick="location='../product/productContent?pcode=${timedto.pcode}'" width="20%"> 
				<div style="text-align:center;"> <img src="../resources/pageimg/${timedto.pimg}" width="200" height="300"> </div> 
				<div> ${timedto.title} </div>
				<c:if test="${timedto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
				<div> ${timedto.halin}%  <s> <fmt:formatNumber value="${timedto.price}" type="number"/>원  </s></div> 
				</c:if> 
				<div> <fmt:formatNumber value="${timedto.halinPrice}" type="number"/>원 </div>
				<div> ${timedto.baeEx} </div>     
				<div style="letter-spacing:-4px"> 
				<c:forEach begin="1" end="${timedto.ystar}">
				<img src="../resources/uploads/star1.png" width="10">
				</c:forEach>
				<c:if test="${timedto.hstar==1}">
				<img src="../resources/uploads/star3.png" width="10">
				</c:if>
				<c:forEach begin="1" end="${timedto.gstar}">
				<img src="../resources/uploads/star2.png" width="10">
				</c:forEach>
				</div>   
				<c:if test="${timedto.juk!=0}"> <!-- 적립금이 있다면 -->   
				<div> 
				<span id="juk"> <img src="../resources/uploads/juk.png" width="10">  
				최대 <fmt:formatNumber value="${timedto.jukPrice}" type="number"/>원 적립
				</span>
				</div>
				</c:if>
				</td>
        	</c:forEach>
        	</tr>
       	</table>
        </section> <!-- 타임세일 -->
        
        <section id="p2">
        <table>
        <caption><h2>특가상품</h2></caption>
			<tr>	
        	<c:forEach var="halindto" items="${halin }">
				<td onclick="location='../product/productContent?pcode=${halindto.pcode}'" width="20%"> 
				<div style="text-align:center;"> <img src="../resources/pageimg/${halindto.pimg}" width="200" height="300"> </div> 
				<div> ${halindto.title} </div>
				<c:if test="${halindto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
				<div> ${halindto.halin}%  <s> <fmt:formatNumber value="${halindto.price}" type="number"/>원  </s></div> 
				</c:if> 
				<div> <fmt:formatNumber value="${halindto.halinPrice}" type="number"/>원 </div>
				<div> ${halindto.baeEx} </div>     
				<div style="letter-spacing:-4px"> 
				<c:forEach begin="1" end="${halindto.ystar}">
				<img src="../resources/uploads/star1.png" width="10">
				</c:forEach>
				<c:if test="${halindto.hstar==1}">
				<img src="../resources/uploads/star3.png" width="10">
				</c:if>
				<c:forEach begin="1" end="${halindto.gstar}">
				<img src="../resources/uploads/star2.png" width="10">
				</c:forEach>
				</div>   
				<c:if test="${halindto.juk!=0}"> <!-- 적립금이 있다면 -->   
				<div> 
				<span id="juk"> <img src="../resources/uploads/juk.png" width="10">  
				최대 <fmt:formatNumber value="${halindto.jukPrice}" type="number"/>원 적립
				</span>
				</div>
				</c:if>
				</td>
        	</c:forEach>
        	</tr>
       	</table>
        </section>	<!-- 특가상품 -->
        <section id="p3">
        <table>
        <caption><h2>최신상품</h2></caption>
    	    <tr>	
        	<c:forEach var="writedto" items="${writeday }">
				<td onclick="location='../product/productContent?pcode=${writedto.pcode}'" width="20%"> 
				<div style="text-align:center;"> <img src="../resources/pageimg/${writedto.pimg}" width="200" height="300"> </div> 
				<div> ${writedto.title} </div>
				<c:if test="${writedto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
				<div> ${writedto.halin}%  <s> <fmt:formatNumber value="${writedto.price}" type="number"/>원  </s></div> 
				</c:if> 
				<div> <fmt:formatNumber value="${writedto.halinPrice}" type="number"/>원 </div>
				<div> ${writedto.baeEx} </div>     
				<div style="letter-spacing:-4px"> 
				<c:forEach begin="1" end="${writedto.ystar}">
				<img src="../resources/uploads/star1.png" width="10">
				</c:forEach>
				<c:if test="${writedto.hstar==1}">
				<img src="../resources/uploads/star3.png" width="10">
				</c:if>
				<c:forEach begin="1" end="${writedto.gstar}">
				<img src="../resources/uploads/star2.png" width="10">
				</c:forEach>
				</div>   
				<c:if test="${writedto.juk!=0}"> <!-- 적립금이 있다면 -->   
				<div> 
				<span id="juk"> <img src="../resources/uploads/juk.png" width="10">  
				최대 <fmt:formatNumber value="${writedto.jukPrice}" type="number"/>원 적립
				</span>
				</div>
				</c:if>
				</td>
        	</c:forEach>
        	</tr>
       	</table>
        </section> <!-- 최신상품 -->
        <section id="p4">
        <table>
        <caption><h2>BEST</h2></caption>
   	      <tr>	
        	<c:forEach var="bestdto" items="${best }">
				<td onclick="location='../product/productContent?pcode=${bestdto.pcode}'" width="20%"> 
				<div style="text-align:center;"> <img src="../resources/pageimg/${bestdto.pimg}" width="200" height="300"> </div> 
				<div> ${bestdto.title} </div>
				<c:if test="${bestdto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
				<div> ${bestdto.halin}%  <s> <fmt:formatNumber value="${bestdto.price}" type="number"/>원  </s></div> 
				</c:if> 
				<div> <fmt:formatNumber value="${bestdto.halinPrice}" type="number"/>원 </div>
				<div> ${bestdto.baeEx} </div>     
				<div style="letter-spacing:-4px"> 
				<c:forEach begin="1" end="${bestdto.ystar}">
				<img src="../resources/uploads/star1.png" width="10">
				</c:forEach>
				<c:if test="${bestdto.hstar==1}">
				<img src="../resources/uploads/star3.png" width="10">
				</c:if>
				<c:forEach begin="1" end="${bestdto.gstar}">
				<img src="../resources/uploads/star2.png" width="10">
				</c:forEach>
				</div>   
				<c:if test="${bestdto.juk!=0}"> <!-- 적립금이 있다면 -->   
				<div> 
				<span id="juk"> <img src="../resources/uploads/juk.png" width="10">  
				최대 <fmt:formatNumber value="${bestdto.jukPrice}" type="number"/>원 적립
				</span>
				</div>
				</c:if>
				</td>
        	</c:forEach>
        	</tr>
        </table>
        </section> <!-- 최다판매 -->
    </main>


</body>
</html>
