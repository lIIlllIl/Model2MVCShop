package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductDao {
	public void addProduct(Product product) throws Exception;

	public Event getProduct(int prodNo) throws Exception;

	public List<Event> getProductList(Search search) throws Exception;

	public void updateProduct(Product product) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
	public void discountProduct(Map<String, Object> map) throws Exception;
	
	public void updateDiscountProduct(int prodNo) throws Exception;
	
	public List<Event> getDiscountList(Search search) throws Exception;
	
	public int getDiscountTotalCount(Search search) throws Exception;
	
	public List<String> getEnterProduct(String dataType, String dataName) throws Exception;
}
