package com.model2.mvc.service.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.product.dao.ProductDAO;
import com.model2.mvc.service.product.vo.ProductVO;
import com.model2.mvc.service.purchase.vo.PurchaseVO;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.dao.UserDAO;
import com.model2.mvc.service.user.impl.UserServiceImpl;
import com.model2.mvc.service.user.vo.UserVO;

public class PurchaseDAO {
	
	public PurchaseVO findPurchase(int tranNo) throws Exception{
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM transaction WHERE tran_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, tranNo);
		
		ResultSet rs = stmt.executeQuery();
		
		PurchaseVO purchaseVO = new PurchaseVO();
		
		while (rs.next()) {
			purchaseVO = new PurchaseVO();
			purchaseVO.setTranNo(Integer.parseInt(rs.getString("TRAN_NO")));
			
			String prod_no = rs.getString("PROD_NO"); // transaction���� prod_no get 
			int prodNo = Integer.parseInt(prod_no); // string -> int ����ȯ 
			
			
			ProductDAO productDAO = new ProductDAO(); // findProduct�� ProductVO ã������ 
			
			ProductVO productVO = productDAO.findProduct(prodNo);
			
			
			purchaseVO.setPurchaseProd(productVO);
			
			
			
			UserDAO userDAO = new UserDAO();
			UserVO userVO = userDAO.findUser(rs.getString("BUYER_ID"));
			
			purchaseVO.setBuyer(userVO);
			purchaseVO.setPaymentOption(rs.getString("PAYMENT_OPTION"));
			purchaseVO.setReceiverName(rs.getString("RECEIVER_NAME"));
			purchaseVO.setReceiverPhone(rs.getString("RECEIVER_PHONE"));
			purchaseVO.setDivyAddr(rs.getString("DEMAILADDR"));
			purchaseVO.setDivyRequest(rs.getString("DLVY_REQUEST"));
			purchaseVO.setTranCode(rs.getString("TRAN_STATUS_CODE"));
			purchaseVO.setOrderDate(rs.getDate("ORDER_DATA"));
			purchaseVO.setDivyDate(rs.getString("DLVY_DATE").substring(0, 10));
		}
		
		con.close();

