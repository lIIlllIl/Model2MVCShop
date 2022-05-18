package com.model2.mvc.service.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.domain.User;


public class UserDao {
	
	///Field
	
	///Constructor
	public UserDao() {
	}

	///Method
	public void insertUser(User user) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = 	"INSERT "				+ 
						"INTO USERS "			+ 
						"VALUES (?, ?, ?, 'user', ?, ?, ?, ?, SYSDATE)";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setString(1, user.getUserId());
		pStmt.setString(2, user.getUserName());
		pStmt.setString(3, user.getPassword());
		pStmt.setString(4, user.getSsn());
		pStmt.setString(5, user.getPhone());
		pStmt.setString(6, user.getAddr());
		pStmt.setString(7, user.getEmail());
		pStmt.executeUpdate();
		
		pStmt.close();
		con.close();
	}

	public User findUser(String userId) throws Exception {
		
		Connection con = DBUtil.getConnection();
			
		String sql = 	"SELECT "										+
						"user_id ,  user_name ,  password , role , " 	+
						"cell_phone ,  addr ,  email , reg_date, user_state " 	+ 
								"FROM users WHERE user_id = ?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setString(1, userId);

		ResultSet rs = pStmt.executeQuery();

		User user = null;

		while (rs.next()) {
			user = new User();
			user.setUserId(rs.getString("user_id"));
			user.setUserName(rs.getString("user_name"));
			user.setPassword(rs.getString("password"));
			user.setRole(rs.getString("role"));
			user.setPhone(rs.getString("cell_phone"));
			user.setAddr(rs.getString("addr"));
			user.setEmail(rs.getString("email"));
			user.setRegDate(rs.getDate("reg_date"));
			user.setUserState(rs.getString("user_state"));
		}
		
		rs.close();
		pStmt.close();
		con.close();
		
		return user;
	}

	public Map<String , Object> getUserList(Search search) throws Exception {
		
		Map<String , Object>  map = new HashMap<String, Object>();
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT user_id ,  user_name , email , user_state  FROM  users ";
		
		if (search.getSearchCondition() != null) {
			if ( search.getSearchCondition().equals("0") &&  !search.getSearchKeyword().equals("") ) {
				sql += " WHERE user_id LIKE '" + search.getSearchKeyword()+"%'";
			} else if ( search.getSearchCondition().equals("1") && !search.getSearchKeyword().equals("")) {
				sql += " WHERE user_name LIKE '" + search.getSearchKeyword()+"%'";
			}
		}
		sql += " ORDER BY user_id";
		
		System.out.println("UserDAO::Original SQL :: " + sql);
		
		int totalCount = this.getTotalCount(sql);
		System.out.println("UserDAO :: totalCount  :: " + totalCount);
		
		sql = makeCurrentPageSql(sql, search);
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();
	
		System.out.println(search);

		List<User> list = new ArrayList<User>();
		
		while(rs.next()){
			User user = new User();
			user.setUserId(rs.getString("user_id"));
			user.setUserName(rs.getString("user_name"));
			user.setEmail(rs.getString("email"));
			user.setUserState(rs.getString("user_state"));
			list.add(user);
		}
		

		map.put("totalCount", new Integer(totalCount));
		map.put("list", list);

		rs.close();
		pStmt.close();
		con.close();

		return map;
	}

	public void updateUser(User vo) throws Exception {

		Connection con = DBUtil.getConnection();

		String sql = 	"UPDATE users "+
								"SET user_name = ?, cell_phone = ? , addr = ? , email = ? "+ 
								"WHERE user_id = ?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setString(1, vo.getUserName());
		pStmt.setString(2, vo.getPhone());
		pStmt.setString(3, vo.getAddr());
		pStmt.setString(4, vo.getEmail());
		pStmt.setString(5, vo.getUserId());
		pStmt.executeUpdate();
		
		pStmt.close();
		con.close();
	}
	

	private int getTotalCount(String sql) throws Exception {
		
		sql = "SELECT COUNT(*) "+
		          "FROM ( " +sql+ ") countTable";
		
		Connection con = DBUtil.getConnection();
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();
		
		int totalCount = 0;
		if( rs.next() ){
			totalCount = rs.getInt(1);
		}
		
		pStmt.close();
		con.close();
		rs.close();
		
		return totalCount;
	}
	

	private String makeCurrentPageSql(String sql , Search search){
		sql = 	"SELECT * "+ 
					"FROM (		SELECT inner_table. * ,  ROWNUM AS row_seq " +
									" 	FROM (	"+sql+" ) inner_table "+
									"	WHERE ROWNUM <="+search.getCurrentPage()*search.getPageSize()+" ) " +
					"WHERE row_seq BETWEEN "+((search.getCurrentPage()-1)*search.getPageSize()+1) +" AND "+search.getCurrentPage()*search.getPageSize();
		
		System.out.println("UserDAO :: make SQL :: "+ sql);	
		
		return sql;
	}
	
	public void updateUserState(String userState, String userId) throws Exception {
		System.out.println(">>>>>>>>>>>>>updateUserState start<<<<<<<<<<<<<<<<<");
		System.out.println("userId : " + userId);
		System.out.println("userState : " + userState);
		
		Connection con = DBUtil.getConnection();

		String sql = 	"UPDATE users "+
						"SET user_state = ? "+ 
						"WHERE user_id = ?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setString(1, userState);
		pStmt.setString(2, userId);
		pStmt.executeUpdate();
		System.out.println(">>>>>>>>>>>>>updateUserState end<<<<<<<<<<<<<<<<<");
		pStmt.close();
		con.close();
	}
	
	public void deleteUser(String userId) throws Exception {
		Connection con = DBUtil.getConnection();
		
		String sql = 	"DELETE " + 
						"FROM users " +
						"WHERE user_id=?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setString(1, userId);
		int check = pStmt.executeUpdate();
		
		if (check == 1 ) {
			System.out.println(userId + "님의 회원탈퇴가 성공적으로 되었습니다.");
		}
		pStmt.close();
		con.close();
	}
}