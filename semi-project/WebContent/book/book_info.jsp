<%@page import="java.net.URLEncoder"%>
<%@page import="review.dao.ReviewDao"%>
<%@page import="review.dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@page import="book.dto.BookDto"%>
<%@page import="book.dao.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/blog.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/book_info.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/scroll.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css" />
</head>


<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("bnum"));
	BookDao dao = BookDao.getInstance();
	BookDto dto = dao.getData(num);
	String id = (String) session.getAttribute("id");
	
	if(id == null) {
		id="";
	}

	//한 페이지에 나타낼 row 의 갯수
	final int PAGE_ROW_COUNT = 5;

	//보여줄 페이지의 번호
	int pageNum = 1;

	//보여줄 페이지 데이터의 시작 ResultSet row 번호
	int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;

	//보여줄 페이지 데이터의 끝 ResultSet row 번호
	int endRowNum = pageNum * PAGE_ROW_COUNT;

	//전체 row 의 갯수를 읽어온다.
	int totalRow = ReviewDao.getInstance().getCount(num);
	
	//전체 페이지의 갯수 구하기
	int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
	System.out.println(totalPageCount);
	System.out.println(totalRow);
	ReviewDto rdto = new ReviewDto();
	rdto.setBnum(num);
	rdto.setStartRowNum(startRowNum);
	rdto.setEndRowNum(endRowNum);

	//1. DB 에서 글 목록을 얻어온다.
	List<ReviewDto> list = ReviewDao.getInstance().getListb(rdto);
