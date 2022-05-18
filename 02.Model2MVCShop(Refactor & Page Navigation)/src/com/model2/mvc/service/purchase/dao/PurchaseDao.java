package com.model2.mvc.service.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.dao.ProductDao;
import com.model2.mvc.service.user.dao.UserDao;

public class PurchaseDao {
	
	public Purchase findPurchase(int tranNo) throws Exception{
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM transaction WHERE tran_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, tranNo);
		
		ResultSet rs = stmt.executeQuery();
		
		Purchase purchase = new Purchase();
		
		while (rs.next()) {
			purchase = new Purchase();
			purchase.setTranNo(Integer.parseInt(rs.getString("TRAN_NO")));
			
			ProductDao productDao = new ProductDao();
			Product product = productDao.findProduct(Integer.parseInt(rs.getString("PROD_NO")));
			
			purchase.setPurchaseProd(product);
			
			UserDao userDao = new UserDao();
			User user = userDao.findUser(rs.getString("BUYER_ID"));
			
			purchase.setBuyer(user);
			purchase.setPaymentOption(rs.getString("PAYMENT_OPTION"));
			purchase.setReceiverName(rs.getString("RECEIVER_NAME"));
			purchase.setReceiverPhone(rs.getString("RECEIVER_PHONE"));
			purchase.setDivyAddr(rs.getString("DEMAILADDR"));
			purchase.setDivyRequest(rs.getString("DLVY_REQUEST"));
			purchase.setTranCode(rs.getString("TRAN_STATUS_CODE"));
			purchase.setOrderDate(rs.getDate("ORDER_DATA"));
			purchase.setDivyDate(rs.getString("DLVY_DATE"));
		}
		
		con.close();

