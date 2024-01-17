<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%
	User user = (User)session.getAttribute("currentUser");
	//if no user then redirect to login page
	if(user == null){
		response.sendRedirect("login_page.jsp");
	}

%>
<div class = "row">
<%
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		int cid = Integer.parseInt(request.getParameter("cid"));
		List<Post> posts = null;
		if(cid == 0){
			posts = dao.getAllPosts();	
		}
		else{
			posts = dao.getPostByCatId(cid);
		}
		if(posts.size() == 0){
			out.println("<h3 class = 'display-3 text-center' >No Posts in this category..</h3>");
			return;
		}
		for(Post p:posts){
%>	
	<div class = "col-md-6 mt-2">
		<div class = "card">
			  <img class="card-img-top" src="blog_pics/<%=p.getpPic() %>" alt="Card image cap">
			<div class = "card-body">
				<b><%=p.getpTitle() %></b>
				<p><%=p.getpContent() %></p>
			</div>
			<div class = "card-footer text-center">
				<%
					LikeDao dao3 = new LikeDao(ConnectionProvider.getConnection());
							
				%>
				<a href="#" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)" class = "btn btn-outline-primary"><i class = "fa fa-thumbs-o-up"></i><span class="like-counter"> <%=dao3.countLikeOnPost(p.getPid()) %></span></a>
				<a href="show_blog_page.jsp?pid=<%=p.getPid() %>" class = "btn btn-outline-primary">Read More...</a>
				<a href="#" class = "btn btn-outline-primary"><i class = "fa fa-commenting-o"></i><span> 10</span></a>
			</div>
		</div>
	</div>
<%
		}
%>

</div>