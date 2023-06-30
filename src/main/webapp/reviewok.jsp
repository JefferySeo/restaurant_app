<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="java.sql.*, java.net.*, myRest.SQLConnection"    
	
%>

<jsp:useBean id="rv" class="myRest.ReviewDTO" scope="page" />
<jsp:setProperty name="rv" property="*" />

<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	InetAddress local = null;
	String ip = "", sql = "";

%>    

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

		sql = "insert into review (rnum, unum, star, content, writeip) values (?,?,?,?,?)";
	
		// 접속
		conn = SQLConnection.initConnection();
		
		try{
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, rv.getRnum());
			pstmt.setInt(2, rv.getUnum());
			pstmt.setInt(3, rv.getStar());
			pstmt.setString(4, rv.getContent());
			pstmt.setString(5, ip);
			
			// System.out.println(pstmt);
			
			int rows = pstmt.executeUpdate();
			if(rows > 0){
				out.print(rv.getRnum());
			}else{
				out.print(0);
			}
			
		}catch(SQLException e){
			
		}finally{
			if(conn != null)try{conn.close();}catch(SQLException e){}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
		}
	
	%>











