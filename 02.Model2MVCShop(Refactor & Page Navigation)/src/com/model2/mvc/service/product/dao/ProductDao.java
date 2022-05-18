package com.model2.mvc.service.product.dao;

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
import com.model2.mvc.service.domain.User;

public class ProductDao {

	public ProductDao() {
	}
	
	public Product findProduct(int prodNo) throws Exception {
		// product 안에는 trans가 없다 -> product랑 trans랑 같이 쓰도록 해서 출력해야함 
		Connection con = DBUtil.getConnection();

		String sql = 	"SELECT " +
						"p.prod_no, p.prod_name, p.prod_detail, p.manufacture_day, p.price, " +
						"p.image_file, p.reg_date, NVL(t.tran_status_code, 0) tran_status_code " +
						"FROM product p, transaction t " +
						"WHERE p.prod_no = t.prod_no(+) " +
						"AND p.prod_no = ?";

		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);

		ResultSet rs = stmt.executeQuery();

		Product product = null;
		while (rs.next()) {
			product = new Product();
			product.setProdNo(rs.getInt("prod_no"));
			product.setProdName(rs.getString("prod_name"));
			product.setProdDetail(rs.getString("prod_detail"));
			product.setManuDate(rs.getString("manufacture_day"));
			product.setPrice(rs.getInt("price"));
			product.setFileName(rs.getString("image_file"));
			product.setRegDate(rs.getDate("reg_date"));
			product.setProTranCode(rs.getString("TRAN_STATUS_CODE"));
		}
		
		con.close();

		return product;
	}
	
	public Map<String,Object> getProductList(Search search) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT product.*, NVL(transaction.tran_status_code, 0) trancode FROM product, transaction WHERE";
		if (search.getSearchCondition() != null) {
			
			if (search.getSearchCondition().equals("0") && !search.getSearchKeyword().equals("") ) {
				sql += " product.prod_no LIKE '" + Integer.parseInt(search.getSearchKeyword())
						+ "%' AND";
			} else if (search.getSearchCondition().equals("1") && !search.getSearchKeyword().equals("") ) {
				sql += " product.prod_name LIKE '" + search.getSearchKeyword()
						+ "%' AND";
			} else if (search.getSearchCondition().equals("2") && !search.getSearchKeyword().equals("") ) {
				sql += " product.price <= " + Integer.parseInt(search.getSearchKeyword()) 
						+ " AND ";	
			}
			
		}
	
		sql += " product.prod_no = transaction.prod_no(+) ORDER BY product.prod_no";
		
		System.out.println("ProductDao Original SQL ==> " + sql);
		
		int totalCount = this.getTotalCount(sql);
		System.out.println("ProductDao totalCount : " + totalCount);
		
		sql = makeCurrentPageSql(sql, search);
		
		PreparedStatement stmt = con.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println(search);

		List<Product> list = new ArrayList<Product>();
		
		while(rs.next()){
			Product product = new Product();
			product.setProdNo(rs.getInt("prod_no"));
			product.setProdName(rs.getString("prod_name"));
			product.setProdDetail(rs.getString("prod_detail"));
			product.setManuDate(rs.getString("manufacture_day"));
			product.setPrice(rs.getInt("price"));
			product.setFileName(rs.getString("image_file"));
			product.setRegDate(rs.getDate("reg_date"));
			product.setProTranCode(rs.getString("trancode"));
			list.add(product);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("totalCount", new Integer(totalCount));
		map.put("list", list);
		System.out.println(map.get("list"));
		con.close();
			
		return map;
	}
	
	public void insertProduct(Product product) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "INSERT INTO product values(seq_product_prod_no.nextval, ?, ?, ?, ?, ?, sysdate)";
		
		PreparedStatement stmt = con.prepareStatement(sql);

		stmt.setString(1, product.getProdName());
		stmt.setString(2, product.getProdDetail());
		stmt.setString(3, product.getManuDate());
		stmt.setInt(4, product.getPrice());
		stmt.setString(5, product.getFileName());
		stmt.executeUpdate();
		
		con.close();
	}
	
	public void updateProduct(Product product) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE product SET prod_name=?, prod_detail=?, manufacture_day=?, price=?, image_file=? WHERE prod_no=?";
		System.out.println(product);
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, product.getProdName());
		stmt.setString(2, product.getProdDetail());
		stmt.setString(3, product.getManuDate());
		stmt.setInt(4, product.getPrice());
		stmt.setString(5, product.getFileName());
		stmt.setInt(6,  product.getProdNo());
		stmt.executeUpdate();
		
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
		
		System.out.println("ProductDao makeCurrentPageSql : " + sql);	
		
		return sql;
	}
}
