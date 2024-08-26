<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
       background: pink;
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
       height: 400px;
       margin: auto;
    }

    main #p1 { background: #abcdef; }
    main #p2 { background: #ab18ef; }
    main #p3 { background: #abcd12; }
    main #p4 { background: #abcdef; }

    footer {
       width: 1100px;
       height: 150px;
       margin: auto;
       background: black;
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
    });
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
        <section id="p1"></section>
        <section id="p2"></section>
        <section id="p3"></section>
        <section id="p4"></section>
    </main>

    <footer></footer>
</body>
</html>
