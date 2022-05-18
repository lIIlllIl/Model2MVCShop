package com.model2.mvc.service.product.test;

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
import com.model2.mvc.service.product.ProductService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class ProductServiceTest {

	public ProductServiceTest() {
		// TODO Auto-generated constructor stub
	}
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Test
	public void testGetProduct() throws Exception {
		
		Product product = new Product();
		
		product = productService.getProduct(10001);

		System.out.println(product);
		
//		Assert.assertEquals(10015, product.getProdNo());
//		Assert.assertEquals("가건가", product.getProdName());
//		Assert.assertEquals("소니 바이오 노트북 신동품", product.getProdDetail());
//		Assert.assertEquals("20120514", product.getManuDate());
//		Assert.assertEquals(0, product.getPrice());
//		Assert.assertEquals("AHlbAAAAtBqyWAAA.jpg", product.getFileName());
//		Assert.assertEquals(2012-12-14, product.getRegDate());
		
	}
	
//	@Test
	public void testInsertProduct() throws Exception {
		Product product = new Product();
		
		product.setProdName("자전차");
		product.setProdCount(30);
		product.setManuDate("2010-10-10");
		
		System.out.println(product.getProdName());
		System.out.println(product.getProdCount());
		System.out.println(product.getManuDate());
		
		productService.addProduct(product);

	}
	
//	@Test
	public void testUpdateProduct() throws Exception {
		Product product = new Product();
		
		product.setProdName("가건가");
		product.setProdNo(10015);
		product.setProdCount(9999);
		
		productService.updateProduct(product);
	}

//	@Test
	public void testGetProductListAll() throws Exception {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(5);
		
		Map<String, Object> map = productService.getProductList(search);
		List<Product> list = (List<Product>)map.get("list");
		Integer totalCount = (Integer)map.get("total");
		System.out.println("totalCount : " + totalCount);
		
		Assert.assertEquals(5, list.size());
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
	}
	
//	@Test
	public void testGetProductListNum() throws Exception {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("0");
		search.setSearchKeyword("1000");
		
		Map<String, Object> map = productService.getProductList(search);
		List<Product> list = (List<Product>)map.get("list");
		Integer totalCount = (Integer)map.get("total");
		System.out.println("totalCount : " + totalCount);
		
		Assert.assertEquals(3, list.size());
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
	}
	
//	@Test
	public void testGetProductListName() throws Exception {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("1");
		search.setSearchKeyword("자전");
		
		Map<String, Object> map = productService.getProductList(search);
		List<Product> list = (List<Product>)map.get("list");
		Integer totalCount = (Integer)map.get("total");
		System.out.println("totalCount : " + totalCount);
		
		Assert.assertEquals(1, list.size());
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
	}
	
//	@Test
	public void testGetProductListPriceUnder() throws Exception {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("2");
		search.setSearchKeyword("1000000");
		
		Map<String, Object> map = productService.getProductList(search);
		List<Product> list = (List<Product>)map.get("list");
		Integer totalCount = (Integer)map.get("total");
		System.out.println("totalCount : " + totalCount);
		
		Assert.assertEquals(3, list.size());
		Assert.assertEquals(new Integer(7), new Integer(totalCount));
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
	}
	
//	@Test
	public void testGetProductListPriceOver() throws Exception {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("3");
		search.setSearchKeyword("1000000");
		search.setSearchPrice("1");
		
		Map<String, Object> map = productService.getProductList(search);
		List<Product> list = (List<Product>)map.get("list");
		Integer totalCount = (Integer)map.get("total");
		System.out.println("totalCount : " + totalCount);
		
		Assert.assertEquals(2, list.size());
		Assert.assertEquals(new Integer(2), new Integer(totalCount));
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
	}
	
//	@Test
	public void testGetProductListPriceBetween() throws Exception {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(5);
		search.setSearchCondition("4");
		search.setSearchKeyword("1~1000000");
		search.setSearchPrice("2");
		
		Map<String, Object> map = productService.getProductList(search);
		List<Product> list = (List<Product>)map.get("list");
		Integer totalCount = (Integer)map.get("total");
		System.out.println("totalCount : " + totalCount);
		
//		Assert.assertEquals(5, list.size());
//		Assert.assertEquals(new Integer(6), new Integer(6));
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
	}
}
