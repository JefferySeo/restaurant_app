<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection"%>
    <jsp:useBean id="mem" class="myRest.MemberDto"/>
    <jsp:setProperty name="mem" property="*"/>
    <%!
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "";
    %>
    

<!DOCTYPE html>
<html lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>맛집검색</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Tilt+Prism&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/jquery.mobile-1.3.2.min.css">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	2e25fc5a61c305966cb12ffd1d8f5c65"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>   
    <script src="js/jquery-1.12.4.min.js"></script>
    <script src="js/jquery.mobile-1.3.2.min.js"></script>
    <script src="js/script.js"></script>
    <script src="js/members.js"></script>
    <script src="js/custom.js"></script>

</head>
<body>

    <div id="memberlist" data-role="page" data-theme="c">
    <%@ include file="include/header.jsp" %>
    <!-- 팝업 -->
		<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:99;-webkit-overflow-scrolling:touch;">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
		</div>
	<!-- /팝업 -->
    <%
    	if(UNUM == 0){
    %>
    	<script>
    		alert("에러가 발생했습니다.");
    		document.location.href = "index.jsp";
    	</script>
    
    <%		
    		return;
    	}else{
    		conn = SQLConnection.initConnection();
    		sql = "select * from members where num = ?";
    		
    		try{
    			pstmt = conn.prepareStatement(sql);
    			pstmt.setInt(1, UNUM);
    			rs = pstmt.executeQuery();
    			if(rs.next()){
    				
    			
    		
    %>
        <div data-role="content">
        	<div data-role="content">
	        	<form action="memberedit.jsp" name="memberedit" id="memberedit" method="post" onSubmit="return checkEdtForm()">
	        		<ul data-role="listview" data-inset="true" data-divider-theme="d">
	        			<li data-role="list-divider">필수항목</li>
	        			<li data-role="fieldcontain">
	        				<label for="username">이름</label>
	        				<input type="text" name="username" id="username" value="<%=rs.getString("username") %>" data-clear-btn="true"/>
	        			</li>
	        			<li data-role="fieldcontain">
	        				<label for="userid">아이디</label>
	        				<input type="text" name="userid" id="userid" value="<%=rs.getString("userid") %>" readonly/>
	        			</li>
	        			<li data-role="fieldcontain">
	        				<label for="userpass">비밀번호</label>
	        				<input type="text" name="userpass" id="userpass" value="" data-clear-btn="true"/>
	        			</li>
	        			
	        			<li data-role="fieldcontain">
	        				<label for="postcode">우편번호</label>
				            <input type="number" name="postcode" id="postcode" value="<%=rs.getInt("postcode") %>" data-clear-btn="true" />
	        			</li>
	        			<li data-role="fieldcontain" id="addressbox">
	        				<label for="address">주소</label>
	        				<input type="text" name="address" id="address" value="<%=rs.getString("address") %>" readonly/>
	        				<input type="text" name="detailAddress" id="detaulAddress" value="<%=rs.getString("detailAddress") %>" data-clear-btn="true"/>
	        			</li>
	        			<li data-role="list-divider">선택항목</li>
	        			<%
	        				String chk1 = "", chk2 = "";
	        				if(rs.getString("gender").equals("man")){
	        					chk1 = "selected";
	        					chk2 = "";
	        				}else{
	        					chk1 = "";
	        					chk2 = "selected";
	        				}
	        			
	        			%>
	        			<li data-role="fieldcontain">
	        				<label for="gender" class="ui-input-text" id="genderlabel">성별</label> 
							<select name="gender" id="gender" data-role="slider">
								<option value="man" <%= chk1 %>>남자</option>
								<option value="woman" <%= chk2 %>>여자</option>
	                  		</select>
	        			</li>
	        			
	        			<%
	        				String[] jobArray = {"프론트엔드 프로그래머", "백엔드 프로그래머", "풀스택 프로그래머", "UI 디자이너", "입만 프로그래머"};
	        			    String[] hobbyArray = {"야구", "축구", "수영", "러닝", "등산"};   	
	        			    String[] hobbyArray2 = {"baseball", "soccer", "swim", "running", "climbing"};  
	        			%>
	        			<li data-role="fieldcontain">
	        				<label id="radiobox">직업</label> 
							<fieldset data-role="controlgroup">
							<%
								int i = 1;
								for(String jobs : jobArray){
									if(rs.getString("job").equals(jobs)){
										out.println("<input type='radio' name='job' id='job" + i + "' value='" + jobs + "' checked>");
										out.println("<label for='job" + i + "'>" + jobs + "</label>");
									}else{
										out.println("<input type='radio' name='job' id='job" + i + "' value='" + jobs + "'>");
										out.println("<label for='job" + i + "'>" + jobs + "</label>");
									}
									i++;
								}
							%>
							</fieldset> 
	        			</li>
	        			<%
	        			/*
	        				contains => true, false
	        				indexOf => 문자위치, -1
	        				matches => 정규식 이용 문자열 검색 = true, false
	        			*/
	        			%>
	        			<li data-role="fieldcontain">
	        				<label id="radiobox">취미</label> 
							<fieldset data-role="controlgroup">
							
							<%
								i = 0;
								for(String hobbys : hobbyArray){
									if(rs.getString("hobby").equals(hobbys)){
										out.println("<input type='checkbox' name='hobby' id='" + hobbyArray2[i] + "' value='" + hobbys + " checked'>");
										out.println("<label for='" + hobbyArray2[i] + "'>" + hobbys + "</label>");
									}else{
										out.println("<input type='checkbox' name='hobby' id='" + hobbyArray2[i] + "' value='" + hobbys + "'>");
										out.println("<label for='" + hobbyArray2[i] + "'>" + hobbys + "</label>");
									}
									i++;
								}
							%>
							
						    
							</fieldset> 
	        			</li>
	        			<li data-role="fieldcontain">
	        				<label for="leftright">좌우명</label>
	        				<input type="text" name="leftright" id="leftright" value="<%=rs.getString("leftright") %>" data-clear-btn="true" />
	        			</li>
	        		</ul>
	        		<div class="btnbox">
	        			<button type="submit" class=submit> 수정 </button>
	        		</div>
	        		<input type="hidden" name="num" value="<%=UNUM %>"/>
        		</form>
        	</div>
        	
        	
        	
        	
        	
        </div>
   <%
    		}  // try 안에 if문
    	}catch(Exception e){} finally{
    		if(rs != null) try{ rs.close(); } catch(SQLException e){}
	        if(pstmt != null) try{pstmt.close(); } catch(SQLException e){}
	        if(conn != null) try{ conn.close(); } catch(SQLException e){}
    	}
   } // else
   %>
   <%@ include file="include/footer.jsp" %>
   </div>
   
   
   </body>
</html>


