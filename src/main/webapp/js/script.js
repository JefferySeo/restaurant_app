function checkForm(){
	const frm = document.memberform;
	if(frm.username.value == ""){
		frm.username.focus();
		alert("이름을 입력하세요.")
		return false;
	}
	if(frm.userid.value == ""){
		frm.userid.focus();
		alert("아이디를 입력하세요.")
		return false;
	}
	if(frm.idok.value == ""){
		alert("아이디 중복을 확인해주세요.")
		return false;
	}
	if(frm.userpass.value == ""){
		frm.userpass.focus();
		alert("비밀번호를 입력하세요.")
		return false;
	}
	if(frm.postcode.value == ""){
		frm.postcode.focus();
		alert("주소를 입력하세요.")
		return false;
	}
	if(frm.job.value == ""){
		frm.job.focus();
		alert("직업을 선택하세요.")
		return false;
	}
}

function checkEdtForm(){
	const frm = document.memberedit;
	if(frm.username.value == ""){
		frm.username.focus();
		alert("이름을 입력하세요.")
		return false;
	}
	if(frm.postcode.value == ""){
		frm.postcode.focus();
		alert("주소를 입력하세요.")
		return false;
	}
	if(frm.job.value == ""){
		frm.job.focus();
		alert("직업을 선택하세요.")
		return false;
	}
}



function idCheck(){
	
	const uid = document.getElementById("userid").value;
	
	let url = "idcheck.jsp?uid="+uid;
	let name = "증복체크";
	let option = "width=500, height=300, resizable=no, menubar=no, status=no, toolbar=0, top=300, left=700";
	window.open(url, name, option);
}






