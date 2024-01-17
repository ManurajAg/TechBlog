package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.*;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class AddPostServlet
 */
@MultipartConfig
@WebServlet("/AddPostServlet")
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
			int cid = Integer.parseInt(request.getParameter("cid"));
			String pTitle = request.getParameter("pTitle");
			String pContent = request.getParameter("pContent");
			String pCode = request.getParameter("pCode");
			Part pic = request.getPart("pPic");
			String picName = pic.getSubmittedFileName();
			HttpSession s = request.getSession();
			User u = (User)s.getAttribute("currentUser");
			Post post = new Post(pTitle,pContent,pCode,picName,null,cid,u.getId());
			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			if(dao.savePost(post)) {
				response.getWriter().println("done");
				String path = request.getRealPath("/")+"blog_pics"+File.separator+picName;
				Helper.saveFile(pic.getInputStream(), path);
			}
			else {
				response.getWriter().println("error");
			}
	}

}