		return purchaseVO;
	}
	
	public PurchaseVO findPurchase2(int prodNo) throws Exception{
		
		Connection con = DBUtil.getConnection();
		
		String sql = 	"SELECT " + 
						"tran_no, prod_no, buyer_id, payment_option, receiver_name, " +
						"receiver_phone, demailaddr, dlvy_request, tran_status_code, "+ 
						"order_data, dlvy_date " +
						"FROM transaction WHERE prod_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);
		
		ResultSet rs = stmt.executeQuery();
		
		PurchaseVO purchaseVO = new PurchaseVO();
		
		while (rs.next()) {
			purchaseVO = new PurchaseVO();
			purchaseVO.setTranNo(Integer.parseInt(rs.getString("TRAN_NO")));
			
			ProductDAO productDAO = new ProductDAO();
			ProductVO productVO = productDAO.findProduct(Integer.parseInt(rs.getString("PROD_NO")));
			
			purchaseVO.setPurchaseProd(productVO);
			
			UserDAO userDAO = new UserDAO();
			UserVO userVO = userDAO.findUser(rs.getString("BUYER_ID"));
			
			purchaseVO.setBuyer(userVO);
			purchaseVO.setPaymentOption(rs.getString("PAYMENT_OPTION"));
			purchaseVO.setReceiverName(rs.getString("RECEIVER_NAME"));
			purchaseVO.setReceiverPhone(rs.getString("RECEIVER_PHONE"));
			purchaseVO.setDivyAddr(rs.getString("DEMAILADDR"));
			purchaseVO.setDivyRequest(rs.getString("DLVY_REQUEST"));
			purchaseVO.setTranCode(rs.getString("TRAN_STATUS_CODE"));
			purchaseVO.setDivyRequest(rs.getString("DLVY_REQUEST"));
			purchaseVO.setOrderDate(rs.getDate("ORDER_DATA"));
			purchaseVO.setDivyDate(rs.getString("DLVY_DATE"));
		}
		
		con.close();

		return purchaseVO;
	}

	public HashMap<String,Object> getPurchaseList(SearchVO searchVO, String value) throws Exception {
		// ���Ÿ�Ϻ��� -> �����̷���ȸ
		// String value = �ֱ� buyerId�ۿ� ���°Ű����� 
		Connection con = DBUtil.getConnection();
		
		String sql = 	"SELECT * FROM transaction " +
						"WHERE buyer_id=? " + 
						"ORDER BY tran_no";

		PreparedStatement stmt = 
			con.prepareStatement(	sql,
														ResultSet.TYPE_SCROLL_INSENSITIVE,
														ResultSet.CONCUR_UPDATABLE);
		
		stmt.setString(1, value);
		
		ResultSet rs = stmt.executeQuery();
		
		rs.last();
		int total = rs.getRow();
		System.out.println("�ο��� ��:" + total);

		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("count", new Integer(total));

		rs.absolute(searchVO.getPage() * searchVO.getPageUnit() - searchVO.getPageUnit()+1);
		System.out.println("searchVO.getPage():" + searchVO.getPage());
		System.out.println("searchVO.getPageUnit():" + searchVO.getPageUnit());
		
		ArrayList<PurchaseVO> list = new ArrayList<PurchaseVO>();
		if (total > 0) {
			for (int i = 0; i < searchVO.getPageUnit(); i++) {
				PurchaseVO purchaseVO = new PurchaseVO();
				
				UserDAO userDAO = new UserDAO();
				UserVO userVO = userDAO.findUser(rs.getString("BUYER_ID"));
				
				purchaseVO.setBuyer(userVO);
				
				purchaseVO.setDivyAddr(rs.getString("DEMAILADDR"));
				purchaseVO.setDivyDate(rs.getString("DLVY_DATE"));
				purchaseVO.setDivyRequest(rs.getString("DLVY_REQUEST"));
				purchaseVO.setOrderDate(rs.getDate("ORDER_DATA"));
				purchaseVO.setReceiverPhone(rs.getString("RECEIVER_PHONE"));
				purchaseVO.setTranCode(rs.getString("TRAN_STATUS_CODE"));
				purchaseVO.setTranNo(Integer.parseInt(rs.getString("TRAN_NO")));
				purchaseVO.setPaymentOption(rs.getString("PAYMENT_OPTION"));
				
				ProductDAO productDAO = new ProductDAO();
				ProductVO productVO = productDAO.findProduct(Integer.parseInt(rs.getString("PROD_NO")));
				
				purchaseVO.setPurchaseProd(productVO);
				
				list.add(purchaseVO);
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
	
	public HashMap<String,Object> getSaleList(SearchVO searchVO) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = "select * from USERS ";
		if (searchVO.getSearchCondition() != null) {
			if (searchVO.getSearchCondition().equals("0")) {
				sql += " where USER_ID LIKE'" + searchVO.getSearchKeyword()
						+ "'";
			} else if (searchVO.getSearchCondition().equals("1")) {
				sql += " where USER_NAME LIKE" + searchVO.getSearchKeyword()
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
		System.out.println("�ο��� ��:" + total);

		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("count", new Integer(total));

		rs.absolute(searchVO.getPage() * searchVO.getPageUnit() - searchVO.getPageUnit()+1);
		System.out.println("searchVO.getPage():" + searchVO.getPage());
		System.out.println("searchVO.getPageUnit():" + searchVO.getPageUnit());

		ArrayList<UserVO> list = new ArrayList<UserVO>();
		if (total > 0) {
			for (int i = 0; i < searchVO.getPageUnit(); i++) {
				UserVO vo = new UserVO();
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
	// �̰� �ǸŸ�Ϻ���� �߸�
	
	public void insertPurchase(PurchaseVO purchaseVO) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "INSERT INTO transaction VALUES (seq_transaction_tran_no.nextval, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?)";
		// tran_no 0 prod_no 1 buyer_id 2 payment_option 3 receiver_name 4 receiver_phone 5
		// demailaddr 6 dlvy_request 7 tran_status_code 8 order_date 9 dlVY_date 10 
		PreparedStatement stmt = con.prepareStatement(sql);
		
		UserVO userVO = purchaseVO.getBuyer();
		
		ProductVO productVO = purchaseVO.getPurchaseProd();

		stmt.setInt(1, productVO.getProdNo());
		stmt.setString(2, userVO.getUserId());
		stmt.setString(3, purchaseVO.getPaymentOption());
		stmt.setString(4, purchaseVO.getReceiverName());
		stmt.setString(5, purchaseVO.getReceiverPhone());
		stmt.setString(6, purchaseVO.getDivyAddr());
		stmt.setString(7, purchaseVO.getDivyRequest());
		stmt.setString(8, "1");
		stmt.setString(9, purchaseVO.getDivyDate());
		stmt.executeUpdate();
		
		con.close();
	}
	
	public void updatePurchase(PurchaseVO purchaseVO) throws Exception {
		// �ٸ��Ŵ�
		// �����̷���ȸ -> No ����(tranNo) -> ���Ż���ȸ����
		// ��ǰ��ȣ / ������ ���̵� / ���Ź�� / �������̸� / �����ڿ���ó / �������ּ� / ���ſ�û���� / �������� / �ֹ��� Ȯ�ΰ���
		// ���� ��ư�� ������
		// �����ھ��̵� �ܼ� display => �����Ұ� (buyer_id)
		// ���Ź�� (select) / �������̸� / �����ڿ���ó / �������ּ� / ���ſ�û���� / ���������� �������� 
		
		
		// tranCode = 1 :: ���� ���ſϷ� ���� 
		// tranCode = 2 :: ���� ����� ����
		// tranCode = 3 :: ���� ��ۿϷ� ����  
		// user���� �����̷���ȸ������ 2���¿��� 3���� �ٲٴ� �� �ۿ� ���� -> 1���� 2 �ٲٴ°� trancode�ΰ�? 
		Connection con = DBUtil.getConnection();

		String sql = 	"UPDATE transaction SET payment_option=?, receiver_name=?, receiver_phone=?, " + 
						"demailaddr=?, dlvy_request=?, dlvy_date=? WHERE tran_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		
		stmt.setString(1, purchaseVO.getPaymentOption());
		stmt.setString(2, purchaseVO.getReceiverName());
		stmt.setString(3, purchaseVO.getReceiverPhone());
		stmt.setString(4, purchaseVO.getDivyAddr());
		stmt.setString(5, purchaseVO.getDivyRequest());
		stmt.setString(6, purchaseVO.getDivyDate());
		stmt.setInt(7, purchaseVO.getTranNo());
		stmt.executeUpdate();
		
		con.close();
	}
	
	public void updateTranCode(PurchaseVO purchaseVO) throws Exception {
		
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
		
		stmt.setString(1, purchaseVO.getTranCode());
		stmt.setInt(2, purchaseVO.getTranNo());

		stmt.executeUpdate();
		
		con.close();
	}

}


