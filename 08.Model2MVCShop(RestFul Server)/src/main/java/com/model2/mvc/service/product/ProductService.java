package com.model2.mvc.service.product;

import java.util.Map;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductService {
	
	public void addProduct(Product product) throws Exception;

	public Event getProduct(int prodNo) throws Exception;

	public Map<String,Object> getProductList(Search search) throws Exception;

	public void updateProduct(Product product) throws Exception;

	public void discountProduct(Map<String, Object> map) throws Exception;
	
	public void updateDiscountProduct(int prodNo) throws Exception;
	
	public Map<String, Object> getDiscountList(Search search) throws Exception;
}
