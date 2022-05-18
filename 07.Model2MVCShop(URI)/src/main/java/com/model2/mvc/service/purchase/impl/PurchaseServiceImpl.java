package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	
	@Override
	public void addPurchase(Purchase purchase) throws Exception {
		purchaseDao.insertPurchase(purchase);
	}

	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		return purchaseDao.findPurchase(tranNo);
	}

	@Override
	public Purchase getPurchase2(int prodNo) throws Exception {
		return purchaseDao.findPurchase2(prodNo);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {
		return purchaseDao.getPurchaseList(search, buyerId);
	}

	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		return purchaseDao.getSaleList(search);
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
	}

	@Override
	public void deletePurchase(int tranNo) throws Exception {
		purchaseDao.deletePurchase(tranNo);
	}

	@Override
	public void addWishPurchase(Purchase purchase) throws Exception {
		purchaseDao.insertWishPurchase(purchase);
		
	}

	@Override
	public Map<String, Object> getWishPurchaseList(Search search, String userId) throws Exception {
		return purchaseDao.getWishPurchaseList(search, userId);
	}

	@Override
	public Purchase getWishPurchase(int tranNo) throws Exception {
		return purchaseDao.findWishPurchase(tranNo);
	}

	@Override
	public void updateWishPurchase(Purchase purchase) throws Exception {
		purchaseDao.updateWishPurchase(purchase);	
	}

	@Override
	public void deleteWishPurchase(int tranNo) throws Exception {
		purchaseDao.deleteWishPurchase(tranNo);		
	}

	@Override
	public void insertBasket(int tranNo) throws Exception {
		purchaseDao.insertBasket(tranNo);	
	}

}
