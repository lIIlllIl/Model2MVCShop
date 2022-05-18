package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public void insertPurchase(Purchase purchase) throws Exception {
		sqlSession.insert("PurchaseMapper.insertPurchase", purchase);
		sqlSession.insert("PurchaseMapper.insertPurchaseCount", purchase);
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		return sqlSession.selectOne("PurchaseMapper.totalCount", map);
	}

	@Override
	public Purchase findPurchase(int tranNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.selectPurchaseTranNo", tranNo);
	}

	@Override
	public Purchase findPurchase2(int prodNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.selectPurchaseProdNo", prodNo);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, String value) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("currentPage", search.getCurrentPage());
		map.put("pageSize", search.getPageSize());
		
		String tranCode = search.getSearchTranCode();
		if(tranCode != null) {
			tranCode = tranCode.trim();
		}

		System.out.println(tranCode);
		
		map.put("searchTranCode", tranCode);
		map.put("userId", value);
		System.out.println(map);
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
		int total = sqlSession.selectOne("PurchaseMapper.totalCount", map);
		
		map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", total);
		
		return map;
	}

	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getSaleList", search);
		Integer total = sqlSession.selectOne("PurchaseMapper.totalCountSale", search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", total);
		
		return map;
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}

	@Override
	public void deletePurchase(int tranNo) throws Exception {
		sqlSession.delete("PurchaseMapper.deletePurchase", tranNo);
		sqlSession.delete("PurchaseMapper.deleteTCount", tranNo);
	}

	@Override
	public void insertWishPurchase(Purchase purchase) throws Exception {
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		map.put("purchase", purchase);
//		map.put(key, value)
		sqlSession.insert("PurchaseMapper.insertWishPurchase", purchase);
	}

	@Override
	public Map<String, Object> getWishPurchaseList(Search search, String userId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("userId", userId);
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getWishPurchaseList", map);
		Integer total = sqlSession.selectOne("PurchaseMapper.totalWishPurchase", map);
		
		map.put("list", list);
		map.put("totalCount", total);
		
		return map;
	}

	@Override
	public Purchase findWishPurchase(int tranNo) throws Exception {
		Purchase purchase = sqlSession.selectOne("PurchaseMapper.selectWishPurchase", tranNo);
		
		Event event = sqlSession.selectOne("ProductMapper.getProductCount", purchase.getPurchaseProd().getProdNo());
		
		purchase.setPurchaseProd(event.getProduct());
		
		return purchase;
	}

	@Override
	public void updateWishPurchase(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updateWishPurchase" , purchase);
		
	}

	@Override
	public void deleteWishPurchase(int tranNo) throws Exception {
		sqlSession.delete("PurchaseMapper.deleteWishPurchase", tranNo);	
	}

	@Override
	public void insertBasket(int tranNo) throws Exception {
		sqlSession.update("PurchaseMapper.updateBasket", tranNo);
		sqlSession.insert("PurchaseMapper.insertTCount", tranNo);
		sqlSession.insert("PurchaseMapper.insertBasket", tranNo);
		sqlSession.delete("PurchaseMapper.deleteWishPurchase", tranNo);	
	}
	
	

}
