<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="java.sql.*, java.net.*, java.time.*, java.time.format.DateTimeFormatter, myRest.SQLConnection"    
	
%>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	InetAddress local = null;
	String ip = "", sql = "";
	int rows = 0;
%>    

<jsp:useBean id="mem" class="myRest.MemberDto" scope="page" />
<jsp:setProperty name="mem" property="*" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
		// IP주소 받기
		try{
			local = InetAddress.getLocalHost();
		}catch(UnknownHostException e){
			
		}
		if(local != null){
			ip = local.getHostAddress();
		}
		// out.println(ip);
		
		// 현재 날짜 받기 LocalDateTime을 이용해 년월일시분초를 받은 후 
		// DateTimeFormatter를 이용해 YYYY-MM-DD  hh:mm:ss 형태로 변환
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String writeday = now.format(formatter);
		// out.println(writeday);
		
		// 배열로 받은 hobby를 하나로 합침
		String[] hobby = mem.getHobby();
		String strHobby = "";
		for(String h : hobby){
			strHobby += h + " ";
		}
		sql = "insert into members (";
		sql += "username, userid, userpass, gender, postcode, address, detailAddress, job, hobby, leftright, writeday, writeip ";
		sql += ") values (?,?,?,?,?,?,?,?,?,?,?,?)";
	
		// 접속
		conn = SQLConnection.initConnection();
		
		try{
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, mem.getUsername());
			pstmt.setString(2, mem.getUserid());
			pstmt.setString(3, mem.getUserpass());
			pstmt.setString(4, mem.getGender());
			pstmt.setInt(5, mem.getPostcode());
			pstmt.setString(6, mem.getAddress());
			pstmt.setString(7, mem.getDetailAddress());
			pstmt.setString(8, mem.getJob());
			pstmt.setString(9, strHobby);
			pstmt.setString(10, mem.getLeftright());
			pstmt.setString(11, writeday);
			pstmt.setString(12, ip);
			
			System.out.println(pstmt);
			
			rows = pstmt.executeUpdate();
			if(rows > 0){
				out.println("정보를 입력 했습니다.");
			}
			
			pstmt.close();
			
		}catch(SQLException e){
			
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(SQLException e){
					
				}
			}
		}
	
	%>

<%-- 

	이름 : <jsp:getProperty property="username" name="mem"/><br>
	id : <jsp:getProperty property="userid" name="mem"/><br>
	pw : <jsp:getProperty property="userpass" name="mem"/><br>
	성별 : <jsp:getProperty property="gender" name="mem"/><br>
	우편번호 : <jsp:getProperty property="postcode" name="mem"/><br>
	주소 : <jsp:getProperty property="address" name="mem"/><br>
	상세주소 : <jsp:getProperty property="detailAddress" name="mem"/><br>
	직업 : <jsp:getProperty property="job" name="mem"/><br>
	취미 : <jsp:getProperty property="hobby" name="mem"/><br>
	좌우명 : <jsp:getProperty property="leftright" name="mem"/><br> 
--%>
</body>
</html>