%>
<body>
	<!-- 헤더 -->
	<header>
		<jsp:include page="../include/header.jsp">
			<jsp:param value="0" name="nav_index"/>
		</jsp:include>
	</header>
	<div id="container">
		<!-- 메뉴바 -->
		<div class="nav-scroller py-1 mb-2"></div>
	</div>
	<!--이미지 col-6 -->
	<div class="container card">
		<div class="row">
			<div>
				<a id="backBtn" class="float-right mr-2" href="${pageContext.request.contextPath}/book/book_list.jsp"> 
					<svg class="mt-2 mb-sm-4" width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-box-arrow-left" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						<path fill-rule="evenodd" d="M4.354 11.354a.5.5 0 0 0 0-.708L1.707 8l2.647-2.646a.5.5 0 1 0-.708-.708l-3 3a.5.5 0 0 0 0 .708l3 3a.5.5 0 0 0 .708 0z" />
						<path fill-rule="evenodd" d="M11.5 8a.5.5 0 0 0-.5-.5H2a.5.5 0 0 0 0 1h9a.5.5 0 0 0 .5-.5z" />
						<path fill-rule="evenodd" d="M14 13.5a1.5 1.5 0 0 0 1.5-1.5V4A1.5 1.5 0 0 0 14 2.5H7A1.5 1.5 0 0 0 5.5 4v1.5a.5.5 0 0 0 1 0V4a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v8a.5.5 0 0 1-.5.5H7a.5.5 0 0 1-.5-.5v-1.5a.5.5 0 0 0-1 0V12A1.5 1.5 0 0 0 7 13.5h7z" />
					</svg>
				</a>
			</div>
			<div class="col-sm-auto">
				<img id="bookImg"src="<%=dto.getBimg()%>" alt="bookimg" class="my-4 ml-xl-5 ml-sm-3 border border-success" />	
				<a id ="bookMarkBtn" class="btn mt-2 py-1 float-right" >
					<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-bookmark-plus" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						<path fill-rule="evenodd" d="M4.5 2a.5.5 0 0 0-.5.5v11.066l4-2.667 4 2.667V8.5a.5.5 0 0 1 1 0v6.934l-5-3.333-5 3.333V2.5A1.5 1.5 0 0 1 4.5 1h4a.5.5 0 0 1 0 1h-4zm9-1a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V1.5a.5.5 0 0 1 .5-.5z"/>
						<path fill-rule="evenodd" d="M13 3.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z"/>
					</svg>
				</a>
			</div>
			<!-- 책정보 col-6 -->
			<div class="col-sm-auto ">
				<div class="right">
					<h2>
						<strong><%=dto.getBname()%></strong>
					</h2>
					<p class="border-bottom border-success"><%=dto.getBcompany()%>,
						<%=dto.getBdate()%></p>
					
						<h3>책소개</h3>
						<div style="font-size: 13px" id="story" class="scroll-slim mb-1"><%=dto.getBstory().replace("*", "<br/>")%></div>
						
					<!-- 리뷰테이블 -->
					<h3 class="border-bottom border-success">
						리뷰
						<!-- loding 아이콘 -->
						<span class="loader">
							<img src="${pageContext.request.contextPath}/image/ajax-loader.gif" />
						</span>
						<a href="../review/review_write.jsp?bnum=<%=num%>"class="float-right font-weight-bold" style="font-size: 11px; margin-top:5px; color:tomato;">
							<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-pencil mr-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd" d="M11.293 1.293a1 1 0 0 1 1.414 0l2 2a1 1 0 0 1 0 1.414l-9 9a1 1 0 0 1-.39.242l-3 1a1 1 0 0 1-1.266-1.265l1-3a1 1 0 0 1 .242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z"/>
							  <path fill-rule="evenodd" d="M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 0 0 .5.5H4v.5a.5.5 0 0 0 .5.5H5v.5a.5.5 0 0 0 .5.5H6v-1.5a.5.5 0 0 0-.5-.5H5v-.5a.5.5 0 0 0-.5-.5H3z"/>
							</svg>
						</a>
					</h3>
					<div id="reviewList" style="width: 460px; overflow-y: scroll; height: 248px;">
						<table id="reviewTable" class="table border-bottom" style="font-size: 13px;" >
							<thead class="thead border-bottom">
								<tr>
									<th>아이디</th>
									<th>제목</th>
									<th>별점</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
								<%for (ReviewDto tmp : list) {%>
									<tr class="reviewBtn" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
										<input type="hidden" id="rnum" value="<%=tmp.getRnum()%>" />
										<td><%=tmp.getUser_id()%></td>
										<td class="nameContent"><%=tmp.getRname()%></td>
										<td><%=tmp.getRscore()%>/5</td>
										<td><%=tmp.getRdate()%></td>
									</tr>
								<%}%>
							</tbody>
						</table>				
						<!-- 리뷰 더보기 버튼 -->
						<div class="text-center">
							<button id="more" class="btn btn-light-sm ">더보기</button>
						</div>
						<!-- 모달 -->
						<jsp:include page="modal.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="../include/footer.jsp"></jsp:include>
	
	
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/js/review.js"></script>
	<script src="${pageContext.request.contextPath}/js/book_info.js"></script>
	<script src="${pageContext.request.contextPath}/js/header.js"></script>
	
	<!--modal 내용불러오기 -->
	<script>
			$(".reviewBtn").on("click",function() {
				var rnum=$(this).children("#rnum").val();
				
				$.ajax({
					"method":"post",
					"url":"viewReview.jsp",
					"data":"rnum="+rnum,
					"success": function(data) {
						$(".modal-content").html(data);
					},
					"error": function(a,b,c) {
						console.log(a+" "+b+" "+c);
					}
				});
			});
			
			
	</script>
	<!-- review 페이징 처리 -->
	<script>
	var currentPage = 1;
	//전체 페이지의 수를 javascript 변수에 담아준다.
	var totalPageCount =<%=totalPageCount%>;
	$(".loader").hide();
	//웹브라우저에 scoll 이벤트가 일어 났을때 실행할 함수 등록 
	$("#more").on("click", function() {
	var displayRowNum=$("#reviewTable").children("tbody").children().length;
		if(displayRowNum == <%=totalRow%>&&<%=totalRow%>!=0){
			$("#reviewList").append("<div style='width:100%; text-align:center; font-size:12px;'>마지막 리뷰 입니다.</div>")
			$("#more")
			.hide();
		}
		if (currentPage == totalPageCount||<%=totalRow%>==0) {//만일 마지막 페이지 이면 
			return; //함수를 여기서 종료한다. 
		}
		//위쪽으로 스크롤된 길이 구하기
		//var scrollTop = $("#reviewList").scrollTop();
		//window 의 높이
		var listHeight = $("#reviewList").height();
		//document(문서)의 높이
		//var tableHeight = $("#reviewTable").height();
		//바닥까지 스크롤 되었는지 여부
		//var isBottom = scrollTop + listHeight-16> tableHeight;
		//if (isBottom) {//만일 바닥까지 스크롤 했다면...
			//로딩 이미지 띄우기
			
			$(".loader").show();
			currentPage++; //페이지를 1 증가 시키고 
			//해당 페이지의 내용을 ajax  요청을 해서 받아온다. 
			setTimeout(function() {
				$.ajax({
					url : "review_action.jsp",
					method : "post",
					data : {pageNum:currentPage,bnum:<%=num%>},
					success : function(data) {	 
							$("#reviewTable tbody").append(data);
							//로딩 이미지를 숨긴다. 
							$(".loader").hide();
							}
						});
					}, 2000);
			});
	</script>
	
	<!-- 북마크 처리   -->
	<script>
		$("#bookMarkBtn").on("click", function(){
			var id="<%=id%>";
		
			if(id != "") {
				$.ajax({
					method : "get",
					url : "bookmark.jsp",
					data : {"id" : "<%=id%>", bnum : <%=num%>},
					success : function(data){
						alert(data.result);
						
					}
				});
				return false;
				
			} else {
				var url=encodeURIComponent(window.location.href.replace("http://localhost:8888",""));
				alert("로그인 후에 이용 가능합니다.");
				location.href="${pageContext.request.contextPath}/login/loginForm.jsp?url="+url;
			}
			
		});
	</script> 
</body>
</html>