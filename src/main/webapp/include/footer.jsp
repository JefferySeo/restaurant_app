<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Enumeration"%>


<div data-role="footer" data-position="fixed">
	<div data-role="navbar" data-iconpos="bottom">
       <ul>
       <% if( UID !=null){ %>
	        <li><a href="logout.jsp" data-icon="edit" data-ajax="false">로그아웃</a></li>
	        <li><a href="memberlist.jsp" data-icon="edit">회원정보</a></li>
       <% }else{ %>
	        <li><a href="#popupLogin" data-rel="popup" data-position-to="window" data-role="button" data-inline="true" data-icon="check" data-transition="pop">로그인</a>
	        <li><a href="members.jsp" data-icon="edit">회원가입</a></li>
       <% } %>    

	        <li><a href="index.jsp" data-icon="home">메인페이지</a></li>
	        <li><a href="heart.jsp" data-icon="star">리뷰</a></li>
    	</ul>
	</div>
   <%
   		Enumeration params = request.getParameterNames();
   		String gparam = "";
   		while(params.hasMoreElements()){
   			String name = (String) params.nextElement();
   			gparam += name + "=" + request.getParameter(name) + "&";
   		}
   
   %>
   
	<div data-role="popup" id="popupLogin" data-theme="a" class="ui-corner-all">
		<form name="loginForm" action="loginok.jsp" id="loginForm" method="post" data-ajax="false">
	    	<div style="padding:10px 20px;">
	            <h3>Please sign in</h3>
	            <label for="un" class="ui-hidden-accessible">아이디:</label>
	            <p id="checkid" style="color:red; font-size:12px;"></p>
	            <input type="text" name="userid" id="un" placeholder="id" data-theme="a">
	            <label for="pw" class="ui-hidden-accessible">비밀번호:</label>
	            <p id="checkpass" style="color:red; font-size:12px;"></p>
	            <input type="password" name="userpass" id="pw" placeholder="password" data-theme="a">
	            <input type="hidden" name="rUrl" id="rUrl" value="<%=request.getRequestURI() %>" />
	            <input type="hidden" name="rParam" id="rParam" value="<%=gparam %>" />
	            <button type="submit" id="submitbtn" data-theme="b" data-icon="check">로그인</button>
	        </div>
	    </form>
	</div>
   
</div>
