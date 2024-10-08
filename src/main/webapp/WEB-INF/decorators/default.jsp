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
* { 
    margin:0; 
    padding:0; 
    box-sizing: border-box; 
    font-family: 'GmarketSansMedium';
}

#ads {
    width: 100%;
    height: 40px;
    background: purple;
}

#ads #first {
    width: 1100px;
    display: flex;
    justify-content:space-between;
    margin: auto;
    line-height: 40px;
    color: white;
}

#ads #first #right { 
    margin-right: 10px;
}

#ads #first #left { 
    margin-left: 10px;
}

header {
    position: relative;
    width: 1100px;
    height: 80px;
    display: flex;
    justify-content: space-between;
    margin: auto;
    padding: 0 30px;
}

.header-right {
	display:flex; 
	flex-direction:column; 
	justify-content: space-between; 
	align-items: flex-end; 
}

header #logo {    
    width: 80px;
    height: 80px;
}

.logo {
	width: 200px;
    position: relative;
    top: 50%;
    transform: translateY(-50%);
}
header #search {
    width: 300px;
    height: 40px;
    margin: auto;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    border: 2px solid purple;
    border-radius: 5px;
}

header #search #searchForm {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-right: 5px;
}

header #search #searchForm input {
    height: 30px;
    width: 90%;
    margin-left: 10px;
    border: none;
    outline: none;
}

header #search #searchForm #xx {
    visibility: hidden;
    cursor: pointer;
}

nav {
    width: 1100px;
    height: 50px;
    line-height: 50px;
    margin: auto;
    font-family: 'GmarketSansMedium';
    box-shadow: 0 1px 0 0;
}

/* 카테고리 메뉴 스타일 */
nav #mainMenu > li {
    position: relative;
    display: inline-block;
    width: 170px;
    height: 50px;
    line-height: 50px;
    text-align: center;
}

nav #mainMenu li a {line-height:1.3;}

nav #mainMenu > li:first-child {
    width: 220px;
    text-align: left;
}

nav #mainMenu > li ul {
    display: none; /* 기본적으로 숨김 */
    position: absolute;
    top: 50px;
    left: 0;
    background-color: #ffffff;
    border: 1px solid #ddd;
    min-width: 200px;
    z-index: 1000;
}

nav #mainMenu > li:hover > ul {
    display: block; /* 대분류 메뉴를 마우스 오버 시 표시 */
}

nav #mainMenu > li ul li {
    list-style: none;
    padding: 0; /* 패딩 제거 */
    text-align: left;
    background: white;
    cursor: pointer;
    position: relative;
}

nav #mainMenu > li ul li a {
    display: block;  /* 블록 요소로 설정 */
    width: 100%;     /* 부모 요소의 너비를 채움 */
    height: 100%;    /* 부모 요소의 높이를 채움 */
    padding: 10px;   /* 텍스트 주변에 여유 공간을 확보 */
    box-sizing: border-box; /* 패딩을 포함한 크기 계산 */
    color: inherit;  /* 부모의 글자색을 상속받음 */
    text-decoration: none;  /* 밑줄 제거 */
}

nav #mainMenu > li ul li:hover > ul {
    display: block; /* 중분류 메뉴를 마우스 오버 시 표시 */
}

nav #mainMenu > li ul li ul {
    display: none; /* 기본적으로 숨김 */
    position: absolute;
    top: 0;
    left: 100%;
    background-color: #ffffff;
    border: 1px solid #ddd;
    min-width: 150px;
}

nav #mainMenu > li ul li ul li {
    list-style: none;
    padding: 0; /* 패딩 제거 */
    background: white;
    cursor: pointer;
}

nav #mainMenu > li ul li ul li a {
    display: block;  /* 블록 요소로 설정 */
    width: 100%;     /* 부모 요소의 너비를 채움 */
    height: 100%;    /* 부모 요소의 높이를 채움 */
    padding: 10px;   /* 텍스트 주변에 여유 공간을 확보 */
    box-sizing: border-box; /* 패딩을 포함한 크기 계산 */
    color: inherit;  /* 부모의 글자색을 상속받음 */
    text-decoration: none;  /* 밑줄 제거 */
}

