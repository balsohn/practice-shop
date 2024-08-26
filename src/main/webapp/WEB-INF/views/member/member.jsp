<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section { width:400px; margin:auto;}
	#txt {width: 100%; padding: 5px; margin-top:10px;}
	#txt2 {width: 31%; padding:5px; margin-top:10px;}
	#chkpwd1, #chkpwd2 {font-size:12px; color:red;}
	#btn {border:none; width:120px; height: 30px; background: purple; color: white; margin-top:20px;}
</style>
<script>
	var idchkvalue=1;
	var pwdchkvalue=1;

	function useridchk(userid) {
		var chk=new XMLHttpRequest();
		chk.onload=function() {
			var result=chk.responseText;
			var chkid=document.getElementById("chkid");
			if(userid.length < 6) {
				chkid.innerText="아이디는 6글자 이상입니다.";
				chkid.style.fontSize="12px";
				chkid.style.color="red";
				idchkvalue=1;
			} else {
				chkid.innerText="";
				if(result==0) {
					chkid.innerText="사용 가능한 아이디입니다.";
					chkid.style.fontSize="12px";
					chkid.style.color="blue";
					idchkvalue=0;
				} else {
					chkid.innerText="중복된 아이디입니다.";
					chkid.style.fontSize="12px";
					chkid.style.color="red";
					idchkvalue=1;
				}
			}
		}
		chk.open("get","useridChk?userid="+userid);
		chk.send();
	}
	
	function pwdchk() {
		var pwd1=document.mform.pwd.value;
		var pwd2=document.mform.pwd2.value;
		var msgpwd1=document.getElementById("chkpwd1");
		var msgpwd2=document.getElementById("chkpwd2");
		
		if(pwd2=="") {
			if(pwd1.length<6) {
				msgpwd1.innerText="6글자 이상";
			} else {
				msgpwd1.innerText="";
			}
		} else {
			if(pwd1!=pwd2) {
				msgpwd2.innerText="비밀번호가 일치하지 않습니다.";
			}
		}
	}

	
	function emailadd(addr) {
		if(addr=="") {
			document.mform.e2.value=addr;
			document.mform.e2.readOnly=false;			
		} else {
			document.mform.e2.value=addr;
			document.mform.e2.readOnly=true;
			
		}
	}
	
	  function check()
	  {
		  var email=document.mform.e1.value+"@"+document.mform.e2.value;
		  document.mform.email.value=email;
		  
		  if(uchk==0)
		  {
			  alert("아이디를 체크하세요");
			  return false;
		  }	  
		  else if(document.mform.name.value=="")
			   {
			       alert("이름을 입력하세요");
			       return false;
			   }
		       else if(pchk==0)
		    	    {
		    	        alert("비밀번호 체크하세요");
		    	        return false;
		    	    }
		            else
	 	            {
			           return true;
	 	            }	   
	  }
</script>
</head>
<body>
	<section>
		<form method="post" action="memberOk" name="mform" onsubmit="return check()">	
		<input type="hidden" name="email">
			<div><input type="text" name="userid" id="txt" placeholder="아이디" oninput="useridchk(this.value)"> </div>
			<div id="chkid"></div>
			<div><input type="text" name="name" id="txt" placeholder="이름"> </div>
			<div> <input type="password" name="pwd" id="txt" placeholder="비밀번호" oninput="pwdchk()"> </div>
			<div id="chkpwd1"></div>
			<div> <input type="password" name="pwd2" id="txt" placeholder="비밀번호 확인" oninput="pwdchk()"> </div>
			<div id="chkpwd2"></div>
			<div>
				<input type="text" name="e1" id="txt2">@<input type="text" name="e2" id="txt2">
				<select id="txt2" onchange="emailadd(this.value)">
					<option value=""> 직접입력 </option>
					<option value="naver.com">네이버</option>
					<option value="daum.net">다음</option>
					<option value="google.com">구글</option>
					<option value="hotmail.com">핫메일</option>
					<option value="channy.com">차니</option>
				</select>
				<div> <input type="text" name="phone" id="txt" placeholder="전화번호"> </div>
				<div align="center"> <input type="submit" value="회원가입" id="btn"></div>
			</div>
		</form>
	</section>
</body>
</html>