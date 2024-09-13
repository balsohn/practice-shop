<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	main {width:600px; margin:30px auto;}
	main div {width:600px;}
	main div input[type="text"] {width:600px; height: 30px; margin-top:20px;}
	main div textarea {width:600px; height: 300px; margin-top:20px;}
	main div input[type="submit"] {width:608px; height: 34px; margin-top:30px;}
</style>
<script>
	function chgStar(n) {
		var star=document.getElementsByClassName("star");
		
		for(i=0;i<n;i++){
			star[i].src="../resources/uploads/star1.png";
		}
		
		for(i=n;i<star.length;i++) {
			star[i].src="../resources/uploads/star2.png";
		}
		
		document.getElementsByName("star")[0].value=n;
	}
	
	function length1(my) {
		var text=document.getElementById("text");
		text.innerText=my.value.length;						
	}
</script>
</head>
<body>
	<main>
		<h2>리뷰 작성</h2>
		<form method="post" action="reviewOk">
		<input type="hidden" name="gumae_id" value="${id }">
		<input type="hidden" name="star" value="0">
		<div>
			<img src="../resources/uploads/star2.png" class="star" onclick="chgStar(1)">
			<img src="../resources/uploads/star2.png" class="star" onclick="chgStar(2)">
			<img src="../resources/uploads/star2.png" class="star" onclick="chgStar(3)">
			<img src="../resources/uploads/star2.png" class="star" onclick="chgStar(4)">
			<img src="../resources/uploads/star2.png" class="star" onclick="chgStar(5)">
		</div>
		<div><input type="hidden" name="pcode" value="${pcode}"></div>
		<div> 
			<input type="text" name="oneLine" oninput="length1(this)" maxlength="30">
			<br>(<span id="text">0</span>/30) 
		</div>
		<div> <textarea name="content"></textarea></div>
		<div> <input type="submit" value="리뷰 작성"></div>
		</form>
	</main>
</body>
</html>