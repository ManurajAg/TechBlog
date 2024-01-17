package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeDao {
	Connection con = null;
	
	public LikeDao(Connection con) {
		this.con = con;
	}
	
	public boolean insertLike(int pid,int uid) {
		boolean f = false;
		try {
			String query = "insert into liked(pid,uid) values (?,?)";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, pid);
			ps.setInt(2, uid);
			ps.executeUpdate();
			f = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}

	public int countLikeOnPost(int pid) {
		int count = 0;
		
		PreparedStatement ps;
		try {
			String query = "select count(*) from liked where pid = ?";
			ps = con.prepareStatement(query);
			ps.setInt(1, pid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return count;
	}

	public boolean isLikedByUser(int pid,int uid) {
		boolean liked = false;
		
		
		try {
			String query = "select * from liked where pid = ? and uid = ?";
			PreparedStatement ps;
			ps = con.prepareStatement(query);
			ps.setInt(1, pid);
			ps.setInt(2, uid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				liked = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return liked;
	}
	
	public boolean deleteLike(int pid,int uid) {
		boolean f = false;
		try {
			String query = "delete from liked where pid = ? and uid = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, pid);
			ps.setInt(2, uid);
			ps.executeUpdate();
			f = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
}
