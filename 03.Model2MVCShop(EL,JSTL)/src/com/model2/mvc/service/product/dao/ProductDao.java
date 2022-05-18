package com.model2.mvc.service.product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.dao.UserDao;

public class ProductDao {

	public ProductDao() {
	}
	
	public Product findProduct(int prodNo) throws Exception {
		// product는 product만 관리, transaction은 다른거 -> subQuery 삭제 
		Connection con = DBUtil.getConnection();

		String sql = 	"SELECT " +
						"p.prod_no , p.prod_name , p.prod_detail , p.manufacture_day , TRUNC(p.price * NVL(dc.dc_persent, 1) ) price , " +
						"p.image_file , p.reg_date , c.prod_count - NVL(vt.tran_count , 0) prod_count , NVL(dc.dc_flag , 0) checkDC    " +
						"FROM product p , count c ,  (     SELECT prod_no , SUM ( tran_count ) tran_count FROM t_count GROUP BY prod_no     ) vt ,   " + 
						"(   SELECT prod_no , dc_persent , dc_flag FROM discount WHERE TO_CHAR(SYSDATE , 'YYYYMMDD') >= TO_CHAR(begin_date , 'YYYYMMDD') AND TO_CHAR(SYSDATE , 'YYYYMMDD') <= TO_CHAR(end_date , 'YYYYMMDD') AND dc_flag='1'  )  dc      " + 
						"WHERE p.prod_no = vt.prod_no(+) AND p.prod_no = dc.prod_no(+) AND  p.prod_no = c.prod_no AND p.prod_no=? ";

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
			product.setProdCount(rs.getInt("prod_count"));
			product.setCheckDC(rs.getString("checkDC"));
		}
		
		con.close();

