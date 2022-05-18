package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserDao;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	public ProductServiceImpl() {
		// TODO Auto-generated constructor stub
	}
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	@Override
	public void addProduct(Product product) throws Exception {
		productDao.addProduct(product);
		
	}

	@Override
	public Event getProduct(int prodNo) throws Exception {
		return productDao.getProduct(prodNo);
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int totalCount = productDao.getTotalCount(search);
		
		List<Event> list = productDao.getProductList(search);
		totalCount = productDao.getTotalCount(search);
		
		map.put("list", list);
		map.put("total", totalCount);
		return map;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
	}

	@Override
	public void discountProduct(Map<String, Object> map) throws Exception {
		productDao.discountProduct(map);
	}

	@Override
	public void updateDiscountProduct(int prodNo) throws Exception {
		productDao.updateDiscountProduct(prodNo);
	}

	@Override
	public Map<String, Object> getDiscountList(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int totalCount = productDao.getDiscountTotalCount(search);
		List<Event> list = productDao.getDiscountList(search);
		
		map.put("list", list);
		map.put("total", totalCount);
		return map;
	}

}
