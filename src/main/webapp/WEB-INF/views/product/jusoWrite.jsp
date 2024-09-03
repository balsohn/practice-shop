<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>         
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
  function juso_search()  // 우편번호 버튼 클릭시 호출 함수명
  {
    new daum.Postcode({
        oncomplete: function(data) {
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
              addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
              addr = data.jibunAddress;
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.pkc.zip.value = data.zonecode; // 우편번호
          document.pkc.juso.value = addr;  // 주소
          // 커서를 상세주소 필드로 이동한다.
          document.pkc.jusoEtc.focus();
      }
    }).open();
  }
 </script> 
</head>
<body>
	<form method="post" action="jusoWriteOk" name="pkc">
		<input type="hidden" name="tt" value="${param.tt}">
		<h3>배송지 등록</h3>
		<div> <input type="text" name="name" placeholder="받는사람"> </div>
		<div> <input type="text" name="zip" readonly placeholder="우편번호"> <input type="button" value="주소검색" onclick="juso_search()"> </div>
		<div> <input type="text" name="juso" readonly placeholder="주소"> </div>
		<div> <input type="text" name="jusoEtc" placeholder="나머지 주소"> </div>
		<div> <input type="text" name="phone" placeholder="받는사람 번호"> </div>
		<div> 
		<select name="req">
			<option value="0"> 문 앞 </option>
			<option value="1"> 직접받고 부재시 문앞</option>
			<option value="2"> 경비실 </option>
			<option value="3"> 택배함 </option>
			<option value="4"> 공동현관 앞 </option>
		</select>
		</div>
		<div>
			<label><input type="checkbox" name="gibon" value="1" ${param.tt==null?'checked':'' }> 기본 배송지로 지정</label>
		</div>
		<div> <input type="submit" value="주소등록"> </div>
	</form>
</body>
</html>