		return purchase;
	}
	
	public Purchase findPurchase2(int prodNo) throws Exception{
		
		Connection con = DBUtil.getConnection();
		
		String sql = 	"SELECT " + 
						"tran_no, prod_no, buyer_id, payment_option, receiver_name, " +
						"receiver_phone, demailaddr, dlvy_request, tran_status_code, "+ 
						"order_data, dlvy_date " +
						"FROM transaction WHERE prod_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);
		
		ResultSet rs = stmt.executeQuery();
		
		Purchase purchase = new Purchase();
		
		while (rs.next()) {
			purchase = new Purchase();
			purchase.setTranNo(Integer.parseInt(rs.getString("TRAN_NO")));
			
			ProductDao productDao = new ProductDao();
			Product product = productDao.findProduct(Integer.parseInt(rs.getString("PROD_NO")));
			
			purchase.setPurchaseProd(product);
			
			UserDao userDao = new UserDao();
			User user = userDao.findUser(rs.getString("BUYER_ID"));
			
			purchase.setBuyer(user);
			purchase.setPaymentOption(rs.getString("PAYMENT_OPTION"));
			purchase.setReceiverName(rs.getString("RECEIVER_NAME"));
			purchase.setReceiverPhone(rs.getString("RECEIVER_PHONE"));
			purchase.setDivyAddr(rs.getString("DEMAILADDR"));
			purchase.setDivyRequest(rs.getString("DLVY_REQUEST"));
			purchase.setTranCode(rs.getString("TRAN_STATUS_CODE"));
			purchase.setDivyRequest(rs.getString("DLVY_REQUEST"));
			purchase.setOrderDate(rs.getDate("ORDER_DATA"));
			purchase.setDivyDate(rs.getString("DLVY_DATE"));
		}
		
		con.close();

		return purchase;
	}

	public Map<String,Object> getPurchaseList(Search search, String value) throws Exception {
		// 구매목록보기 -> 구매이력조회
		// String value = 멀까 buyerId밖에 없는거같은데 
		Connection con = DBUtil.getConnection();
		
		String sql = 	"SELECT * FROM transaction " +
						"WHERE buyer_id='" + value + "' " +
						" ORDER BY tran_no";
		
		
		int totalCount = this.getTotalCount(sql);
		
		sql = makeCurrentPageSql(sql, search);
		
		PreparedStatement stmt = con.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		List<Purchase> list = new ArrayList<Purchase>();
		
		while(rs.next()){
				Purchase purchase = new Purchase();
				
				UserDao userDao = new UserDao();
				User user = userDao.findUser(rs.getString("BUYER_ID"));
				
				purchase.setBuyer(user);
				
				purchase.setDivyAddr(rs.getString("DEMAILADDR"));
				purchase.setDivyDate(rs.getString("DLVY_DATE"));
				purchase.setDivyRequest(rs.getString("DLVY_REQUEST"));
				purchase.setOrderDate(rs.getDate("ORDER_DATA"));
				purchase.setReceiverPhone(rs.getString("RECEIVER_PHONE"));
				purchase.setTranCode(rs.getString("TRAN_STATUS_CODE"));
				purchase.setTranNo(Integer.parseInt(rs.getString("TRAN_NO")));
				purchase.setPaymentOption(rs.getString("PAYMENT_OPTION"));
				
				ProductDao productDao = new ProductDao();
				Product product = productDao.findProduct(Integer.parseInt(rs.getString("PROD_NO")));
				
				purchase.setPurchaseProd(product);
				
				list.add(purchase);
			}
		
				Map<String, Object> map = new HashMap<String, Object>();
				
				map.put("totalCount", new Integer(totalCount));
				map.put("list", list);
				System.out.println(map.get("list"));
				con.close();
					
				return map;
		}
	
	public Map<String,Object> getSaleList(Search search) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = "select * from USERS ";
		if (search.getSearchCondition() != null) {
			if (search.getSearchCondition().equals("0")) {
				sql += " where USER_ID LIKE'" + search.getSearchKeyword()
						+ "'";
			} else if (search.getSearchCondition().equals("1")) {
				sql += " where USER_NAME LIKE" + search.getSearchKeyword()
						+ "'";
			}
		}
		sql += " order by USER_ID";

		PreparedStatement stmt = 
			con.prepareStatement(	sql,
														ResultSet.TYPE_SCROLL_INSENSITIVE,
														ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = stmt.executeQuery();

		rs.last();
		int total = rs.getRow();
		System.out.println("로우의 수:" + total);

		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("count", new Integer(total));

		rs.absolute(search.getCurrentPage() * search.getPageSize() - search.getPageSize()+1);
		System.out.println("searchVO.getPage():" + search.getCurrentPage());
		System.out.println("searchVO.getPageUnit():" + search.getPageSize());

		ArrayList<User> list = new ArrayList<User>();
		if (total > 0) {
			for (int i = 0; i < search.getPageSize(); i++) {
				User vo = new User();
				vo.setUserId(rs.getString("USER_ID"));
				vo.setUserName(rs.getString("USER_NAME"));
				vo.setPassword(rs.getString("PASSWORD"));
				vo.setRole(rs.getString("ROLE"));
				vo.setSsn(rs.getString("SSN"));
				vo.setPhone(rs.getString("CELL_PHONE"));
				vo.setAddr(rs.getString("ADDR"));
				vo.setEmail(rs.getString("EMAIL"));
				vo.setRegDate(rs.getDate("REG_DATE"));

				list.add(vo);
				if (!rs.next())
					break;
			}
		}
		System.out.println("list.size() : "+ list.size());
		map.put("list", list);
		System.out.println("map().size() : "+ map.size());

		con.close();
			
		return map;
	}
	// 이게 판매목록보기네 잘모름
	
	public void insertPurchase(Purchase purchase) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "INSERT INTO transaction VALUES (seq_transaction_tran_no.nextval, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?)";
		// tran_no 0 prod_no 1 buyer_id 2 payment_option 3 receiver_name 4 receiver_phone 5
		// demailaddr 6 dlvy_request 7 tran_status_code 8 order_date 9 dlVY_date 10 
		PreparedStatement stmt = con.prepareStatement(sql);
		
		User user = purchase.getBuyer();
		Product product = purchase.getPurchaseProd();
		
		stmt.setInt(1, product.getProdNo());
		stmt.setString(2, user.getUserId());
		stmt.setString(3, purchase.getPaymentOption());
		stmt.setString(4, purchase.getReceiverName());
		stmt.setString(5, purchase.getReceiverPhone());
		stmt.setString(6, purchase.getDivyAddr());
		stmt.setString(7, purchase.getDivyRequest());
		stmt.setString(8, "1");
		stmt.setString(9, purchase.getDivyDate());
		stmt.executeUpdate();
		
		con.close();
	}
	
	public void updatePurchase(Purchase purchase) throws Exception {
		// 다른거다
		// 구매이력조회 -> No 선택(tranNo) -> 구매상세조회에서
		// 물품번호 / 구매자 아이디 / 구매방법 / 구매자이름 / 구매자연락처 / 구매자주소 / 구매요청사항 / 배송희망일 / 주문일 확인가능
		// 수정 버튼을 누르면
		// 구매자아이디 단순 display => 수정불가 (buyer_id)
		// 구매방법 (select) / 구매자이름 / 구매자연락처 / 구매자주소 / 구매요청사항 / 배송희망일자 수정가능 
		
		
		// tranCode = 1 :: 현재 구매완료 상태 
		// tranCode = 2 :: 현재 배송중 상태
		// tranCode = 3 :: 현재 배송완료 상태  
		// user에서 구매이력조회에서는 2상태에서 3으로 바꾸는 것 밖에 없다 -> 1에서 2 바꾸는건 trancode인가? 
		Connection con = DBUtil.getConnection();

		String sql = 	"UPDATE transaction SET payment_option=?, receiver_name=?, receiver_phone=?, " + 
						"demailaddr=?, dlvy_request=?, dlvy_date=? WHERE tran_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		
		stmt.setString(1, purchase.getPaymentOption());
		stmt.setString(2, purchase.getReceiverName());
		stmt.setString(3, purchase.getReceiverPhone());
		stmt.setString(4, purchase.getDivyAddr());
		stmt.setString(5, purchase.getDivyRequest());
		stmt.setString(6, purchase.getDivyDate());
		stmt.setInt(7, purchase.getTranNo());
		stmt.executeUpdate();
		
		con.close();
	}
	
	public void updateTranCode(Purchase purchase) throws Exception {
		
		Connection con = DBUtil.getConnection();

//		String sql = 	"UPDATE transaction " + 
//						"SET prod_no=?, buyer_id=?, payment_option=?, " +
//						"receiver_name=? , receiver_phone=?, demailaddr=?, " +
//						"dlvy_request=?, tran_status_code=?, order_date=? " + 
//						"WEHRE tran_no=?";
		
		String sql = 	"UPDATE transaction " + 
						"SET tran_status_code=? " +
						"WHERE tran_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		
		stmt.setString(1, purchase.getTranCode());
		stmt.setInt(2, purchase.getTranNo());

		stmt.executeUpdate();
		
		con.close();
	}
	
	private int getTotalCount(String sql) throws Exception {
		
		sql = "SELECT COUNT(*) "+
		          "FROM ( " +sql+ ") ";
		
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
		
		System.out.println("ProductDao makeCurrentPageSql : " + sql);	
		
		return sql;
	}

}