		return product;
	}
	
	public Map<String,Object> getProductList(Search search) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = 	"SELECT " +
						"p.prod_no , p.prod_name , p.prod_detail , p.manufacture_day , TRUNC(p.price * NVL(dc.dc_persent, 1) ) price , " +
						"p.image_file , p.reg_date , c.prod_count - NVL(vt.tran_count , 0) prod_count , NVL(dc.dc_flag , 0) checkDC " +
						"FROM product p , count c ,  (     SELECT prod_no , SUM ( tran_count ) tran_count FROM t_count GROUP BY prod_no     ) vt ,   " + 
						"(   SELECT prod_no , dc_persent , NVL(dc_flag , 0) dc_flag FROM discount WHERE TO_CHAR(SYSDATE , 'YYYYMMDD') >= TO_CHAR(begin_date , 'YYYYMMDD') AND TO_CHAR(SYSDATE , 'YYYYMMDD') <= TO_CHAR(end_date , 'YYYYMMDD') AND dc_flag='1'   )  dc      " + 
						"WHERE p.prod_no = vt.prod_no(+) AND p.prod_no = dc.prod_no(+) AND ";
		
		if (search.getSearchCondition() != null) {
			if (search.getSearchCondition().equals("0") && !search.getSearchKeyword().equals("") ) {
				sql += " p.prod_no LIKE '" + Integer.parseInt(search.getSearchKeyword())
						+ "%' AND ";
			} else if (search.getSearchCondition().equals("1") && !search.getSearchKeyword().equals("") ) {
				sql += " p.prod_name LIKE '" + search.getSearchKeyword()
						+ "%' AND ";
			} else if (search.getSearchCondition().equals("2") && !search.getSearchKeyword().equals("") ) {
				sql += " p.price <= " + Integer.parseInt(search.getSearchKeyword()) 
						+ " AND ";	
			} else if (search.getSearchCondition().equals("3") && !search.getSearchKeyword().equals("") ) {
				sql += " p.price >= " + Integer.parseInt(search.getSearchKeyword()) 
						+ " AND ";
			} else if (search.getSearchCondition().equals("4") && !search.getSearchKeyword().equals("") ) {
				
				String[] priceArray = search.getSearchKeyword().split("~");
				
				int firstPrice = Integer.parseInt(priceArray[0]);
				int secondPrice = Integer.parseInt(priceArray[1]);
				
				if ( firstPrice > secondPrice ) {
					sql += " p.price BETWEEN " + secondPrice + " AND " + firstPrice + " AND ";
				}
				else {
					sql += " p.price BETWEEN " + firstPrice + " AND " + secondPrice + " AND ";
				}
			}
		}
		
		sql += " p.prod_no = c.prod_no ";
		
		if (search.getSearchPrice() != null ) {
			if (search.getSearchPrice().equals("0")) {
				sql += "ORDER BY p.prod_no ";
			}
			else if (search.getSearchPrice().equals("1")) {
				sql += "ORDER BY p.price ASC ";
			}
			else {
				sql += "ORDER BY p.price DESC ";
			}
		}
		
		int totalCount = this.getTotalCount(sql);
		
		sql = makeCurrentPageSql(sql, search);
		
		PreparedStatement stmt = con.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
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
				product.setProdCount(rs.getInt("prod_count"));
				product.setCheckDC(rs.getString("checkDC"));

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

		String sql = 	"INSERT INTO " +
						"product(prod_no, prod_name, prod_detail, manufacture_day, price, image_file, reg_date) " +
						"values(seq_product_prod_no.nextval, ?, ?, ?, ?, ?, sysdate)";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		System.out.println("insert >>>> : " + product.getFileName());
		stmt.setString(1, product.getProdName());
		stmt.setString(2, product.getProdDetail());
		stmt.setString(3, product.getManuDate());
		stmt.setInt(4, product.getPrice());
		stmt.setString(5, product.getFileName());
		
		stmt.executeUpdate();
		
		sql = "INSERT INTO count(prod_no, prod_count) VALUES(seq_product_prod_no.currval, ?)";
		
		stmt = con.prepareStatement(sql);
		stmt.setInt(1, product.getProdCount());
		stmt.executeUpdate();
		
		con.close();
	}
	
	public void updateProduct(Product product) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = 	"UPDATE product  " +
						"SET prod_name=?, prod_detail=?, manufacture_day=?, price=?, image_file=? WHERE prod_no=?";
		System.out.println(product);
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, product.getProdName());
		stmt.setString(2, product.getProdDetail());
		stmt.setString(3, product.getManuDate());
		stmt.setInt(4, product.getPrice());
		stmt.setString(5, product.getFileName());
		stmt.setInt(6,  product.getProdNo());
		stmt.executeUpdate();
		
		sql = 	"UPDATE count " +
				"SET prod_count=? " + 
				"WHERE prod_no=?";
		
		stmt = con.prepareStatement(sql);
		
		stmt.setInt(1,  product.getProdCount());
		stmt.setInt(2,  product.getProdNo());
		stmt.executeUpdate();
		
		con.close();
	}
	
	public void updateDiscount(int prodNo) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = 	"UPDATE discount  " +
						"SET dc_flag='2' WHERE prod_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);
		stmt.executeUpdate();
		
		con.close();
	}
	
	public void discountProduct(Vector vector) throws Exception {
		double discountPercent = (double)vector.get(0);
		
		String sDate = (String)vector.get(1);
		String startDate = sDate.replace("-", "");
		
		String eDate = (String)vector.get(2);
		String endDate = eDate.replace("-", "");
		
		int prodNo = Integer.parseInt((String) vector.get(3));
		
		Connection con = DBUtil.getConnection();
		
		String sql = 	"INSERT " + 
						"INTO discount( prod_no , dc_persent , begin_date , end_date, dc_flag) " + 
						"VALUES ( ? , ? , TO_DATE(? , 'YYYY/MM/DD') , TO_DATE(? , 'YYYY/MM/DD') , 1 )" ;
	
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);
		stmt.setDouble(2, discountPercent);
		stmt.setString(3, startDate);
		stmt.setString(4, endDate);
		
		stmt.executeUpdate();
		
		con.close();
	}
	
	public Map<String,Object> getDiscountList(Search search) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = 	"SELECT " + 
						"p.prod_no , p.prod_name , p.image_file , p.price ," + 
						"TRUNC( p.price * dc.dc_persent ) dc_price , dc.dc_persent , " + 
						"dc.begin_date , dc.end_date , dc.dc_flag  " + 
						"FROM product p , discount dc " + 
						"WHERE p.prod_no = dc.prod_no ";
		
		int totalCount = this.getTotalCount(sql);
		
		sql = makeCurrentPageSql(sql, search);
		
		PreparedStatement stmt = con.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		List<Product> listProduct = new ArrayList<Product>();
		List<Event> listEvent = new ArrayList<Event>();
		
		while(rs.next()){
			Product product = new Product();
			Event event = new Event();
			
			product.setProdNo(rs.getInt("prod_no"));
			product.setProdName(rs.getString("prod_name"));
			product.setFileName(rs.getString("image_file"));
			product.setCostPrice(rs.getInt("price"));
			product.setPrice(rs.getInt("dc_price"));
			event.setDcPersent(rs.getDouble("dc_persent"));
			System.out.println(">>>>> dc_persent : " + rs.getDouble("dc_persent"));
			event.setStartDate(rs.getDate("begin_date"));
			event.setEndDate(rs.getDate("end_date"));
			event.setProduct(product);
			product.setCheckDC(rs.getString("dc_flag"));

			listEvent.add(event);
		}
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("totalCount", new Integer(totalCount));
		map.put("list", listEvent);

		con.close();
		
		return map;
	}
	
	private int getTotalCount(String sql) throws Exception {
		
		sql = 	"SELECT COUNT(*) "+
		        "FROM ( " + sql + " ) countTable";
		
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
