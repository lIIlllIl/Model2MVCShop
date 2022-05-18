package com.model2.mvc.web.product;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
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
import com.model2.mvc.common.Page;
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
	public Product updateProduct ( @RequestBody Map<String, Object> map ) throws Exception {
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String mapString = objectMapper.writeValueAsString(map);
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);
		
		Product product = objectMapper.readValue(jsonObject.get("json").toString(), Product.class);
		
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
		Map map = productService.getProductList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("total")).intValue(), pageUnit, pageSize);
		map.put("resultPage", resultPage);
		return map;
	}
	
	@RequestMapping( value = "json/listProduct" , method = RequestMethod.POST)
	public Map<String, Object> listProduct( @RequestBody Search search ) throws Exception {
		System.out.println("search.getCurrentPage : " + search.getCurrentPage());
		search.setPageSize(pageSize);
		System.out.println("---------------------------------------------"+search);
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
	
	@RequestMapping( value = "json/enterProduct" )
	public List enterUserLogin ( @RequestBody Map<String, String> jsonMap ) throws Exception {
		
		System.out.println("-----------------------------------------------------------"+jsonMap);
		List<String> checkData = productService.getEnterProduct(jsonMap.get("dataName"), jsonMap.get("dataType"));
		List<String> autoCommit = new ArrayList();
		
		for ( int i = 0; i < checkData.size(); i++ ) {
			if( ! autoCommit.contains(checkData.get(i)) ) {
				autoCommit.add(checkData.get(i));
			}
		}
		
		return autoCommit;
	}
	
	@RequestMapping( value = "json/naverSearch" )
	public List naverSearch (  ) throws Exception {
		
		String clientId = "rXAFxeCHrAqZhgl5N4ZV";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "hAqwq8865N";//애플리케이션 클라이언트 시크릿값";
        try {
            String text = URLEncoder.encode("그린팩토리", "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/search/blog?query="+ text; // json 결과
            //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
        } catch (Exception e) {
            System.out.println(e);
        }
    
		
		return null;
	}
}
