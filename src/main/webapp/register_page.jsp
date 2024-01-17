<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Registration Page</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href = "css/style.css" rel = "stylesheet" type = "text/css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		.banner-background{
			clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 100%, 79% 90%, 20% 90%, 0 100%, 0% 30%);
		}
	</style>
</head>
<body>
	<%@include file = "normal_navbar.jsp" %>
	<main class = "d-flex align-items-center" style = "height:100vh">
		<div class = "container">
			<div class = "col-md-6 offset-md-3">
				<div class = "card">
					<div class = "card-header text-center">
						<span class = "fa fa-user-circle fa-3x"></span><br>
						<p>Register Here</p>
					</div>
					
					<div class = "card-body">
						<form action = "RegisterServlet" method = "POST" id = "reg-form">
							<div class="form-group">
								<label for="user_name">User Name</label> <input
									type="text" name = "user_name" class="form-control" id="user_name"
									aria-describedby="emailHelp" placeholder="Enter name">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" name = "user_email" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" placeholder="Enter email">
								<small id="emailHelp" class="form-text text-muted">We'll
									never share your email with anyone else.</small>
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									type="password" name = "user_password" class="form-control" id="exampleInputPassword1"
									placeholder="Password">
							</div>
							<div class="form-group">
								<label for = "gender">Select Gender</label><br>
								<input type = "radio" id = "gender" name ="gender" value = "male" >Male
								<input type = "radio" id = "gender" name = "gender" value = "female">Female
							</div>
							<div class = "form-group">
								<textarea name = "about" class = "form-control" rows="" cols="" placeholder="Tell something about yourself"></textarea>
							</div>
							<div class="form-check">
								<input type="checkbox" name = "check" class="form-check-input"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1">Agree Terms & Conditions</label>
							</div><br>
							<!-- loader -->
							<div class = "container text-center" id = "loader" style="display:none;">
								<span class = "fa fa-refresh fa-spin fa-3x"></span><br>
								<h4>Please Wait...</h4>
							</div>
							
							<button type="submit" id = "submit-btn" class="btn btn-primary">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- JS -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src = "https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script><!-- sweet alert -->
	<script src = "js/myjs.js" type = "text/javascript"></script>
	<!-- adding Ajax functionality -->
	<script>
		$(document).ready(function(){
			console.log("Loaded");

			$('#reg-form').on('submit',function(event){
				event.preventDefault();
				$("#submit-btn").hide();
				$("#loader").show();
				let f = new FormData(this);
				$.ajax({
					url:"RegisterServlet",
					data:f,
					type:'POST',
					success:function(data,textStatus,jqXHR){
						console.log(data);
						$("#submit-btn").show();
						$("#loader").hide();
							if(data.trim()==='Done'){
								swal("Wohoo! Registered Successfully, redirecting to Login Page")
								.then((value) => {
						  			window.location="login_page.jsp";
								});
							}
							else{
								swal(data);
							}


					},
					error:function(jqXHR,textStatus,errorThrown){
						console.log(jqXHR);
						$("#submit-btn").show();
						$("#loader").hide();
						swal("Something Went Wrong!!");
						
					},
					processData:false,
					contentType:false
				});
			});
		});
	</script>
</body>
</html>