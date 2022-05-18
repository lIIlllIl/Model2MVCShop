package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao {

	public ProductDaoImpl() {
		// TODO Auto-generated constructor stub
	}
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void addProduct(Product product) throws Exception {
		sqlSession.insert("ProductMapper.insertProduct", product);
		sqlSession.insert("ProductMapper.insertProductCount", product);
	}

	@Override
	public Event getProduct(int prodNo) throws Exception {
		return sqlSession.selectOne("ProductMapper.getProductCount", prodNo);
	}

	@Override
	public List<Event> getProductList(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Event> list = sqlSession.selectList("ProductMapper.getProductList", search);
		return list;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		sqlSession.update("ProductMapper.updateProduct", product);
		sqlSession.update("ProductMapper.updateProductCount", product);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.totalCount", search);
	}

	@Override
	public void discountProduct(Map<String, Object> map) throws Exception {
		sqlSession.insert("ProductMapper.discountProduct", map);
	}

	@Override
	public void updateDiscountProduct(int prodNo) throws Exception {
		sqlSession.update("ProductMapper.updateDiscount", prodNo);
	}

	@Override
	public List<Event> getDiscountList(Search search) throws Exception {
		List<Event> list = sqlSession.selectList("ProductMapper.getDiscountList", search);
		return list;
	}

	@Override
	public int getDiscountTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.discountTotalCount", search);
	}

	@Override
	public List<String> getEnterProduct(String dataName, String dataType) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("dataType", dataType);
		map.put("dataName", dataName);
		
		return sqlSession.selectList("ProductMapper.enterProduct", map);
	}

}
