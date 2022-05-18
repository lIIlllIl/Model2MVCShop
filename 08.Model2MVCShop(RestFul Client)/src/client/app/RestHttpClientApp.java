package client.app;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.model2.mvc.common.Event;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;



public class RestHttpClientApp {
	
	public static void main(String[] args) throws Exception{

//		GetUser();
		
//		Login();
		
//		ListUser_POST();
		
//		ListUser_GET();
		
//		CheckDuplication();
		
//		AddUser();
		
//		AddProduct();
		
//		GetProduct();
		
//		UpdateProduct();
		
//		listProduct_GET();
		
//		ListProduct_POST();
		
//		DiscountProduct();
		
//		ListDiscount_POST();
		
//		ListDiscount_GET();
		
		AddPurchase();
		
//		ListPurchase_POST();
		
//		ListPurchase_GET();
		
//		ListSale_POST();
		
//		listSale_GET();
		
//		UpdateTranCode();
		
//		GetPurchase();
		
//		UpdatePurchase();
		
//		AddWishPurchase();
		
//		ListWishPurchase_POST();
		
//		ListWishPurchase_GET();
		
//		GetWishPurchase();
		
//		UpdateWishPurchase();
		
//		BuyWishPurchase();
		
//		deleteWishPurchase();
	
	}
	
	public static void GetUser() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/getUser/user01";
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		HttpEntity httpEntity = httpResponse.getEntity();
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jsonString = objectMapper.writeValueAsString(jsonObject);
		User user = objectMapper.readValue(jsonString.toString(), User.class);
		
