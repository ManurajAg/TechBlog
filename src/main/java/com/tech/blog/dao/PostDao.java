package com.tech.blog.dao;



import java.sql.*;
import java.util.*;

import com.tech.blog.entities.*;
public class PostDao {
	
	Connection con;
	public PostDao(Connection con) {
		this.con = con;
	}
	
	public ArrayList<Category> getCategories() {
		ArrayList<Category> list = new ArrayList<>();
		try {
			String query = "select * from categories";
			Statement stmt =  con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				int cid = rs.getInt("cid");
				String name = rs.getString("name");
				String description = rs.getString("description");
				Category c = new Category(cid,name,description);
				list.add(c);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean savePost(Post post) {
		boolean f = false;
		try {
			String query = "insert into posts (pTitle,pContent,pCode,pPic,catId,userId) values (?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, post.getpTitle());
			ps.setString(2, post.getpContent());
			ps.setString(3, post.getpCode());
			ps.setString(4, post.getpPic());
			ps.setInt(5, post.getCatId());
			ps.setInt(6, post.getUserId());
			ps.executeUpdate();
			f = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public List<Post> getAllPosts(){
		List<Post> list = new ArrayList<>();
		try {
			String query = "select * from posts order by pid desc";
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				int pid = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp date = rs.getTimestamp("pDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");
				Post post = new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
				list.add(post);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return list;
	}
	
	public List<Post> getPostByCatId(int catId){
		List<Post> list = new ArrayList<>();
		try {
			String query = "select * from posts where catId = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, catId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				int pid = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp date = rs.getTimestamp("pDate");
				int userId = rs.getInt("userId");
				Post post = new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
				list.add(post);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Post getPostByPid(int postId) {
		Post post=null;
		try {
			String query = "select * from posts where pid = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, postId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				int pid = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp date = rs.getTimestamp("pDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");
				post = new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return post;
	}
	

}
