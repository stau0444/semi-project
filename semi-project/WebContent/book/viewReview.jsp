<%@page import="book.dao.BookDao"%>
<%@page import="book.dto.BookDto"%>
<%@page import="review.dao.ReviewDao"%>
<%@page import="review.dto.ReviewDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rnum=Integer.parseInt(request.getParameter("rnum"));

	ReviewDto dto=ReviewDao.getInstance().getdata(rnum);
	BookDto BookInfo=BookDao.getInstance().getData(dto.getBnum());
%>
	<div class="modal-header">
				
				<span><strong id="caption"><%=dto.getUser_id()%>님의 리뷰</strong></span>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<h3 class="border-bottom border-success"><%=BookInfo.getBname()%></h3>

				<p class="small my-1" id="id">
					글쓴이 :
					<%=dto.getUser_id()%>
					<span class="ml-5">get</span><span class="float-right" id="rdate"><%=dto.getRdate()%></span>
				</p>
				<!-- review_menu -->
				<ul class="nav nav-tabs mt-lg-5" id="myTab" role="tablist">
					<li class="nav-item" role="presentation"><a
						class="nav-link active" id="home-tab" data-toggle="tab"
						href="#home" role="tab" aria-controls="home" aria-selected="true">책
							소개</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						id="profile-tab" data-toggle="tab" href="#profile" role="tab"
						aria-controls="profile" aria-selected="false">댓글</a></li>
				</ul>
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="home" role="tabpanel"
						aria-labelledby="home-tab">
						<p id="review_content" class="my-lg-5"><%=dto.getRcontent()%></p>

						<p class="float-right">
							저자 :
							<%=BookInfo.getBauthor()%>,&nbsp;&nbsp;출판사 :
							<%=BookInfo.getBcompany()%>,&nbsp;&nbsp; 출간일 :
							<%=BookInfo.getBdate()%></p>
					</div>
					
					<div class="tab-pane fade" id="profile" role="tabpanel"
						aria-labelledby="profile-tab">
						<table
							class="table table-light my-lg-3 border-bottom border-success">
							<thead class="table">
								<tr class="">
									<th class="text-center border-bottom border-success">추천</th>
									<th class="text-center border-bottom border-success">아이디</th>
									<th class="text-center border-bottom border-success">댓글 내용</th>
									<th class="text-center border-bottom border-success">날짜</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-center">1</td>
									<td class="text-center">kimgura</td>
									<td class="text-center">가나다라마바사아자차카타파하</td>
									<td class="text-center">0000.00.00</td>
								</tr>
								<tr>
									<td class="text-center">2</td>
									<td class="text-center">hdh</td>
									<td class="text-center">리뷰잘읽었어요</td>
									<td class="text-center">0000.00.00</td>
								</tr>
								<tr>
									<td class="text-center">2</td>
									<td class="text-center">asd</td>
									<td class="text-center">리뷰잘읽었어요</td>
									<td class="text-center">0000.00.00</td>
								</tr>

							</tbody>

						</table>
						<div class="mb-lg-5 w-100">
							<textarea class="form-control mt-lg-5 mb-lg-2"
								name="review_comment" id=""></textarea>
							<button class="btn btn-primary float-right mt-3">작성</button>
							<button class="btn btn-primary float-right mt-3 mr-2">지우기</button>
						</div>

					</div>
				</div>
			</div>
