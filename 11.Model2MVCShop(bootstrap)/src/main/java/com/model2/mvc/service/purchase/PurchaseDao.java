package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

	public void insertPurchase(Purchase purchase) throws Exception;
	
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
	public Purchase findPurchase(int tranNo) throws Exception;
	
	public Purchase findPurchase2(int prodNo) throws Exception;
	
	public Map<String, Object> getPurchaseList(Search search, String value) throws Exception;
	
	public Map<String, Object> getSaleList(Search search) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	public void deletePurchase(int tranNo) throws Exception;
	
	public void insertWishPurchase(Purchase purchase) throws Exception;
	
	public Map<String, Object> getWishPurchaseList(Search search, String userId) throws Exception;
	
	public Purchase findWishPurchase(int tranNo) throws Exception;
	
	public void updateWishPurchase(Purchase purchase) throws Exception;
	
	public void deleteWishPurchase(int tranNo) throws Exception;
	
	public void insertBasket(int tranNo) throws Exception;
	
	public List<String> getEnterPurchase(String dataType, String dataName) throws Exception;
}
