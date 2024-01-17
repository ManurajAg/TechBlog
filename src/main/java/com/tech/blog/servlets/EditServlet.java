package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class EditServlet
 */
@MultipartConfig
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		//fetching user data :- 
		String userEmail = request.getParameter("user_email");
		String userName = request.getParameter("user_name");
		String userPassword = request.getParameter("user_password");
		String userAbout = request.getParameter("user_about");
		Part userProfile = request.getPart("image");
		String imgName = userProfile.getSubmittedFileName();
		//getting user from session
		HttpSession s = request.getSession();
		User user = (User)s.getAttribute("currentUser");
		if(user == null) {
			response.sendRedirect("login_page.jsp");
		}
		else {
			
			user.setName(userName);
			user.setEmail(userEmail);
			user.setPassword(userPassword);
			user.setAbout(userAbout);
			String oldProfile = user.getProfile();
			user.setProfile(imgName);
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			boolean ans = dao.updateUser(user);
			if(ans) {
				
//				String path = request.getRealPath("/")+"pics"+File.separator+user.getProfile();
				String path = "D:/Courses/TechBlog/src/main/webapp/pics"+File.separator+user.getProfile();
				if(!oldProfile.equals("default.png")) {
//					String oldPath = request.getRealPath("/")+"pics"+File.separator+oldProfile;
					String oldPath = "D:/Courses/TechBlog/src/main/webapp/pics"+File.separator+oldProfile	;
					Helper.deleteFile(oldPath);
				}
				
				System.out.println(path); 
				 
				if(Helper.saveFile(userProfile.getInputStream(), path)) {
					Message msg = new Message("Profile Updated","success","alert-success");
					s.setAttribute("msg", msg);
					
				}
				else {
					Message msg = new Message("Something Went Wrong ...","error","alert-danger");
					s.setAttribute("msg", msg);
				}
				
			}
			else {
				Message msg = new Message("Something Went Wrong ...","error","alert-danger");
				s.setAttribute("msg", msg);
			}
			response.sendRedirect("profile.jsp");
		}
		
	}

}