nav #mainMenu > li ul li ul li:hover {
    background-color: #f1f1f1; /* 호버 시 배경색 변경 */
}

footer {
    width: 1100px;
    height: 150px;
    margin: auto;
}

.header-right #myMenu {
    position: relative;
    cursor: pointer;
}

.header-right #myMenuList {
    display: none; /* 기본적으로 숨김 */
    position: absolute;
    top: 100%; /* 부모 요소 바로 아래에 위치 */
    right: 0; /* 부모 요소의 오른쪽에 맞춤 */
    background-color: white;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    list-style: none;
    padding: 10px 0;
    margin: 0;
    z-index: 1000;
}

.header-right #myMenuList li {
    padding: 10px 20px;
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
}

.header-right #myMenuList li:hover {
    background-color: #f1f1f1; /* 호버 시 배경색 변경 */
}
.cart a img {vertical-align:text-bottom;}

</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
var daeData, jungData, soData;

window.onload = function() {
    // dae 데이터를 가져오기
    var daeXhr = new XMLHttpRequest();
    daeXhr.onload = function() {
        daeData = JSON.parse(daeXhr.responseText);
        checkAndProcessData();  // dae 데이터를 가져온 후 호출
    };
    daeXhr.open("GET", "/main/getDae", true);
    daeXhr.send();

    // jung 데이터를 가져오기
    var jungXhr = new XMLHttpRequest();
    jungXhr.onload = function() {
        jungData = JSON.parse(jungXhr.responseText);
        checkAndProcessData();  // jung 데이터를 가져온 후 호출
    };
    jungXhr.open("GET", "/main/getJung", true);
    jungXhr.send();

    // so 데이터를 가져오기
    var soXhr = new XMLHttpRequest();
    soXhr.onload = function() {
        soData = JSON.parse(soXhr.responseText);
        checkAndProcessData();  // so 데이터를 가져온 후 호출
    };
    soXhr.open("GET", "/main/getSo", true);
    soXhr.send();
    
    var chk=new XMLHttpRequest();
    chk.onload=function() {
    	document.getElementById("cartNum").innerText=chk.responseText;
    }
    chk.open("get","../main/cartNum")
    chk.send();
    
    <c:if test="${param.order!=null}">
    document.getElementsByClassName("type")[${param.order}].style.color="red";
    </c:if>
    
    var topEQ="top=";
    var topCookie=document.cookie;
    var top=topCookie.substring(topEQ.length,topCookie.length);
    
    if(top==1) {
    	document.getElementById("ads").style.display="none";
    }
    
}

// 모든 데이터를 받은 후 처리하는 함수
function checkAndProcessData() {
    // 세 가지 데이터셋이 모두 로드되었는지 확인
    if (daeData && jungData && soData) {
        buildMenu(daeData, jungData, soData);
    }
}

// 메뉴를 구성하는 함수
function buildMenu(daeData, jungData, soData) {
    var daeMenu = document.createElement("ul");

    daeData.forEach(function(dae) {
        // 대분류 처리
        var daeLi = document.createElement("li");
        var daeLink = document.createElement("a");
        daeLink.textContent = dae.name;
        daeLink.setAttribute("href", "../product/productList?pcode=p"+dae.code); // 대분류 링크
        daeLi.appendChild(daeLink);

        var jungUl = document.createElement("ul");
        daeLi.appendChild(jungUl);
        daeMenu.appendChild(daeLi);
        
        // 중분류 처리
        jungData.forEach(function(jung) {
            if (jung.daecode === dae.code) { // 중분류가 대분류와 연결되는지 확인
                var jungLi = document.createElement("li");
                var jungLink = document.createElement("a");
                jungLink.textContent = jung.name;
                jungLink.setAttribute("href", "../product/productList?pcode=p"+dae.code+jung.code); // 중분류 링크
                jungLi.appendChild(jungLink);

                var soUl = document.createElement("ul");
                jungLi.appendChild(soUl);
                jungUl.appendChild(jungLi);

                // 소분류 처리
                soData.forEach(function(so) {
                    if (so.daejung === jung.daecode + jung.code) { // 소분류가 중분류와 연결되는지 확인
                        var soLi = document.createElement("li");
                        var soLink = document.createElement("a");
                        soLink.textContent = so.name;
                        soLink.setAttribute("href", "../product/productList?pcode=p"+dae.code+jung.code+so.code); // 소분류 링크
                        soLi.appendChild(soLink);
                        soUl.appendChild(soLi);
                    }
                });
            }
        });
    });

    document.querySelector("nav #mainMenu > li:first-child").appendChild(daeMenu);
}

