package com.model2.mvc.web.purchase;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value = "addPurchase" , method = RequestMethod.GET)
	public String addPurchaseView( @RequestParam("prodNo") int prodNo, 
									HttpServletRequest request, 
									HttpSession session, Model model) throws Exception {
		
//		User user = (User)session.getAttribute("user");
		
		Event event = productService.getProduct(prodNo);
		
//		model.addAttribute("user", user);
		model.addAttribute("event", event);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping( value = "addPurchase" , method = RequestMethod.POST)
	public String addPurchase( @ModelAttribute("purchase") Purchase purchase , 
								@RequestParam("prodNo") int prodNo , 
								HttpServletRequest request , 
								HttpSession session , 
								Model model) throws Exception {

		User user = (User)session.getAttribute("user");
		Event event = productService.getProduct(prodNo);
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(event.getProduct());
		
		if(purchase.getDivyDate() != null) {
			purchase.setDivyDate(purchase.getDivyDate().replace("-", ""));
		}
		
		model.addAttribute("purchase", purchase);
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping( value = "/listPurchase" )
	public String getPurchaseList( @ModelAttribute("search") Search search , 
										HttpServletRequest request , 
										HttpSession session , 
										Model model) throws Exception {
		
		if ( search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}
		
		if ( search.getSearchTranCode() != null ) {
			if ( search.getSearchTranCode().trim().equals("0") ) {
				search.setSearchTranCode(null);
			}
			else { 
				search.setSearchTranCode(search.getSearchTranCode());
			}
		}
		else { 
			search.setSearchTranCode(search.getSearchTranCode());
		}
			
		
		System.out.println(search);
		search.setPageSize(pageSize);
		search.setSearchCondition(search.getSearchCondition());
		
		
		User user = (User)session.getAttribute("user");
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		List<Purchase> list = (List<Purchase>)map.get("list");
		
		for ( int i = 0; i < list.size(); i++) {
			Purchase listPurchase = new Purchase();
			listPurchase = list.get(i);
			
			Event listEvent = new Event();
			listEvent = productService.getProduct(listPurchase.getPurchaseProd().getProdNo());
			
			listPurchase.setPurchaseProd(listEvent.getProduct());
			listPurchase.setBuyer(user);
			
			list.set(i, listPurchase);
		}
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
		
	}
	
	@RequestMapping( value = "listSale" )
	public String getSaleList( @ModelAttribute("search") Search search , 
										HttpServletRequest request , 
										Model model) throws Exception {
		
		if ( search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}
		
		if ( search.getSearchTranCode() != null ) {
			if ( search.getSearchTranCode().trim().equals("0") ) {
				search.setSearchTranCode(null);
			}
			else { 
				search.setSearchTranCode(search.getSearchTranCode());
			}
		}
		else { 
			search.setSearchTranCode(search.getSearchTranCode());
		}
		
		System.out.println(search);
		search.setPageSize(pageSize);
		search.setSearchCondition(search.getSearchCondition());
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		List<Purchase> list = (List<Purchase>)map.get("list");
		
		for ( int i = 0; i < list.size(); i++) {
			Purchase listPurchase = new Purchase();
			listPurchase = list.get(i);
			
			Event listEvent = new Event();
			listEvent = productService.getProduct(listPurchase.getPurchaseProd().getProdNo());
			
			listPurchase.setPurchaseProd(listEvent.getProduct());
			
			list.set(i, listPurchase);
		}
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listSales.jsp";
		
	}
	
	@RequestMapping( value = "updateTranCode" )
	public String updateTranCode( @RequestParam("tranNo") int tranNo , 
									@RequestParam("tranCode") String tranCode , 
									HttpServletRequest request) throws Exception {
		
		Purchase purchase = null;

		String path = "";
		
		if ( tranCode.equals("3")) {
			purchase = purchaseService.getPurchase(tranNo);
			purchase.setTranCode(tranCode);
			purchaseService.updateTranCode(purchase);
			request.setAttribute("purchase", purchase);
			path = "forward:/purchase/listPurchase";
		}
		else if ( tranCode.equals("4") ) {
			purchaseService.deletePurchase(tranNo);
			path = "forward:/purchase/listPurchase";
		}
		else if ( tranCode.equals("2") ) {
			purchase = purchaseService.getPurchase(tranNo);
			purchase.setTranCode(tranCode);
			purchaseService.updateTranCode(purchase);
			request.setAttribute("purchase", purchase);
			path = "forward:/purchase/listSale";
		}
		
		return path;
	}
	
	@RequestMapping( value = "getPurchase")
	public String getPurchase( @RequestParam("tranNo") int tranNo ,  
								Model model) throws Exception {
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/readPurchase.jsp";
	}
	
	@RequestMapping( value = "updatePurchase" , method = RequestMethod.GET )
	public String updatePurchase( @RequestParam("tranNo") int tranNo , 
									Model model ) throws Exception {
		Purchase purchase = purchaseService.getPurchase(tranNo);
		model.addAttribute(purchase);
	
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	@RequestMapping( value = "updatePurchase" , method = RequestMethod.POST )
	public String updatePurchase( @ModelAttribute("purchase") Purchase purchase , 
									@RequestParam("tranNo") int tranNo , 
									HttpServletRequest request, 
									Model model) throws Exception {
		
		purchaseService.updatePurchase(purchase);
		purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute(purchase);
		
		return "forward:/purchase/readPurchase.jsp";
	}
	
	@RequestMapping( value = "addWishPurchase" )
	public String addWishPurchase( @ModelAttribute("purchase") Purchase purchase , 
								@RequestParam("prodNo") int prodNo , 
								HttpServletRequest request , 
								HttpSession session , 
								Model model) throws Exception {

		User user = (User)session.getAttribute("user");
		Event event = productService.getProduct(prodNo);
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(event.getProduct());
		
		if(purchase.getDivyDate() != null) {
			purchase.setDivyDate(purchase.getDivyDate().replace("-", ""));
		}
		
		model.addAttribute("purchase", purchase);

		purchaseService.addWishPurchase(purchase);
		
		return "forward:/purchase/addWishPurchase.jsp";
	}
	
	@RequestMapping( value = "listWishPurchase" )
	public String getWishPurchaseList( @ModelAttribute("search") Search search , 
										HttpServletRequest request , 
										HttpSession session , 
										Model model) throws Exception {
		
		if ( search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}
		
		System.out.println(search);
		search.setPageSize(pageSize);
		search.setSearchCondition(search.getSearchCondition());
		
		User user = (User)session.getAttribute("user");
		
		Map<String, Object> map = purchaseService.getWishPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		List<Purchase> list = (List<Purchase>)map.get("list");
		
		for ( int i = 0; i < list.size(); i++) {
			Purchase listPurchase = new Purchase();
			listPurchase = list.get(i);
			
			Event listEvent = new Event();
			listEvent = productService.getProduct(listPurchase.getPurchaseProd().getProdNo());
			
			listPurchase.setPurchaseProd(listEvent.getProduct());
			
			list.set(i, listPurchase);
		}
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listWishPurchase.jsp";
		
	}
	
	@RequestMapping( value = "getWishPurchase" , method = RequestMethod.GET )
	public String getWishPurchase( @RequestParam("tranNo") int tranNo , 
									Model model ) throws Exception {
		
		Purchase purchase = purchaseService.getWishPurchase(tranNo);
		model.addAttribute("purchase" , purchase);
		
		return "forward:/purchase/readWishPurchase.jsp";
		
	}
	
	@RequestMapping( value = "checkPurchase" )
	public String checkPurchase ( @RequestParam("tranNo") int tranNo , 
									Model model) throws Exception {
		
		Purchase purchase = purchaseService.getWishPurchase(tranNo);
		System.out.println("purchase? " + purchase);
		Event eventProduct = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		System.out.println("product? " + eventProduct);
		
		String path = "";
		
		if ( eventProduct.getProduct().getProdCount() >= purchase.getTranCount() ) {
			purchaseService.insertBasket(tranNo);
			path = "forward:/purchase/listPurchase";
		}
		else {
			path = "forward:/purchase/checkPurchase.jsp";
		}
		
		return path;
	}
	
	@RequestMapping( value = "updateWishPurchase" , method = RequestMethod.GET)
	public String updateWishPurchaseView ( @RequestParam("tranNo") int tranNo , 
											Model model) throws Exception {
		
		Purchase purchase = purchaseService.getWishPurchase(tranNo);
		
		Event eventProduct = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		purchase.setPurchaseProd(eventProduct.getProduct());
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updateWishPurchase.jsp";
	}
	
	@RequestMapping( value = "updateWishPurchase" , method = RequestMethod.POST)
	public String updateWishPurchase ( @RequestParam("tranNo") int tranNo , 
										@ModelAttribute("purchase") Purchase purchase , 
										Model model) throws Exception { 
		Purchase getPurchase = purchaseService.getWishPurchase(tranNo);
		
		purchase.setBuyer(getPurchase.getBuyer());
		purchase.setPurchaseProd(getPurchase.getPurchaseProd());
		
		purchaseService.updateWishPurchase(purchase);
		
		purchase = purchaseService.getWishPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/readWishPurchase.jsp";
	}
	
	@RequestMapping( value = "deleteWishPurchase" , method = RequestMethod.GET )
	public String deleteWishPurchase ( @RequestParam("tranNo") int tranNo , 
										Model model ) throws Exception {
		
		purchaseService.deleteWishPurchase(tranNo);
		
		return "forward:/purchase/listWishPurchase";
	}
}
