<%@page import="review.dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@page import="review.dao.ReviewDao"%>
<%@page import="book.dto.BookDto"%>
<%@page import="book.dao.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" href="../css/blog.css" />
<link rel="stylesheet" href="../css/book_info.css" />
</head>
<!-- modal style -->
<style>
.modal-content {
	width:800px;
	height:  autopx;
	margin:0 auto;
}
.modal-content img{
	width:400px;
	height:300px;
	text-align: center;
}


#review_content {
	line-height: 30px;
}

</style>

<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("bnum"));
	List<ReviewDto> list=ReviewDao.getInstance().getList(num);
	BookDao dao=BookDao.getInstance();
	BookDto dto=dao.getData(num);
	
%>
<body>
		<!-- 헤더 -->
		<header>
			<jsp:include page="../include/header.jsp"></jsp:include>
		</header>
		<div id="container">
				<!-- 메뉴바 -->
			    <div class="nav-scroller py-1 mb-2">
				</div>	
		</div>
			<!--이미지 col-6 -->		
			<div class="container card">
				<div class="row">
					<div class="col-lg-6 ">
						 <img src="<%=dto.getBimg() %>" alt="bookimg" class="my-5 ml-xl-5 border border-success"/>
					</div>
			<!-- 책정보 col-6 -->
					<div class="col-lg-6 ">
						<div class="right mt-5">
							<h2><strong><%=dto.getBname() %></strong></h2>
							<p class="border-bottom border-success" ><%=dto.getBcompany()%>, <%=dto.getBdate()%></p>
							<h3 >줄거리</h3>
							<p class="font-weight-light" style="font-size:12px" id="story"><%=dto.getBstory() %></p>
							<h3 class="border-bottom border-success">리뷰<a href="../review/review_write.jsp?bnum=<%=num%>"
							 class="float-right font-weight-bold" style="font-size:12px">리뷰작성</a></h3>
							<div style=" width:480px; height:286px;">
								<table class="table border-bottom" style="font-size:10px" >
									<thead class="thead border-bottom">
									 	<tr>
									 		<th>번호</th>
									 		<th>아이디</th>
									 		<th>제목</th>
									 		<th>별점</th>
									 		<th>작성일</th>
									 	</tr>
									</thead>
									<%for(ReviewDto tmp:list){ %>
										<tr>
											<td><%=tmp.getRnum() %></td>
											<td><%=tmp.getUser_id() %></td>
											<td>
												<a class="reviewBtn" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
												<%=tmp.getRname() %>
												<input type="hidden" id="rnum" name="rnum" value="<%=tmp.getRnum() %>"/>
												</a>
											
											<!-- 모달부 -->
											
											</td>
											<td><%=tmp.getRscore()%>/5 </td>
											<td><%=tmp.getRdate() %></td>
										</tr>
									<%} %>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="modal.jsp"></jsp:include>
		<!-- footer -->
		<jsp:include page="../include/footer.jsp"></jsp:include>
		<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
		<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
		<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
		integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
		crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath}/js/review.js"></script>
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
</body>
</html>