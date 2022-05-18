package com.model2.mvc.service.product;

import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;


public interface ProductService {
	
	public void addProduct(Product product) throws Exception;

	public Product getProduct(int prodNo) throws Exception;

	public Map<String,Object> getProductList(Search search) throws Exception;

	public void updateProduct(Product product) throws Exception;
	
	public void discountProduct(Vector discount) throws Exception;
	
	public void updateDiscountProduct(int prodNo) throws Exception;
	
	public Map<String, Object> getDiscountList(Search search) throws Exception;
	
}