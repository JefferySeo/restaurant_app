<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection"%>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null, pstmt2 = null, pstmt3 = null;
	String query = "", sql = "", sql2 = "";
	ResultSet rs = null, rs2 = null, rs3 = null;
%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	query = "select * from best_restaurant where num=?";
	conn = SQLConnection.initConnection();
	try{
		pstmt = conn.prepareStatement(query);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		if(rs.next()){
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Tilt+Prism&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/jquery.mobile-1.3.2.min.css">
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
    <div id="detail" data-role="page" data-theme="c">
    <%@ include file="include/header.jsp" %>
        <div data-role="content">
            <div id="brand">
                <h1><span>맛집</span> <span>검색</span></h1>
            </div>
            
            <div class="ui-grid-a" id="restau_infos">
                <div class="ui-block-a">
                    <h1><%= rs.getString("title") %></h1>
                    <p><%= rs.getString("sectordetail") %></p>
                    <p>On the menu : </p>
                    <ul>
                        <li>밀크쉐이크 50,000원</li>
                        <li>소고기 2,000원</li>
                        <li>물 4,000원</li>
                    </ul>
                </div>
                <div class="ui-block-b">
                	<input type="hidden" id="lat" value="<%=rs.getFloat("lat") %>"/>
                	<input type="hidden" id="lon" value="<%=rs.getFloat("lon") %>"/>
                    <div class="roadView2" id="roadView"></div>
                    <p><a href="#" rel="external" data-role="button"></a></p>
                </div>
            </div> <!-- /.grid-a -->
            <hr />
            <div class="ui-grid-a" id="contact_infos">
                <div class="ui-block-a">
                    <h2>Contact Us</h2>
                    <p>연락주시면 30분내로 달려갑니다. 지금 전화주세요. 예약문의도 환영합니다.</p>
                    <p>🐕‍🦺 초고속 배달 서비스 🐕‍🦺</p>
                </div>
                <div class="ui-block-b">
                    <div class="map" id="map">

                    </div>
                </div>
            </div><!-- /.grid-a -->
            <a href="tel:01076886905" data-role="button" class="ui-cellphone" data-icon="tel">전화주문(예약, 문의)</a>
        </div>
        <hr>
        <div id="notation">
            <label id="select"><h1>회원리뷰</h1></label>
            <%
            	int rnum = rs.getInt("num");
            	sql = "select * from review where rnum = ?";
            	pstmt2 = conn.prepareStatement(sql);
            	pstmt2.setInt(1, rnum);
            	rs2 = pstmt2.executeQuery();
            	
            	
            	
            	while(rs2.next()){
            		out.print(rs2.getString("content"));
            		sql2 = "select * from review where num = ?";
                	pstmt3 = conn.prepareStatement(sql2);
                	pstmt3.setInt(1, rs2.getInt("unum"));
                	rs3 = pstmt3.executeQuery();
            	}
            	
            %>
            <ul>
            	<li></li>
            </ul>
            <form name="reviewForm" id="reviewForm" method="post">
                <div>
                <select name="star" id="note_utilisateur" data-native-menu="false" data-theme="c">
                    <option value="1" class="one">별로입니다.</option>
                    <option value="2" class="two">쫌 별로입니다.</option>
                    <option value="3" class="three">무난합니다.</option>
                    <option value="4" class="four" selected>맛있습니다.</option>
                    <option value="5" class="five">존맛탱</option>
                </select>
                </div>
                <div>
                    하실말씀
                    <textarea name="content" class="contentbox" id="contentbox" rows="5"></textarea>
                </div>
                <button type="button" id="submit" data-role="button" data-icon="check" data-iconpos="right">전송</button>
				<input type="hidden" name="unum" value="<%=UNUM %>" />
				<input type="hidden" name="rnum" value="<%=num %>" />
            </form>
        </div>
        <%@ include file="include/footer.jsp" %>
    </div>

</body>
</html>
<%
		}
	}catch(SQLException e){
		
	}finally{
		if(rs != null) try{ rs.close();}catch(SQLException e){} 
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}
		if(conn != null) try{conn.close();}catch(SQLException e){}
		
	}
%>







