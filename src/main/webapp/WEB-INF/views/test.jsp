<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>카테고리 페이지</title>
    <style>
        /* 위에서 정의한 CSS 스타일을 여기에 추가합니다 */
        nav {
            width: 300px;
            margin: 20px auto;
        }

        #cate {
            position: relative;
            display: inline-block;
        }

        .dropdown {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown a:hover {
            background-color: #f1f1f1;
        }

        #cate:hover .dropdown {
            display: block;
        }

        #daeMenu > li {
            position: relative;
        }

        #daeMenu > li > ul {
            display: none;
            position: absolute;
            left: 100%;
            top: 0;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        #daeMenu > li:hover > ul {
            display: block;
        }
    </style>
    <script>
        window.onload = function() {
            var xhr = new XMLHttpRequest();
            xhr.onload = function() {
                var categories = JSON.parse(xhr.responseText);
                var daeMenu = document.getElementById("daeMenu");
                var currentDae = "";
                var currentJung = "";
                var currentJungUl = null;

                categories.forEach(function(category) {
                    // 대분류 처리
                    if (category.daeName !== currentDae) {
                        currentDae = category.daeName;
                        currentJung = ""; // 대분류가 바뀔 때마다 중분류 초기화

                        var daeLi = document.createElement('li');
                        daeLi.textContent = category.daeName;
                        daeMenu.appendChild(daeLi);

                        var jungUl = document.createElement('ul');
                        daeLi.appendChild(jungUl);
                        currentJungUl = jungUl;
                    }

                    // 중분류 처리 (중복 제거)
                    if (category.jungName !== currentJung) {
                        currentJung = category.jungName;

                        if (currentJungUl && category.jungName) {
                            var jungLi = document.createElement('li');
                            jungLi.textContent = category.jungName;
                            currentJungUl.appendChild(jungLi);

                            var soUl = document.createElement('ul');
                            jungLi.appendChild(soUl);

                            // 소분류 처리
                            if (category.soName) {
                                var soLi = document.createElement('li');
                                soLi.textContent = category.soName;
                                soUl.appendChild(soLi);
                            }
                        }
                    } else {
                        // 소분류만 추가 (중분류가 중복된 경우)
                        var lastJungLi = currentJungUl.lastChild;
                        var soUl = lastJungLi.querySelector('ul');
                        if (soUl && category.soName) {
                            var soLi = document.createElement('li');
                            soLi.textContent = category.soName;
                            soUl.appendChild(soLi);
                        }
                    }
                });
            }
            xhr.open("GET", "/main/daejungso", true);
            xhr.send();
        }
    </script>
</head>
<body>
    <nav>
        <ul id="mainMenu">
            <li>
                <span id="cate">
                    카테고리
                    <ul id="daeMenu" class="dropdown"></ul>
                </span>
            </li>
        </ul>
    </nav>
</body>
</html>

