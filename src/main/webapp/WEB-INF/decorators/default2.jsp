<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 페이지</title>
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
        justify-content: space-between;
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

    header #logo {
        background: yellow;
        width: 80px;
        height: 80px;
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
        padding: 10px;
        text-align: left;
        background: white;
        cursor: pointer;
        position: relative;
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
        padding: 10px;
        background: white;
        cursor: pointer;
    }

    nav #mainMenu > li ul li ul li:hover {
        background-color: #f1f1f1; /* 호버 시 배경색 변경 */
    }

    footer {
        width: 1100px;
        height: 150px;
        margin: auto;
    }
</style>

<script>
window.onload = function() {
    var xhr = new XMLHttpRequest();
    xhr.onload = function() {
        var categories = JSON.parse(xhr.responseText);
        var daeMenu = document.createElement("ul");

        categories.forEach(function(category) {
            // 대분류 처리
            var daeLi = daeMenu.querySelector("li[data-dae-name='" + category.daeName + "']");
            if (!daeLi) {
                daeLi = document.createElement("li");
                daeLi.textContent = category.daeName;
                daeLi.setAttribute("data-dae-name", category.daeName);
                daeLi.appendChild(document.createElement("ul"));
                daeMenu.appendChild(daeLi);
            }

            // 중분류 처리
            var jungUl = daeLi.querySelector("ul");
            var jungLi = jungUl.querySelector("li[data-jung-name='" + category.jungName + "']");
            if (!jungLi) {
                jungLi = document.createElement("li");
                jungLi.textContent = category.jungName;
                jungLi.setAttribute("data-jung-name", category.jungName);
                jungLi.appendChild(document.createElement("ul"));
                jungUl.appendChild(jungLi);
            }

            // 소분류 처리
            var soUl = jungLi.querySelector("ul");
            var soLi = document.createElement("li");
            soLi.textContent = category.soName;
            soUl.appendChild(soLi);
        });

        document.querySelector("nav #mainMenu > li:first-child").appendChild(daeMenu);
    }
    xhr.open("GET", "/main/daejungso", true);
    xhr.send();
}
</script>
</head>
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

    <footer></footer> <!-- 쇼핑몰 관련 정보 -->
</body>
</html>
