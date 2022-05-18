package com.model2.mvc.web.purchase;

import java.io.InputStream;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value = "json/addPurchase" , method = RequestMethod.POST)
	public Purchase addPurchase ( @RequestBody Purchase purchase ) throws Exception {
		
		purchaseService.addPurchase(purchase);
		
		return purchase;
	}

	@RequestMapping( value = "json/listPurchase" , method = RequestMethod.POST)
	public Map<String, Object> listPurchase( @RequestBody Map<String, Object> map ) throws Exception {
		System.out.println("requestbody map ??? : " + map);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String mapString = objectMapper.writeValueAsString(map);
		System.out.println("mapString ????? : " + mapString);
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);

		User user = objectMapper.readValue(jsonObject.get("user").toString(), new TypeReference<User>() {});
		Search search = objectMapper.readValue(jsonObject.get("search").toString(), new TypeReference<Search>() {});
		
		search.setPageSize(pageSize);
		
		return purchaseService.getPurchaseList(search, user.getUserId());

	}
	
	@RequestMapping( value = "json/listPurchase/{userId}/{currentPage}" , method = RequestMethod.GET)
	public Map<String, Object> listPurchase( @PathVariable String userId , 
												@PathVariable int currentPage ) throws Exception {
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		
		return purchaseService.getPurchaseList(search, userId);

	}
	
	@RequestMapping( value = "json/listSale" , method = RequestMethod.POST)
	public Map<String, Object> listSale( @RequestBody Search search ) throws Exception {
		search.setPageSize(pageSize);
		
		return purchaseService.getSaleList(search);
	}
	
	@RequestMapping( value = "json/listSale/{currentPage}", method = RequestMethod.GET)
	public Map<String, Object> listSale( @PathVariable int currentPage ) throws Exception {
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		
		return purchaseService.getSaleList(search);
	}
	
	
	@RequestMapping( value = "json/updateTranCode/{tranNo}/{tranCode}" , method = RequestMethod.GET)
	public Purchase updatePurchase( @PathVariable String tranCode, @PathVariable int tranNo ) throws Exception {
		Purchase purchase = null;
		
		if ( tranCode.equals("3")) {
			purchase = purchaseService.getPurchase(tranNo);
			purchase.setTranCode(tranCode);
			purchaseService.updateTranCode(purchase);
		}
		else if ( tranCode.equals("4") ) {
			purchaseService.deletePurchase(tranNo);
		}
		else if ( tranCode.equals("2") ) {
			purchase = purchaseService.getPurchase(tranNo);
			purchase.setTranCode(tranCode);
			purchaseService.updateTranCode(purchase);
		}
		
		return purchase;
	}
	
	@RequestMapping( value = "json/getPurchase/{tranNo}" , method = RequestMethod.GET)
	public Purchase getPurchase ( @PathVariable int tranNo ) throws Exception {
		
		return purchaseService.getPurchase(tranNo);
	}
	
	@RequestMapping( value = "json/updatePurchase", method = RequestMethod.POST)
	public Purchase updatePurchase ( @RequestBody Purchase purchase ) throws Exception {
		
		purchaseService.updatePurchase(purchase);
		
		return purchaseService.getPurchase(purchase.getTranNo());
	}
	
	@RequestMapping ( value = "json/addWishPurchase", method = RequestMethod.POST)
	public Purchase addWishPurchase( @RequestBody Purchase purchase ) throws Exception {
		
		purchaseService.addWishPurchase(purchase);
		
		
		return purchase;
	}
	
	@RequestMapping( value = "json/listWishPurchase", method = RequestMethod.POST)
	public Map<String, Object> listWishPurchase( @RequestBody Map<String, Object> map ) throws Exception {
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String mapString = objectMapper.writeValueAsString(map);
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);

		User user = objectMapper.readValue(jsonObject.get("user").toString(), new TypeReference<User>() {});
		Search search = objectMapper.readValue(jsonObject.get("search").toString(), new TypeReference<Search>() {});
		
		search.setPageSize(pageSize);
		
		return purchaseService.getWishPurchaseList(search, user.getUserId());
	}
	
	@RequestMapping( value = "json/listWishPurchase/{userId}/{currentPage}" , method = RequestMethod.GET)
	public Map<String, Object> listWishPurchase( @PathVariable String userId , 
												@PathVariable int currentPage ) throws Exception {
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		
		return purchaseService.getWishPurchaseList(search, userId);

	}
	
	@RequestMapping( value = "json/getWishPurchase/{tranNo}", method = RequestMethod.GET)
	public Purchase getWishPurchase( @PathVariable int tranNo ) throws Exception {
		
		return purchaseService.getWishPurchase(tranNo);
	}
	
	@RequestMapping( value = "json/updateWishPurchase" , method = RequestMethod.POST)
	public Purchase updateWishPurchase( @RequestBody Purchase purchase) throws Exception {
		
		purchaseService.updateWishPurchase(purchase);
		
		return purchaseService.getWishPurchase(purchase.getTranNo());
	}
	
	@RequestMapping( value = "json/checkWishPurchase/{tranNo}" , method = RequestMethod.GET)
	public Purchase BuyWishPurchase( @PathVariable int tranNo ) throws Exception {
		
		Purchase purchase = purchaseService.getWishPurchase(tranNo);
		Event eventProduct = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		
		Purchase returnPurchase = new Purchase();
		if ( eventProduct.getProduct().getProdCount() >= purchase.getTranCount() ) {
			purchaseService.insertBasket(tranNo);
			returnPurchase = purchaseService.getPurchase(tranNo);
		}
		
		return returnPurchase;
	}
	
	@RequestMapping( value = "json/deleteWishPurchase/{tranNo}", method = RequestMethod.GET)
	public void deleteBasket( @PathVariable int tranNo ) throws Exception {
		
		purchaseService.deleteWishPurchase(tranNo);
	}
 }
