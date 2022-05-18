package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class PurchaseServiceTest {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
//	@Test
	public void testInsertPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		purchase.setTranCount(5);
		
		Product product = productService.getProduct(10000);
		purchase.setPurchaseProd(product);
		
		User user = userService.getUser("user10");
		purchase.setBuyer(user);
		purchase.setPaymentOption("1");
		
		purchaseService.addPurchase(purchase);
		
	}
	
//	@Test
	public void testGetPurchaseTranNo() throws Exception {
		
		Purchase purchase = purchaseService.getPurchase(10008);
		System.out.println(purchase);
		Assert.assertEquals("user10", purchase.getBuyer().getUserId());
		Assert.assertEquals(10008, purchase.getTranNo());
		Assert.assertEquals(10000, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("1", purchase.getPaymentOption().trim());
		Assert.assertEquals("1", purchase.getTranCode().trim());
		
		
	}
	
//	@Test
	public void testGetPurchaseProdNo() throws Exception {
		
		Purchase purchase = purchaseService.getPurchase2(10000);
		System.out.println(purchase);
		Assert.assertEquals("user10", purchase.getBuyer().getUserId());
		Assert.assertEquals(10008, purchase.getTranNo());
		Assert.assertEquals(10000, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("1", purchase.getPaymentOption().trim());
		Assert.assertEquals("1", purchase.getTranCode().trim());
	}
	
//	@Test
	public void testUpdatePurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		purchase.setReceiverName("fffff");
		
		User user = userService.getUser("user10");
		purchase.setBuyer(user);
		
		purchase.setTranNo(10008);
		
		Product product = productService.getProduct(10000);
		purchase.setPurchaseProd(product);
		
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(10008);
		
		System.out.println(purchase);
		Assert.assertEquals("fffff", purchase.getReceiverName());
		Assert.assertEquals(10000 , purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user10", purchase.getBuyer().getUserId());
		Assert.assertEquals(10008, purchase.getTranNo());
		
	}
	
//	@Test
	public void updatePurchaseTranCode() throws Exception {
		
		Purchase purchase = new Purchase();
		
		purchase.setTranNo(10008);
		purchase.setTranCode("2");
		
		purchaseService.updateTranCode(purchase);
		
		purchase = purchaseService.getPurchase(10008);
		
		System.out.println(purchase);
		Assert.assertEquals("2", purchase.getTranCode().trim());
		
	}
	
//	@Test
	public void getListPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, "user10");
		
		List<Purchase> list = (List<Purchase>)map.get("list");
		Integer total = (Integer)map.get("totalCount");
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
		System.out.println(total);
		
		Assert.assertEquals(1, list.size());
		Assert.assertEquals(new Integer(1), total);
	}
	
//	@Test
	public void getSalePurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		
		List<Purchase> list = (List<Purchase>)map.get("list");
		Integer total = (Integer)map.get("totalCount");
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
		System.out.println(total);
		
		Assert.assertEquals(1, list.size());
		Assert.assertEquals(new Integer(1), total);
	}
	
//	@Test
	public void getListPurchaseSearchTranCode() throws Exception {
		
		Purchase purchase = new Purchase();
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchTranCode("3");
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, "user01");
		
		List<Purchase> list = (List<Purchase>)map.get("list");
		Integer total = (Integer)map.get("totalCount");
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
		System.out.println(total);
		
		Assert.assertEquals(1, list.size());
		Assert.assertEquals(new Integer(1), total);
	}
	
	@Test
	public void getSalePurchaseTranCode() throws Exception {
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(5);
		search.setSearchTranCode("2");
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		
		List<Purchase> list = (List<Purchase>)map.get("list");
		Integer total = (Integer)map.get("totalCount");
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
		System.out.println(total);
		
		Assert.assertEquals(0, list.size());
		Assert.assertEquals(new Integer(0), total);
	}
}
