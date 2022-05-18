package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.dao.ProductDao;
import com.model2.mvc.service.domain.Product;

public class ProductServiceImpl implements ProductService {
	
	private ProductDao productDao;
	
	public ProductServiceImpl() {
		productDao = new ProductDao();
	}
	
	public void addProduct(Product product) throws Exception {
		productDao.insertProduct(product);
	}

	public Product getProduct(int prodNo) throws Exception {
		return productDao.findProduct(prodNo);
	}

	public Map<String,Object> getProductList(Search search) throws Exception {
		return productDao.getProductList(search);
	}

	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
	}

	@Override
	public void discountProduct(Vector discount) throws Exception {
		productDao.discountProduct(discount);
	}

	@Override
	public void updateDiscountProduct(int prodNo) throws Exception {
		productDao.updateDiscount(prodNo);
	}

	@Override
	public Map<String, Object> getDiscountList(Search search) throws Exception {
		return productDao.getDiscountList(search);
	}
}
