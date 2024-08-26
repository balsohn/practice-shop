<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
	* { margin:0; padding:0; box-sizing: border-box; font-family: 'GmarketSansMedium';}
	#ads {
		width: 100%;
		height: 40px;
		background: purple;
		
	}
	#ads #first {
		width: 1100px;
		display: flex;
		justify-content: space-between;
		margin: auto;
		line-height: 40px;
		color:white;
	}
	#ads #first #right { margin-right: 10px;}
	#ads #first #left { margin-left: 10px;}
	
	header {
		position: relative;
	   width:1100px;
	   height:80px;
	   display: flex;
	   justify-content: space-between;
	   margin:auto;
	   padding: 0 30px;
	}
	header #logo {background: yellow; width:80px; height: 80px;}
	header #search {width:300px; height: 40px; margin:auto; position: absolute;
					left:50%;top:50%; transform: translate(-50%, -50%); border:2px solid purple; border-radius: 5px;}
					
	header #search #searchForm {display: flex; justify-content: space-between; align-items: center; margin-right: 5px;}
	header #search #searchForm input { height: 30px; width: 90%; margin-left: 10px;border: none; outline: none;}
	header #search #searchForm #xx {visibility: hidden; cursor: pointer}
	
   nav {
      width:1100px;
      height:50px;
      line-height:50px;
      margin:auto;
      font-family:'GmarketSansMedium';
   }
   nav #cate {  /* 카테고리메뉴 */
      position:relative;
      display:block;
      width:90px;
      height:58px;
   }
   nav #daeMenu {  /* ul */
      position:absolute;
      left:-6px;
      top:50px;
      padding-left:0px;
      width:100px;
      height:210px;
      background:white;
      display:none;
   }
   nav #daeMenu > li {
      list-style-type:none;
      width:100px;
      height:30px;
      line-height:30px;
      text-align:center;
      background:white;
      cursor:pointer;
      position:relative;
   }
   nav #daeMenu > li .jungMenu {
		position:absolute;
		left:100px;
		top:0px;
   }
   
   nav #daeMenu > li .jungMenu > li {
   
   }
   
   nav > #mainMenu {  
      padding-left:0px;
   }
   nav > #mainMenu > li {
      list-style-type:none;
      display:inline-block;
      width:170px;
      height:50px;
      line-height:50px;
      text-align:center;
   }
   nav > #mainMenu > li:first-child {
      width:220px;
      text-align:left;
   }
   footer {
      width:1100px;
      height:150px;
      margin:auto;
    }
</style>
 <script>
   function xCheck(val)
   {
	  if(val.length==0)
      {
		  document.getElementById("xx").style.visibility="hidden";
      }		
	  else
	  {
		  document.getElementById("xx").style.visibility="visible";
	  }	  
   }
   
   function clearTxt()
   {
	   document.getElementById("searchTxt").value="";
	   xCheck("");
   }
   
   // dae테이블에서 대분류메뉴읽어오기
   mchk=0;
   function viewMenu()
   {
	     document.getElementById("daeMenu").style.display="block"; // 대분류메뉴 보이기
	       
	     if(mchk==0) // 한번만 실행
	     {  
		   var chk=new XMLHttpRequest();
		   chk.onload=function()
		   {
			   //alert(chk.responseText);
			   var daeAll=JSON.parse(chk.responseText);
			   var str="";
			   for(dae of daeAll)
			   {
				   str=str+"<li onmouseover='jungView("+dae.code+")' onmouseout='jungHide("+dae.code+")'> "+dae.name+" <ul class='jungMenu'> </ul> </li>";
			   }	  
			   document.getElementById("daeMenu").innerHTML=str;
 
		   }
		   chk.open("get","../main/getDae");
		   chk.send();
		   mchk++;
	     }
   }
   function hideMenu()
   {
 
	   document.getElementById("daeMenu").style.display="none";
   }
  
   function jungView(daecode) // 중분류의 레코드들을 가져와서 중분류의 메뉴를 출력
   {
	   var chk=new XMLHttpRequest();
	   chk.onload=function()
	   {
		   var jungAll=JSON.parse(chk.responseText);
		   var str="";
		   for(jung of jungAll) {
			   str="<li>"+jung.name+"</li>";
		   }
		   document.getElementsByClassName("jungMenu")[daecode-1].innerHTML=str;
	   }
	   chk.open("get","getJung?daecode="+daecode);
	   chk.send();
   }
   function jungHide(daecode)
   {
	   document.getElementsByClassName("jungMenu")[daecode-1].style.display="none";
   }
   
   function viewSrc()
   {
	   document.getElementById("src").innerText=document.getElementsByTagName("html")[0].innerHTML;
   }
 </script>
</head>
 <sitemesh:write property="head"/>
<body>
	<div id="ads">
		<div id="first">
			<div id="left"></div>
			<div id="center"> 회원가입하고 상품 첫 주문시 100만원 드립니다. </div>
			<div id="right"> X </div>
		</div>
	</div>		
	<header>
		<div id="logo"><img src=""></div>
		<div id="search">
			<div id="searchForm">
				<input type="text" name="search" onkeyup="xCheck(this.value)">
				<img src="../resources/uploads/x.png" id="xx">
				<img src="../resources/uploads/s.png">
			</div>
		</div>
		<div> 
			<c:if test="${empty userid}">
			<a href="../member/member">회원가입</a> 
			<a href="../login/login">로그인</a>
			</c:if>
			<c:if test="${!empty userid}">
			<a href="../member/member">${userid}님</a> 
			<a href="../login/logout">로그아웃</a>
			</c:if>
			<a href="">고객센터</a>
		</div>
	</header>
	
	
	<nav>
     <ul id="mainMenu">
       <li> 
         <span id="cate" onmouseover="viewMenu()" onmouseout="hideMenu()">
            <img src="../resources/uploads/3.png" valign="middle"> 카테고리 
            <ul id="daeMenu"></ul>
         </span> 
         
       </li>
       <li> 신상품 </li>
       <li> 특가상품 </li>
       <li> 베스트 </li>
       <li> 이벤트 </li>
       <li> 일일특가 </li>
     </ul>
	</nav>
	
	<sitemesh:write property="body"/>

	<footer></footer> <!-- 쇼핑몰관련정보 -->
</body>
</html>