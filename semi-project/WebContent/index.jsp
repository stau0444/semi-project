<%@page import="java.util.List"%>
<%@page import="review.dao.ReviewDao"%>
<%@page import="review.dto.ReviewDto"%>
<%@page import="java.util.Random"%>
<%@page import="book.dao.BookDao"%>
<%@page import="book.dto.BookDto"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String[] sort={"","컴퓨터","경제","예술","과학","종교","역사"};
	int sortNum=new Random().nextInt(6)+1;
	ArrayList<BookDto> rndBook=BookDao.getInstance().getRecommantedList(sortNum);
	ArrayList<BookDto> newBook=BookDao.getInstance().getNewList();
	List<ReviewDto> newReview=ReviewDao.getInstance().getNewList();
	
%>
<!doctype html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.0.1">
<title>index page</title>

<link rel="canonical"
	href="https://getbootstrap.com/docs/4.5/examples/blog/">
<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath }/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css" />
<link href="${pageContext.request.contextPath }/css/blog.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/css/carousel.css" rel="stylesheet" />

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.pic_img {
	width: 150px;
	height: 200px;
}
.pic_img:hover {
	width: 165px;
	height: 220px;
	transition:width 0.3s, height 0.3s;
}
.banner {
	width: 100px;
	height: 40px;
}

.banner>img {
	width: 100%;
	height: 100%;
}
.bookInfo {
	cursor: pointer;
}
.nameContent {
		width        : 280px;     /* 너비는 변경될수 있습니다. */
		text-overflow: ellipsis;  /* 위에 설정한 100px 보다 길면 말줄임표처럼 표시합니다. */
		white-space  : nowrap;    /* 줄바꿈을 하지 않습니다. */
		overflow     : hidden;    /* 내용이 길면 감춤니다 */
		display      : block;     /* ie6이상 현재요소를 블럭처리합니다. */
}
</style>

</head>

<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	
	<div class="container">
		<!-- <div class="w-980 mx-md-auto px-0"> -->
		<form action="book/book_list.jsp" method="get">
			<div class="input-group my-3 w-50 container">
				<input name="keyword" type="text" class="form-control" placeholder="찾으시는 책을 입력해주세요" aria-label="찾으시는 책을 입력해주세요" aria-describedby="button-addon2">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="submit"
						id="button-addon2">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
							fill="none" stroke="currentColor" stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2" class="mx-3" role="img"
							viewBox="0 0 24 24" focusable="false">
				            <title>Search</title>
				            <circle cx="10.5" cy="10.5" r="7.5" />
				            <path d="M21 21l-5.2-5.2" />
				         </svg>
					</button>
				</div>
		</div>
		</form>
		<img src="image/index.jpg" alt="" style="height:auto; width:100%;"/>
		<!-- 멀티 슬라이드 -->
		<h3 class="p-0 mt-5">추천도서 - <%=sort[sortNum] %></h3><small class="text-muted">오늘의 책 도서를 추천 합니다.</small>
		<hr />
		<div id="wrap" class="my-5">
			<ul class="slide" id="slide">
				<%for(BookDto tmp:rndBook) {%>
				<li>
					<div class="card bookInfo">
						<form action="${pageContext.request.contextPath}/book/book_info.jsp">
							<input type="hidden" name="bnum" value="<%=tmp.getBnum() %>" />
						</form>
						<picture class="shadow mb-3">
							<source
								srcset="<%=tmp.getBimg() %>"
								type="image/svg+xml">
							<img src="<%=tmp.getBimg() %>"
								class="img-fluid img-thumbnail pic_img" alt="...">
						</picture>
						<div class="card-body">
							<p class="card-title text-center"><strong><%=tmp.getBname() %></strong></p>
						</div>
					</div>
				</li>
				<%} %>
			</ul>
	        <!-- 멀티 슬라이드 -->
 
			<div class="prev">
				<svg width="2em" height="2em" viewBox="0 0 16 16"
					class="bi bi-caret-left-fill" fill="currentColor"
					xmlns="http://www.w3.org/2000/svg">
          <path
						d="M3.86 8.753l5.482 4.796c.646.566 1.658.106 1.658-.753V3.204a1 1 0 0 0-1.659-.753l-5.48 4.796a1 1 0 0 0 0 1.506z" />
        </svg>
			</div>
			<div class="next">
				<svg width="2em" height="2em" viewBox="0 0 16 16"
					class="bi bi-caret-right-fill bi-light" fill="currentColor"
					xmlns="http://www.w3.org/2000/svg">
          <path
						d="M12.14 8.753l-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z" />
        </svg>
			</div>
		</div>

		<div class="row mb-2">

			<div class="col-md-6">
				<!--케러셀-->
				<div class="card">
					<legend class="p-2 border-bottom">
						신간 도서
						<button class="btn btn-outline-secondary btn-sm float-right mr-3">
							<storng class="px-1">+</storng>
						</button>
					</legend>
					
					<jsp:include page="include/carousel2.jsp"></jsp:include>
				</div>
				
			</div>

			<div class="col-md-6">
				<div class="card">
					<table class="table table-hover text-center">
						<legend class="p-2 mb-0">
							최근 리뷰
							<button class="btn btn-outline-secondary btn-sm float-right mr-3">
								<storng class="px-1">+</storng>
							</button>
						</legend>
						<thead>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">리뷰 제목</th>
								<th scope="col">작성일</th>
							</tr>
						</thead>
						<tbody>
						<%
						int i=1;
						for(ReviewDto tmp:newReview) { %>
							<tr class="reviewRow" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
								<input type="hidden" id="rnum" value="<%=tmp.getRnum() %>" />
								<th scope="row"><%=i %></th>
								<td class="nameContent"><%=tmp.getRname() %></td>
								<td><%=tmp.getRdate() %></td>
							</tr>
						<%
							i++;
						} %>
						</tbody>
					</table>
					
					<jsp:include page="book/modal.jsp"></jsp:include>
				</div>
			</div>
		</div>
		
		
		<!-- banner -->
		<jsp:include page="include/banner.jsp"></jsp:include>
		<!-- banner -->
	</div>
	<!--/.container -->

	<jsp:include page="include/footer.jsp"></jsp:include>

	<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js "></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath }/js/carousel.js"></script>
	<script src="${pageContext.request.contextPath}/js/header.js"></script>
	<script>
	 $(".bookInfo").on("click",function() {
     	$(this).children("form").submit();
     });
	 
	 $(".reviewRow").on("click",function() {
			var rnum=$(this).children("#rnum").val();
			
			$.ajax({
				method:"post",
				url:"${pageContext.request.contextPath}/book/viewReview.jsp",
				data:"rnum="+rnum,
				success: function(data) {
					$(".modal-content").html(data);
				},
				error: function(a,b,c) {
					console.log(a+" "+b+" "+c);
				}
			});
		});
	</script>
</body>

</html>