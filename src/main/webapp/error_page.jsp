<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isErrorPage = "true"	%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Something Went Wrong</title>
	<!-- CSS -->
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
	<div class = "container text-center" >
		<img src = "img/error.png" class = "img-fluid mt-4" style = "height:50vh;">
		<h3 class = "display-4">Sorry! Something Went Wrong ...</h3><br>
		<%=exception %><br>
		<a href ="index.jsp" class = "btn primary-background btn-lg text-white mt-3">Home</a>
	</div>
</body>
</html>