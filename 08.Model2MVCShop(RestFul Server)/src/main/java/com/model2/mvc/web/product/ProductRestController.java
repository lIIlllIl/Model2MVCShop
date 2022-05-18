package com.model2.mvc.web.product;

import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value = "json/addProduct", method = RequestMethod.POST)
	public Product addProduct( @RequestBody Product product ) throws Exception {
		
		productService.addProduct(product);
	
		return product;
	}
	
	@RequestMapping( value = "json/getProduct/{prodNo}")
	public Event getProduct( @PathVariable int prodNo ) throws Exception {
		System.out.println(prodNo);
		
		Integer pNo = prodNo;
		
		Event event = productService.getProduct(pNo);
		
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
		
		System.out.println(event);
		
		return event;
	}
	
	@RequestMapping( value = "json/updateProduct" , method = RequestMethod.POST )
	public Product updateProduct ( @RequestBody Product product ) throws Exception {
		
		Event eventProduct = productService.getProduct(product.getProdNo());
		
		Product updateProduct = eventProduct.getProduct();
		updateProduct.setProdName(product.getProdName());
		updateProduct.setPrice(product.getPrice());
		
		productService.updateProduct(updateProduct);
		
		Event returnEvent = productService.getProduct(product.getProdNo());
		
		return returnEvent.getProduct();
	}
	
	@RequestMapping( value = "json/listProduct/{currentPage}", method = RequestMethod.GET)
	public Map<String, Object> listProduct( @PathVariable int currentPage ) throws Exception {
		
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		
		return productService.getProductList(search);
	}
	
	@RequestMapping( value = "json/listProduct" , method = RequestMethod.POST)
	public Map<String, Object> listProduct( @RequestBody Search search ) throws Exception {
		System.out.println("search.getCurrentPage : " + search.getCurrentPage());
		search.setPageSize(pageSize);
		
		return productService.getProductList(search);
	}
	
	@RequestMapping( value = "json/discountProduct" , method = RequestMethod.POST )
	public Event discountProduct( @RequestBody Event event	 ) throws Exception {
		
		System.out.println(event);
		Map<String, Object> map = new HashMap<String, Object>();

		if ( event.getProduct().getCheckEvent().trim().equals("0") && event.getDcPersent() != 0) {
			
			map.put("prodNo", event.getProduct().getProdNo());
			map.put("startDate", event.getStartDate());
			map.put("endDate", event.getEndDate());
			map.put("discount", event.getDcPersent());

			productService.discountProduct(map);
			
			Event checkEvent = productService.getProduct(event.getProduct().getProdNo());
			
			if ( checkEvent.getStartDate() != null ) {
				Calendar today = Calendar.getInstance();
				Date now = new Date(today.getTimeInMillis());
				
				int result = now.compareTo(checkEvent.getStartDate());
				
				if ( result >= 0 ) {
					checkEvent.getProduct().setPrice( (int) ( checkEvent.getDcPersent() * checkEvent.getProduct().getCostPrice() ) );
				}
				else {
					checkEvent.getProduct().setPrice( checkEvent.getProduct().getCostPrice() );
				}
			}
			else  {
				checkEvent.getProduct().setPrice(checkEvent.getProduct().getCostPrice());
			}

		}
		else if ( event.getProduct().getCheckEvent().trim().equals("1") ) {
			productService.updateDiscountProduct(event.getProduct().getProdNo());
			
		}
		
		Event returnEvent = productService.getProduct(event.getProduct().getProdNo());
		
		return returnEvent;
	}
	
	@RequestMapping( value = "json/listDiscount", method=RequestMethod.POST)
	public Map<String, Object> getDiscountList( @RequestBody Search search ) throws Exception {
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getDiscountList(search);
		
		List<Event> checkListEvent = (List<Event>)productService.getDiscountList(search).get("list");
		
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
		
		return map;
	}
	
	@RequestMapping( value = "json/listDiscount/{currentPage}", method=RequestMethod.GET)
	public Map<String, Object> getDiscountList( @PathVariable int currentPage ) throws Exception {
		
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getDiscountList(search);
		
		List<Event> checkListEvent = (List<Event>)productService.getDiscountList(search).get("list");
		
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
		
		return map;
	}
}
