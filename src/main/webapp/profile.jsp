<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page errorPage = "error_page.jsp" %>
<!-- Fetching user from sesssion -->    
<%
	User user = (User)session.getAttribute("currentUser");
	//if no user then redirect to login page
	if(user == null){
		response.sendRedirect("login_page.jsp");
	}

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Profile</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<link href = "css/style.css" rel = "stylesheet" type = "text/css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	</head>
	<body>
		
		<!-- Start of navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span
			class="fa fa-asterisk"> Tech Blog</span></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"><span
						class="fa fa-bell-o"> Learn With Me</span> <span class="sr-only">(current)</span>
				</a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"><span class="fa fa-check-square-o">
							Categories</span></a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#"><span
						class="fa fa-address-book-o"> Contact</span></a></li>
				<li class="nav-item"><a class="nav-link" href="#"><span
						class="fa fa-plus-square" data-toggle = "modal" data-target = "#add-post-modal"> Do Post</span></a></li>
				<!-- <li class="nav-item"><a class="nav-link"
					href="register_page.jsp"><span class="fa fa-user-plus">
							Logout</span></a></li> -->
			</ul>
			<ul class = "navbar-nav mr-right">
				<li class="nav-item">
					<a class="nav-link" href="#" data-toggle = "modal" data-target = "#profile-modal"><span class="fa fa-user-circle"> <%=user.getName() %></span></a>
				</li>	<!-- use of data-toggle and data-target makes modal to appear -->
				<li class="nav-item">
					<a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"> Logout</span></a>
				</li>
			</ul>
		</div>
	</nav>
	<!-- end of navbar -->
	<%
		Message msg = (Message)session.getAttribute("msg");
		if(msg != null){
	%>
	<div class = "alert <%=msg.getCssClass() %>" role = "alert">
		<%=msg.getContent() %>
	</div>					
	<%		
		session.removeAttribute("msg");
		}				
	%>
	
	<!-- Main Body -->
	<main>
		<div class = "container">
			<div class = "row mt-4">		<!-- one row has 12 columns so to divide in 2 we give it 4 and 8 -->
				<!-- First Column -->
				<div class = "col-md-4">
					<!-- Here we will show all categories -->
					<div class="list-group">
  							<a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active">All Posts</a>
  							<%
  								PostDao dao1 = new PostDao(ConnectionProvider.getConnection());
  								ArrayList<Category> list1 = dao1.getCategories();
  								for(Category cc:list1){
  							%>
  							<a href="#" onclick="getPosts(<%=cc.getCid()%>,this)" class="c-link list-group-item list-group-item-action"><%=cc.getName() %></a>
  							<% } %>
						</div>
				</div>
				<!--  Second Column -->
				<div class = "col-md-8" >
					<!--  Here we will display all posts of that categories -->
					<div class = "container text-center" id = "loader">
						<i class = "fa fa-refresh fa-4x fa-spin"></i>
						<h3 class = "mt-2">Loading....</h3>
					</div>
					<div class = "container-fluid" id = "post-container">
						<!-- Posts will come up here -->
					</div>
				</div>
			</div>
		</div>
	</main>
	
	
	<!-- End of Main Body -->
	
	
	
	
	<!-- Start of profile modal -->

	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class = "container text-center">
						<img src = "pics/<%=user.getProfile() %>" style = "border-radius:50%; max-width:150px;">
						
						<h5 class = "modal-title mt-3" id = "exampleModalLabel"><%=user.getName()%></h5>
						<!-- details -->
						<div id = "profile-details">
							<table class="table">
							<tbody>
								<tr>
									<th scope="row">ID :</th>
									<td><%=user.getId() %></td>
									
								</tr>
								<tr>
									<th scope="row">Email :</th>
									<td><%=user.getEmail() %></td>
								</tr>
								<tr>
									<th scope="row">Gender :</th>
									<td><%=user.getGender() %></td>
								</tr>
								<tr>
									<th scope="row">About :</th>
									<td><%=user.getAbout() %></td>
								</tr>
								<tr>
									<th scope="row">Registered On :</th>
									<td><%=user.getDateTime() %></td>
								</tr>
								
							</tbody>
						</table>
						</div>
						
						
						<!-- profile edit -->
						<div id = "profile-edit" style="display:none;">
							<h3 class = "mt-2">Please Edit Carefully</h3>
							<form action = "EditServlet" method = "POST" enctype="multipart/form-data">
						
								<table class = "table">
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId() %></td>
									</tr>
									<tr>
										<th scope="row">Name :</th>
										<td><input type ="text" class = "form-control" name = "user_name" value = "<%=user.getName()%>"> 
										</td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><input type ="email" class = "form-control" name = "user_email" value = "<%=user.getEmail()%>"> 
										</td>
									</tr>
									<tr>
										<th scope="row">Password :</th>
										<td><input type ="password" class = "form-control" name = "user_password" value = "<%=user.getPassword()%>"> 
										</td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<th scope="row">About :</th>
										<td><textarea rows = "3" class = "form-control" name = "user_about" ><%=user.getAbout() %></textarea></td>
									</tr>
									<tr>
										<th scope="row">Profile Pic :</th>
										<td><input type = "file" name = "image" class = "form-control"></td>
									</tr>
								</table>
								<div class = "container" >
									<button type = "submit" class = "btn btn-outline-primary">Save</button>
								</div>
							</form>
						</div>
						
						
						
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id = "edit-profile-button" type="button" class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- end of profile modal -->
	<!-- start of add post modal -->
	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Create Post</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id = "add-post-form" action = "AddPostServlet" method = "POST" enctype="form-data/multipart">
						<div class = "form-group">
							<select class = "form-control" name = "cid">
								<option selected disabled>--- Select your post Category ---</option>
								<%
									PostDao dao = new PostDao(ConnectionProvider.getConnection());
									ArrayList<Category> list = dao.getCategories();
									for(Category c:list){
								%>
								<option value = "<%=c.getCid()%>"><%=c.getName() %></option>
								<%
									}
								%>
							</select>
						</div>
						<div class = "form-group">
							<input type = "text" name = "pTitle" placeholder = "Enter post title" class = "form-control">
						</div>
						<div class = "form-group">
							<textarea class = "form-control" name = "pContent" placeholder = "Enter your Content"	style = "height:200px;"></textarea>
						</div>
						<div class = "form-group">
							<textarea class = "form-control" name = "pCode" placeholder = "Enter your program(if any)"	style = "height:200px;"></textarea>
						</div>
						<div class = "form-group">
							<label>Select your pic..</label><br>
							<input type = "file" name="pPic">
						</div>
						<div class = "container text-center">
							<button type="submit"class = "btn btn-outline-primary">Post</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- JS -->
		<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
		<script src = "js/myjs.js" type = "text/javascript"></script>
		<script>
			$(document).ready(function(){
				let editStatus = false;
				$('#edit-profile-button').click(function(){
					if(editStatus == false){
						$('#profile-details').hide();
						$('#profile-edit').show();
						editStatus = true;
						$(this).text("Back");
					}
					else{
						$('#profile-details').show();
						$('#profile-edit').hide();
						editStatus = false;
						$(this).text("Edit");
					}
					
				});
			});
		</script>
		<!-- add post JS -->
		<script>
			$(document).ready(function(e){
				$("#add-post-form").on("submit",function(event){
						//called when form is submitted
						event.preventDefault();
						let form = new FormData(this);
						$.ajax({
							url:"AddPostServlet",
							type:'POST',
							data:form,
							success:function(data,textStatus,jqXHR){
								//success code
								if(data.trim() == 'done'){
									swal("Wohoo!", "Successfully Posted", "success");
								}
								else{
									swal("Oops!", "Something Went Wrong..", "error");
								}
							},
							error:function(jqXHR,textStatus,errorThrown){
								//error code
								swal("Oops!", "Something Went Wrong..", "error");
							},
							processData:false,
							contentType:false
						});
				});
			});
		</script>
		<!-- load post -->
		<script>
		
			function getPosts(catId,temp){
				$("#loader").show();
				$("#post-container").hide();
				$(".c-link").removeClass("active");
				$.ajax({
					url:"load_post.jsp",
					data : {cid:catId},
					success:function(data,textStatus,jqXHR){
						console.log(data);
						$("#loader").hide();
						$("#post-container").show();
						$("#post-container").html(data);
						$(temp).addClass("active");
					},
					error:function(jqXHR,textStatus,errorThrown){
						console.log(errorThrown);
					}
				});
			}
		
			$(document).ready(function(e){
				let allPostRef = $('.c-link')[0]	//initially to make all post button as active we need its reference thus we accessed it using allPostRef
				getPosts(0,allPostRef);
			});
		</script>
	</body>
</html>