function hideAds() {
	var ads=document.getElementById("ads");
	var hei=40;
	
	ss=setInterval(function(){
		hei--;
		
		ads.style.height=hei+"px";
		
		if(hei==0) {
			clearInterval(ss);
			ads.remove();
			
			document.cookie="top=1; Max-Age=10; path=/";
		}
		
	},10)
	
}
function viewsrc() {
	document.getElementById("aa").innerText=document.getElementsByTagName("body")[0].innerHTML;
}

function xCheck(n) {
	if(n.length!=0) {
		document.getElementById("xx").style.visibility="visible";
	} else {
		document.getElementById("xx").style.visibility="hidden";
	}
}

function hi() {
	document.getElementsByName("search")[0].value="";
}

function subgo() {
	document.getElementById("search").submit();
}


document.addEventListener("DOMContentLoaded", function() {
    var myMenu = document.getElementById("myMenu");
    var myMenuList = document.getElementById("myMenuList");

    myMenu.addEventListener("click", function() {
        // 드랍다운 메뉴의 표시/숨김 상태를 토글
        if (myMenuList.style.display === "block") {
            myMenuList.style.display = "none";
        } else {
            myMenuList.style.display = "block";
        }
    });

    // 클릭 외의 영역을 클릭하면 드랍다운 메뉴 숨김
    document.addEventListener("click", function(event) {
        if (!myMenu.contains(event.target)) {
            myMenuList.style.display = "none";
        }
    });
});


</script>
</head>
<sitemesh:write property="head"/>
<body>
<div id="aa"></div><button onclick="viewsrc()">ㅇㅇㅇ</button>
접속자수 : ${users } / ${names }
    <div id="ads">
        <div id="first">
	        <div id="left"></div>
	        <div id="center"> 회원가입하고 상품 첫 주문시 100만원 드립니다. </div>
	        <div id="right" onclick="hideAds()"> X </div>
        </div>
    </div>      
    <header>
        <div id="logo"><a href="../main/index"><img src="../resources/uploads/logo.png" class="logo"></a></div>
        <form method="get" action="../product/productList" id="search">
        <div id="search">
            <div id="searchForm">
                <input type="text" name="search" onkeyup="xCheck(this.value)">
                <img src="../resources/uploads/x.png" onclick="hi()" id="xx">
                <img src="../resources/uploads/s.png" onclick="subgo()">
            </div>
        </div>
        </form>
        <div class="header-right">
        	<div>
	           <c:if test="${empty userid}">
	           <a href="../member/member">회원가입</a> 
	           <a href="../login/login">로그인</a>
	           </c:if>
	           <c:if test="${!empty userid}">
	           ${userid}님
	           <span id="myMenu"> 나의 메뉴
			    <ul id="myMenuList">
			        <li><a href="../member/jjimList">찜리스트</a></li>
			        <li><a href="#">회원정보</a></li>
			        <li><a href="../member/jumunList">주문목록</a></li>
			        <li><a href="#">배송지관리</a></li>
			        <li><a href="#">배송지관리</a></li>
			        <li><a href="#">배송지관리</a></li>
			    </ul>
				</span>

	           <a href="../login/logout">로그아웃</a>
	           </c:if>
	           <a href="">고객센터</a>
            </div>
            <div class="cart">
            	<a href="../member/cartView"><img src="../resources/uploads/cart.png">(<span id="cartNum"></span>)</a>
            </div>
        </div>
    </header>

    <nav>
        <ul id="mainMenu">
            <li> 
				<span id="cate">
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
    <footer>
    	<img src="../resources/uploads/footer.png">
    </footer> <!-- 쇼핑몰 관련 정보 -->
</body>
</html>