		System.out.println(user);
		
	}

	public static void Login() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/login";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		User user = new User();
		user.setUserId("user02");
		user.setPassword("2222");
		
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = objectMapper.writeValueAsString(user);
		
		HttpEntity entity = new StringEntity(jsonString, "UTF-8");
		
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			
		JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
		User returnUser = objectMapper.readValue(jsonObject.toString(), User.class);
		System.out.println(returnUser);
	}
	
	public static void ListUser_POST() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/listUser";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Search search = new Search();
		search.setCurrentPage(1);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = objectMapper.writeValueAsString(search);
		
		HttpEntity entity = new StringEntity(jsonString, "UTF-8");
		
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
		
		List<User> listUser = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference <List<User>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("totalCount").toString(), Integer.class);
		
		for( User user : listUser ) {
			System.out.println(user);
		}
		
		System.out.println(totalCount);
		
	}
	
	public static void ListUser_GET() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/listUser/1";
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		List<User> userList = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<User>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("totalCount").toString(), Integer.class);
		
		for ( User user : userList ) {
			System.out.println(user);
		}
		System.out.println();
		System.out.println(totalCount);
		
		
	}
	
	public static void CheckDuplication() throws Exception {
		
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/checkDuplication";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		User user = new User();
		user.setUserId("user01213");
			
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = objectMapper.writeValueAsString(user);
		
		HttpEntity entity = new StringEntity(jsonString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
		
		boolean result = objectMapper.readValue(jsonObject.get("result").toString(), boolean.class);
		System.out.println(result);
		
	}
	
	public static void AddUser() throws Exception {
		HttpClient httpClinet = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/addUser";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		User user = new User();
		user.setUserId("111111111111231");
		user.setUserName("99999");
		user.setPassword("1111");
		
		ObjectMapper objectMapper01 = new ObjectMapper();
		String userString = objectMapper01.writeValueAsString(user);
		
		HttpEntity httpEntity01 = new StringEntity(userString, "UTF-8");
		
		httpPost.setEntity(httpEntity01);
		
		HttpResponse httpResponse = httpClinet.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		HttpEntity httpEntity = httpResponse.getEntity();
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		System.out.println("[ Server에서 받은 Data ]");
		String serverData = br.readLine();
		System.out.println(serverData);
		
		ObjectMapper objectMapper = new ObjectMapper();
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		String returnUserString = objectMapper.writeValueAsString(jsonObject);
		User returnUser = objectMapper.readValue(returnUserString, User.class);
		System.out.println(returnUser);
		
	}
	
	public static void AddProduct() throws Exception {
		
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/product/json/addProduct";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Product product = new Product();
		product.setProdName("0000011110");
		
		ObjectMapper objectMapper01 = new ObjectMapper();
		String productString = objectMapper01.writeValueAsString(product);
		
		HttpEntity httpEntity01 = new StringEntity(productString, "UTF-8");
		httpPost.setEntity(httpEntity01);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		HttpEntity httpEntity = httpResponse.getEntity();
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		System.out.println("[ Server에서 받은 Data 확인 ]");
		String serverData = br.readLine();
		System.out.println(serverData);
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jsonString = objectMapper.writeValueAsString(jsonObject);
		
		Product returnProduct = objectMapper.readValue(jsonString, Product.class);
		System.out.println(returnProduct);
		
	}
	
	public static void GetProduct() throws Exception {
		
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/product/json/getProduct/10000";
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		String serverData = br.readLine();
		
		System.out.println(serverData);
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		System.out.println(jsonObject);
		
		ObjectMapper objectMapper = new ObjectMapper();

		
		Event event = objectMapper.readValue(jsonObject.toString(), Event.class);
		System.out.println(event);
		System.out.println("원가 : " + event.getProduct().getCostPrice());
		System.out.println("현재 판매가 : " + event.getProduct().getPrice());
	}
	
	public static void UpdateProduct() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/product/json/updateProduct";
		
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Product product = new Product();
		product.setProdNo(10000);
		product.setProdName("aaaAAAbbbBBBcccCCC");
		product.setPrice(1234567890);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String objectString = objectMapper.writeValueAsString(product);
		
		HttpEntity entity = new StringEntity(objectString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));

		JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
		
		Product returnProduct = objectMapper.readValue(jsonObject.toString(), Product.class);
		
		System.out.println(returnProduct);
		
	}
	
	public static void listProduct_GET() throws Exception {
		
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/product/json/listProduct/1";
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
		ObjectMapper objectMapper = new ObjectMapper();
		
		List<Event> listEvent = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Event>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("total").toString(), Integer.class);
		
		for(Event event : listEvent) {
			System.out.println(event);
		}
		
		System.out.println(totalCount);
	}
	
	public static void ListProduct_POST() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/product/json/listProduct";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Search search = new Search();
		search.setCurrentPage(2);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = objectMapper.writeValueAsString(search);
		
		HttpEntity entity = new StringEntity(jsonString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		List<Event> listEvent = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Event>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("total").toString(), Integer.class);
		
		for(Event event : listEvent) {
			System.out.println(event);
		}
		
		System.out.println(totalCount);
		
		
	}
	
	public static void DiscountProduct() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/product/json/discountProduct";
		HttpPost httpPost = new HttpPost(url);
		
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Date start = Date.valueOf("2019-11-22");
		Date end = Date.valueOf("2019-11-30");
		System.out.println(start);
		System.out.println(end);
		Event event = new Event();
		
		Product product = new Product();
		product.setProdNo(10000);
		product.setCostPrice(1000000);
		product.setCheckEvent("0");
		event.setProduct(product);
		event.setEventType("1");
		
		event.setStartDate(start);
		event.setEndDate(end);
		event.setDcPersent(0.85);
		System.out.println("start : " + event.getStartDate());
		
		ObjectMapper objectMapper = new ObjectMapper();
		String objectString = objectMapper.writeValueAsString(event);
		System.out.println(objectString);
		
		HttpEntity entity = new StringEntity(objectString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));

		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		Event returnEvent = objectMapper.readValue(jsonObject.toString(), Event.class);
		System.out.println(returnEvent);
	}
	
	public static void ListDiscount_POST() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/product/json/listDiscount";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Search search = new Search();
		search.setCurrentPage(1);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String objectString = objectMapper.writeValueAsString(search);
		
		HttpEntity entity = new StringEntity(objectString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		List<Event> returnEvent = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Event>>() {});
		
		Calendar today = Calendar.getInstance();
		Date now = new Date(today.getTimeInMillis());
		
		for ( int i = 0; i < returnEvent.size(); i++ ) {
			returnEvent.get(i).getProduct().setPrice( (int) ( returnEvent.get(i).getDcPersent() * returnEvent.get(i).getProduct().getCostPrice() ) );
			System.out.println(returnEvent.get(i));
			
			int result = now.compareTo(returnEvent.get(i).getStartDate());
			boolean checkEvent = returnEvent.get(i).getStartDate().after(now);
			
			if ( returnEvent.get(i).getEventType().equals("2") ) {
				System.out.println("할인취소");
			}
			
			if ( ! returnEvent.get(i).getEventType().equals("2") && checkEvent ) {
				System.out.println("할인중");
			}
			else if ( ! returnEvent.get(i).getEventType().equals("2") && ! ( checkEvent ) ) {
				System.out.println("할인종료");
			}
		
		}	
	}
	
	public static void ListDiscount_GET() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/product/json/listDiscount/1";
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");

		
		ObjectMapper objectMapper = new ObjectMapper();

		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		List<Event> returnEvent = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Event>>() {});
		
		Calendar today = Calendar.getInstance();
		Date now = new Date(today.getTimeInMillis());
		
		for ( int i = 0; i < returnEvent.size(); i++ ) {
			returnEvent.get(i).getProduct().setPrice( (int) ( returnEvent.get(i).getDcPersent() * returnEvent.get(i).getProduct().getCostPrice() ) );
			System.out.println(returnEvent.get(i));
			
			int result = now.compareTo(returnEvent.get(i).getStartDate());
			boolean checkEvent = returnEvent.get(i).getStartDate().after(now);
			
			if ( returnEvent.get(i).getEventType().equals("2") ) {
				System.out.println("할인취소");
			}
			
			if ( ! returnEvent.get(i).getEventType().equals("2") && checkEvent ) {
				System.out.println("할인중");
			}
			else if ( ! returnEvent.get(i).getEventType().equals("2") && ! ( checkEvent ) ) {
				System.out.println("할인종료");
			}
		
		}	
	}
	
	public static void AddPurchase() throws Exception {
		
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/purchase/json/addPurchase";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Purchase purchase = new Purchase();
		
		Product product = new Product();
		product.setProdNo(10000);
		User user = new User();
		user.setUserId("user01");
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setTranCount(1);
		purchase.setPaymentOption("1");
		
		ObjectMapper objectMapper = new ObjectMapper();
		String objectString = objectMapper.writeValueAsString(purchase);
		
		HttpEntity entity = new StringEntity(objectString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		System.out.println(serverData);
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		Purchase returnPurchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		
		System.out.println(returnPurchase);
		
	}
	
	
	public static void ListPurchase_POST() throws Exception {
		
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/purchase/json/listPurchase";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
			
		User user = new User();
		user.setUserId("user01");
		
		Search search = new Search();
		search.setCurrentPage(1);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("user", user);
		map.put("search", search);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String objectString = objectMapper.writeValueAsString(map);
		System.out.println(objectString);
		
		HttpEntity entity = new StringEntity(objectString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		List<Purchase> listPurchase = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Purchase>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("totalCount").toString(), Integer.class);
		
		for(Purchase purchase : listPurchase) {
			System.out.println(purchase);
		}
		System.out.println(totalCount);
	}
	
	public static void ListPurchase_GET() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/purchase/json/listPurchase/user01/1";
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		List<Purchase> listPurchase = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Purchase>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("totalCount").toString(), Integer.class);
		
		for(Purchase purchase : listPurchase) {
			System.out.println(purchase);
		}
		
		System.out.println(totalCount);
	}
	
	public static void ListSale_POST() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/purchase/json/listSale";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Search search = new Search();
		search.setCurrentPage(1);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = objectMapper.writeValueAsString(search);
		
		HttpEntity entity = new StringEntity(jsonString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		List<Purchase> listPurchase = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Purchase>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("totalCount").toString(), Integer.class);
		
		for ( Purchase purchase : listPurchase ) {
			System.out.println(purchase);
		}
		System.out.println(totalCount);
	}
	
	public static void listSale_GET() throws Exception {
		String url = "http://127.0.0.1:8080/purchase/json/listSale/1";
		
		HttpClient httpClient = new DefaultHttpClient();
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		ObjectMapper objectMapper = new ObjectMapper();

		List<Purchase> listPurchase = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Purchase>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("totalCount").toString(), Integer.class);
		
		for ( Purchase purchase : listPurchase ) {
			System.out.println(purchase);
		}
		System.out.println(totalCount);
	}
	
	public static void UpdateTranCode() throws Exception {
		String url = "http://127.0.0.1:8080/purchase/json/updateTranCode/10000/2";
		
		HttpClient httpClient = new DefaultHttpClient();
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		Purchase purchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		System.out.println(purchase);
	}
	
	public static void GetPurchase() throws Exception {
		String url = "http://127.0.0.1:8080/purchase/json/getPurchase/10000";
		
		HttpClient httpClient = new DefaultHttpClient();
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		Purchase purchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		System.out.println(purchase);
	}
	
	public static void UpdatePurchase() throws Exception {
		String url = "http://127.0.0.1:8080/purchase/json/updatePurchase";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(10000);
		purchase.setReceiverName("AAAaaaBBBbbbCCCccc");
		purchase.setDivyRequest("cccCCCbbbBBBaaaAAA");
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jsonString = objectMapper.writeValueAsString(purchase);
		HttpEntity entity = new StringEntity(jsonString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpClient httpClient = new DefaultHttpClient();
		
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		Purchase returnPurchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		
		System.out.println(returnPurchase);
	}
	
	public static void AddWishPurchase() throws Exception {
		String url = "http://127.0.0.1:8080/purchase/json/addWishPurchase";
		
		Purchase purchase = new Purchase();

		Product product = new Product();
		product.setProdNo(10000);
		product.setProdCount(7);
		User user = new User();
		user.setUserId("user01");
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setPaymentOption("1");
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jsonString = objectMapper.writeValueAsString(purchase);
		
		HttpEntity entity = new StringEntity(jsonString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpClient httpClient = new DefaultHttpClient();
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		Purchase returnPurchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		
		System.out.println(returnPurchase);
		
		
	}
	
	public static void ListWishPurchase_POST() throws Exception {
		String url = "http://127.0.0.1:8080/purchase/json/listWishPurchase";
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Search search = new Search();
		search.setCurrentPage(1);
		
		User user = new User();
		user.setUserId("user01");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user", user);
		map.put("search", search);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = objectMapper.writeValueAsString(map);
		
		HttpEntity entity = new StringEntity(jsonString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpClient httpClient = new DefaultHttpClient();
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		List<Purchase> listPurchase = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Purchase>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("totalCount").toString(), Integer.class);
		
		for( Purchase purchase : listPurchase ) {
			System.out.println(purchase);
		}
		
		System.out.println(totalCount);
	}
	
	public static void ListWishPurchase_GET() throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/purchase/json/listWishPurchase/user01/1";
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		List<Purchase> listPurchase = objectMapper.readValue(jsonObject.get("list").toString(), new TypeReference<List<Purchase>>() {});
		int totalCount = objectMapper.readValue(jsonObject.get("totalCount").toString(), Integer.class);
		
		for(Purchase purchase : listPurchase) {
			System.out.println(purchase);
		}
		
		System.out.println(totalCount);
	}
	
	public static void GetWishPurchase() throws Exception {
		String url = "http://127.0.0.1:8080/purchase/json/getWishPurchase/10003";
		
		HttpClient httpClient = new DefaultHttpClient();
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		Purchase purchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		
		System.out.println(purchase);
	}
	
	public static void UpdateWishPurchase() throws Exception {
		String url = "http://127.0.0.1:8080/purchase/json/updateWishPurchase";
		
		HttpClient httpClient = new DefaultHttpClient();
		
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(10003);
		purchase.setTranCount(2);
		purchase.setDivyRequest("AAAaaaBBBbbbCCCccc");
		purchase.setDivyAddr("ABC");
		
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = objectMapper.writeValueAsString(purchase);
		
		HttpEntity entity = new StringEntity(jsonString, "UTF-8");
		httpPost.setEntity(entity);
		
		HttpResponse httpResponse = httpClient.execute(httpPost);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		Purchase returnPurchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		
		System.out.println(returnPurchase);
	}
	
	public static void BuyWishPurchase() throws Exception {
		String url = "http://127.0.0.1:8080/purchase/json/checkWishPurchase/10003";
		
		HttpClient httpClient = new DefaultHttpClient();
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
		
		InputStream is = httpResponse.getEntity().getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		String serverData = br.readLine();
		
		ObjectMapper objectMapper = new ObjectMapper();
		JSONObject jsonObject = (JSONObject)JSONValue.parse(serverData);
		
		Purchase purchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		
		System.out.println(purchase);
	}
	
	public static void deleteWishPurchase() throws Exception {
		
		String url = "http://127.0.0.1:8080/purchase/json/deleteWishPurchase/10001";
		
		HttpClient httpClient = new DefaultHttpClient();
		
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse= httpClient.execute(httpGet);
		System.out.println(httpResponse);
		System.out.println();
	}
}