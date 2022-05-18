package com.model2.mvc.web.product;

import java.io.File;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="addProduct" , method = RequestMethod.GET)
	public String addProduct() throws Exception {
		System.out.println("/product/addProduct ==> GET");

		return "forward:/product/addProductView.jsp";
	}
	
	
	@RequestMapping( value="addProduct" , method = RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product , 
							  @RequestParam( value = "file" ) List<MultipartFile> file , 
								Model model ) throws Exception {
		System.out.println("/product/addProduct ==> POST");
		
//		String temDir = "C:\\workspace\\z.10.Model2MVCShop(Ajax)\\WebContent\\images\\uploadFiles\\";
		String temDir = "C:\\workspace\\z.11.Model2MVCShop(bootstrap)\\WebContent\\images\\uploadFiles\\";
			
		String fileName = "";
		System.out.println("file : " + file);
		System.out.println(file.get(0).getSize());
		if( file.get(0).getSize() != 0 ) {
			for ( int i = 0; i < file.size(); i++ ) {
				
				File saveFile = new File(temDir + file.get(i).getOriginalFilename());
				file.get(i).transferTo(saveFile);
				
				fileName += file.get(i).getOriginalFilename();
				
				if ( ( file.size() - 1 ) != i ) {
					fileName += "/";
				}
				
			}
		}
		
		product.setFileName(fileName);
		
		productService.addProduct(product);
		
		model.addAttribute("menu", "manage");
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping( value = "listProduct" )
	public String getProductList( @ModelAttribute("search") Search search , 
									@RequestParam(value="menu" , required=false) String menu, 
									Model model, HttpServletRequest request ) throws Exception {
		
		if ( search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
			System.out.println("search.getCurrentPage() run? : " + search.getCurrentPage());
		}
		
		search.setPageSize(pageSize);
		
		
		if ( search.getSearchCondition() != null && ! (search.getSearchCondition().trim().equals("0")) ) {		
			
			
			System.out.println(search.getSearchCondition().trim().equals("4"));
			System.out.println("search.getCondition() run? : " + search.getSearchCondition());
			
			search.setSearchCondition(search.getSearchCondition());
			
			if ( search.getFirstPrice() != 0 ) {
				search.setFirstPrice(search.getFirstPrice());
				search.setSecondPrice(search.getSecondPrice());
			}
			else {
				search.setSearchKeyword(search.getSearchKeyword());
			}
			search.setSearchTranCode(search.getSearchTranCode());		
		}
				
		Map<String, Object> map = productService.getProductList(search);
		
		List<Event> checkListEvent = (List<Event>)map.get("list");
		
		for ( int i = 0; i < checkListEvent.size(); i++) {
			if ( checkListEvent.get(i).getStartDate() != null ) {
				Calendar today = Calendar.getInstance();
				Date now = new Date(today.getTimeInMillis());
				
				int result = now.compareTo(checkListEvent.get(i).getStartDate());
				
				if ( result >= 0 ) {
					checkListEvent.get(i).getProduct().setPrice( (int) ( checkListEvent.get(i).getDcPersent() * checkListEvent.get(i).getProduct().getCostPrice() ) );
				}
				else {
					checkListEvent.get(i).getProduct().setPrice( checkListEvent.get(i).getProduct().getCostPrice() );
				}
				
			}
			else  {
				checkListEvent.get(i).getProduct().setPrice(checkListEvent.get(i).getProduct().getCostPrice());
			}
		}
		
		map.put("list", checkListEvent);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("total")).intValue(), pageUnit, pageSize);
		System.out.println("resultpage? : " + resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		String path = "";
		
		if ( menu.equals("manage")) {
			path = "forward:/product/listProductManage.jsp";
		}
		else {
			path = "forward:/product/listProduct.jsp";
		}
		return path;
	}
	
	@RequestMapping( value = "getProduct" )
	public String getProduct( @RequestParam("prodNo") int prodNo , 
								@RequestParam(value = "menu" , defaultValue="0") String menu , 
								HttpServletRequest request,
								HttpServletResponse response , Model model) throws Exception {
		
		Cookie[] cookies = request.getCookies();
		
		for(int i = 0; i < cookies.length; i++) {
			
				if (cookies[i] == null ) { 
					System.out.println("cookie null : " + request.getParameter("prodNo"));
					cookies[i] = new Cookie("history", request.getParameter("prodNo"));
					cookies[i].setMaxAge(-1);
					response.addCookie(cookies[i]);
				}
				else if (cookies[i] != null && cookies[i].getName().equals("history") ){
					System.out.println("cookie before value : " + cookies[i].getValue());
					
					String[] c = cookies[i].getValue().split(",");
					
					boolean checkCookies = true;
					
					for (int j = 0; j < c.length; j++) {
						if ( c[j].equals(request.getParameter("prodNo")) ) {
							checkCookies = false;
							cookies[i] = new Cookie("history", cookies[i].getValue());
							break;
						}
					}
					
					if ( checkCookies ) {
						cookies[i] = new Cookie("history", cookies[i].getValue()+","+request.getParameter("prodNo"));
						cookies[i].setMaxAge(-1);
						response.addCookie(cookies[i]);
						System.out.println("cookie after value : " + cookies[i].getValue());
						break;
					}
					else {
						System.out.println("else : " + request.getParameter("prodNo"));
						cookies[i] = new Cookie("history", cookies[i].getValue());
						cookies[i].setMaxAge(-1);
						response.addCookie(cookies[i]);
					}	
				}
				else {
					System.out.println("else : " + request.getParameter("prodNo"));
					cookies[i] = new Cookie("history", request.getParameter("prodNo"));
					cookies[i].setMaxAge(-1);
					response.addCookie(cookies[i]);
				}
	
		}
		
		
		Event event = productService.getProduct(prodNo);
		
		if ( event.getStartDate() != null ) {
			Calendar today = Calendar.getInstance();
			Date now = new Date(today.getTimeInMillis());
			
			int result = now.compareTo(event.getStartDate());
			
			if ( result >= 0 ) {
				event.getProduct().setPrice( (int) ( event.getDcPersent() * event.getProduct().getCostPrice() ) );
			}
			else {
				event.getProduct().setPrice( event.getProduct().getCostPrice() );
			}
			
		}
		else  {
			event.getProduct().setPrice(event.getProduct().getCostPrice());
		}
		
		model.addAttribute("event", event);
		
		
		if ( menu.equals("0") ) {
			menu = (String)request.getAttribute("menu");
		}
		
		model.addAttribute("menu", menu);
		
		String path = "";
		
		if (menu.equals("search") || menu.equals("ok") || menu.equals("cookie") || menu.equals("purchase") || menu.equals("dcCheck")) {
			path = "forward:/product/readProduct.jsp";
		}
		else if (menu.equals("discount") && event.getProduct().getCheckEvent().trim().equals("0")) {
			path = "forward:/product/discountProduct.jsp";
		}
		else if (menu.equals("discount") && event.getProduct().getCheckEvent().trim().equals("1")) {
			path = "forward:/product/discountProduct?menu=manage";
		}
		else {
			path = "forward:/product/updateProduct.jsp";
		}
		
		return path;
	}
	
	@RequestMapping( value = "updateProduct" , method = RequestMethod.GET )
	public String updateProduct( @RequestParam("prodNo") int prodNo , 
									Model model) throws Exception {

		Event event = productService.getProduct(prodNo);
		
		if ( event.getStartDate() != null ) {
			Calendar today = Calendar.getInstance();
			Date now = new Date(today.getTimeInMillis());
			
			int result = now.compareTo(event.getStartDate());
			
			if ( result >= 0 ) {
				event.getProduct().setPrice( (int) ( event.getDcPersent() * event.getProduct().getCostPrice() ) );
			}
			else {
				event.getProduct().setPrice( event.getProduct().getCostPrice() );
			}
			
		}
		else  {
			event.getProduct().setPrice(event.getProduct().getCostPrice());
		}
		
		model.addAttribute("event", event);
		
		return "forward:/product/updateProduct.jsp";
	}

	@RequestMapping( value = "updateProduct" , method = RequestMethod.POST )
	public String updateProduct( @ModelAttribute("product") Product product , 
									HttpServletRequest request , 
									Model model) throws Exception {
		
		productService.updateProduct(product);
		
		model.addAttribute("menu", "ok");
		
		return "forward:/product/getProduct?prodNo=" + product.getProdNo();
	}
	
	@RequestMapping( value = "discountProduct" )
	public String discountProduct(	@RequestParam(value="discountPersent", defaultValue="0") int discountPersent ,
									@RequestParam(value="startDate", required=false) String startDate ,
									@RequestParam(value="endDate", required=false) String endDate ,
									@RequestParam("prodNo") int prodNo ,
									Model model) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Event event = productService.getProduct(prodNo);
		
		String path = "";

		if ( event.getProduct().getCheckEvent().trim().equals("0") && discountPersent != 0) {

			double discount = 1.0 - (discountPersent * 0.01) ;
			
			map.put("prodNo", prodNo);
			map.put("startDate", startDate.replace("-", ""));
			map.put("endDate", endDate.replace("-", ""));
			map.put("discount", discount);
			System.out.println("map : " + map);
			productService.discountProduct(map);
			
	//		path = "forward:/product/listProduct?menu=manage";
			
		}
		else if ( event.getProduct().getCheckEvent().trim().equals("1") ) {
			productService.updateDiscountProduct(prodNo);
			
//			path = "forward:/listProduct.do?menu=manage";
		}
		
		return "forward:/product/listProduct?menu=manage";
	}
	
	@RequestMapping( value = "listDiscount" )
	public String getDiscountList( @ModelAttribute("search") Search search , Model model, HttpServletRequest request ) throws Exception {

		if ( search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}
		
		System.out.println("listDiscount currentPage? : " + search.getCurrentPage());
		
		search.setPageSize(pageSize);

		Map<String, Object> map = productService.getDiscountList(search);
		
		List<Event> checkListEvent = (List<Event>)map.get("list");
		
		for ( int i = 0; i < checkListEvent.size(); i++) {
			if ( checkListEvent.get(i).getStartDate() != null ) {
				Calendar today = Calendar.getInstance();
				Date now = new Date(today.getTimeInMillis());
				
				int result = now.compareTo(checkListEvent.get(i).getStartDate());
				
				if ( result >= 0 ) {
					checkListEvent.get(i).getProduct().setPrice( (int) ( checkListEvent.get(i).getDcPersent() * checkListEvent.get(i).getProduct().getCostPrice() ) );
				}
				else {
					checkListEvent.get(i).getProduct().setPrice( checkListEvent.get(i).getProduct().getCostPrice() );
				}
				
			}
			else  {
				checkListEvent.get(i).getProduct().setPrice(checkListEvent.get(i).getProduct().getCostPrice());
			}
		}
		
		map.put("list", checkListEvent);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("total")).intValue(), pageUnit, pageSize);
		System.out.println("resultpage? : " + resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listDiscount.jsp";
	}
	
	@RequestMapping ( value = "history" ) 
	public String history ( HttpServletRequest request, Model model ) throws Exception {

		String history = null;
		
		Page resultPage = null;
		
		List<Event> list = new ArrayList<Event>();
		
		Cookie[] cookies = request.getCookies();
		
		if (cookies!=null && cookies.length > 0) {
			
			for (int i = 0; i < cookies.length; i++) {
				
				Cookie cookie = cookies[i];
				
				if (cookie.getName().equals("history")) {
					history = cookie.getValue();
				}
			}
			if (history != null) {
				String[] h = history.split(",");
				
				for ( int i = 0; i < h.length; i++ ) {
					int prodNo = Integer.parseInt(h[i]);
					Event event = new Event();
					event = productService.getProduct(prodNo);
					
					if ( event.getStartDate() != null ) {
						Calendar today = Calendar.getInstance();
						Date now = new Date(today.getTimeInMillis());
						
						int result = now.compareTo(event.getStartDate());
						
						if ( result >= 0 ) {
							event.getProduct().setPrice( (int) ( event.getDcPersent() * event.getProduct().getCostPrice() ) );
						}
						else {
							event.getProduct().setPrice( event.getProduct().getCostPrice() );
						}
						
					}
					else  {
						event.getProduct().setPrice(event.getProduct().getCostPrice());
					}
					
					list.add(event);
				}
				
			}
		
		}
		
		model.addAttribute("list", list);
		model.addAttribute("totalCount", list.size());
		return "forward:/history.jsp";
	}
	
	@RequestMapping( value = "autoscroll" )
	public String getProductList( @ModelAttribute("search") Search search , 
									Model model, HttpServletRequest request ) throws Exception {
		
		if ( search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
			System.out.println("search.getCurrentPage() run? : " + search.getCurrentPage());
		}
		
		search.setPageSize(pageSize);
		
		
		if ( search.getSearchCondition() != null && ! (search.getSearchCondition().trim().equals("0")) ) {		
			
			
			System.out.println(search.getSearchCondition().trim().equals("4"));
			System.out.println("search.getCondition() run? : " + search.getSearchCondition());
			
			search.setSearchCondition(search.getSearchCondition());
			
			if ( search.getFirstPrice() != 0 ) {
				search.setFirstPrice(search.getFirstPrice());
				search.setSecondPrice(search.getSecondPrice());
			}
			else {
				search.setSearchKeyword(search.getSearchKeyword());
			}
			search.setSearchTranCode(search.getSearchTranCode());		
		}
				
		Map<String, Object> map = productService.getProductList(search);
		
		List<Event> checkListEvent = (List<Event>)map.get("list");
		
		for ( int i = 0; i < checkListEvent.size(); i++) {
			if ( checkListEvent.get(i).getStartDate() != null ) {
				Calendar today = Calendar.getInstance();
				Date now = new Date(today.getTimeInMillis());
				
				int result = now.compareTo(checkListEvent.get(i).getStartDate());
				
				if ( result >= 0 ) {
					checkListEvent.get(i).getProduct().setPrice( (int) ( checkListEvent.get(i).getDcPersent() * checkListEvent.get(i).getProduct().getCostPrice() ) );
				}
				else {
					checkListEvent.get(i).getProduct().setPrice( checkListEvent.get(i).getProduct().getCostPrice() );
				}
				
			}
			else  {
				checkListEvent.get(i).getProduct().setPrice(checkListEvent.get(i).getProduct().getCostPrice());
			}
		}
		
		map.put("list", checkListEvent);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("total")).intValue(), pageUnit, pageSize);
		System.out.println("resultpage? : " + resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/autoscroll.jsp";
	}
	
}