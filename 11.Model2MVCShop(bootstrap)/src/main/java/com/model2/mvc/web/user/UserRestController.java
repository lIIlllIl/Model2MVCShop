package com.model2.mvc.web.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


@RestController
@RequestMapping("/user/*")
public class UserRestController {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		

		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");

		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		else {
			session.removeAttribute("user");
			dbUser = null;
		}
		
		return dbUser;
	}
	
	@RequestMapping( value="json/listUser/{currentPage}" , method = RequestMethod.GET)
	public Map listUser( @PathVariable int currentPage ) throws Exception{
		
		System.out.println("/user/listUser : GET");
	
		Search search = new Search();
		
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		System.out.println("--------------------------------------------------------------------------"+search.getCurrentPage());
		
		Map map = userService.getUserList(search);
		System.out.println("abc--------------------------------------------------------------------------"+((Integer)map.get("totalCount")).intValue());
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		map.put("resultPage", resultPage);
		
		return map;
	}
	
	@RequestMapping( value = "json/listUser" , method=RequestMethod.POST )
//	public List<User> listUser ( @RequestBody Search search ) throws Exception {
	public Map listUser ( @RequestBody Search search ) throws Exception {	

		/*
		 * LinkedHashMap Casting 오류 발생 
		search.setPageSize(pageSize);
		
		Map<String , Object> map = new LinkedHashMap<String, Object>();
		map = userService.getUserList(search);

		return map;
		*/
		search.setPageSize(pageSize);
		
		if ( search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}

		
		
		return userService.getUserList(search);
		
//		search.setPageSize(pageSize);
//		
//		Map<String , Object> map = userService.getUserList(search);
//		
//		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
//		System.out.println(resultPage);
//		
//		
//		
//		return (List<User>)map.get("list");
	}
	
	@RequestMapping(value = "json/checkDuplication", method = RequestMethod.POST)
	public Map<String, Object> checkDuplication( @RequestBody User user ) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", userService.checkDuplication(user.getUserId()));
		
		return map;
	}
	
	@RequestMapping( value = "json/updateUser" , method = RequestMethod.POST)
	public User updateUser ( @RequestBody User user ) throws Exception {
		
		System.out.println(user.getUserId());
		userService.updateUser(user);
		User returnUser = userService.getUser(user.getUserId());
		System.out.println("returnUser ? : " + returnUser);
		
		return returnUser;
	}
	
//	@RequestMapping( value = "json/addUser", method = RequestMethod.POST)
//	public User addUser ( @RequestBody User user) throws Exception {
//		
//		userService.addUser(user);
//		User returnUser = userService.getUser(user.getUserId());
//		
//		return returnUser;
//		
//	}
	
	@RequestMapping( value = "json/addUser", method = RequestMethod.POST)
	public User addUser ( @RequestBody Map<String, Object> map ) throws Exception {
		System.out.println("--------------------------"+map);
		ObjectMapper objectMapper = new ObjectMapper();
		
		String mapString = objectMapper.writeValueAsString(map);
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);
		
		User user = objectMapper.readValue(jsonObject.get("json").toString(), User.class);
		
		userService.addUser(user);
		User returnUser = userService.getUser(user.getUserId());
		
		return returnUser;
		
	}
	
	@RequestMapping( value = "json/enterUser" )
	public List enterUserLogin ( @RequestBody Map<String, String> jsonMap ) throws Exception {
		
		List<String> checkData = userService.getUserIdList(jsonMap.get("dataName"), jsonMap.get("dataType"));
		List<String> autoCommit = new ArrayList();
		
		for ( int i = 0; i < checkData.size(); i++ ) {
			if( ! autoCommit.contains(checkData.get(i)) ) {
				autoCommit.add(checkData.get(i));
			}
		}
		
		return autoCommit;
	}
	
	@RequestMapping( value = "json/naverLogin" )
	public String naverLogin ( @RequestBody Map<String, String> jsonMap , HttpSession session ) throws Exception {
		System.out.println("--------------------------------"+jsonMap);
//		int index = jsonMap.get("userId").indexOf("@");
//		String userId = jsonMap.get("userId").substring(0, index);
//		ObjectMapper objectMapper = new ObjectMapper();
//		
//		String mapString = objectMapper.writeValueAsString(jsonMap);
//		
//		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);
//		
//		String userId = objectMapper.readValue(jsonObject.get("email").toString(), String.class);
//		String name = objectMapper.readValue(jsonObject.get("name").toString(), String.class);
		
		String userId = jsonMap.get("email");
		String name = jsonMap.get("name");
		System.out.println("---------------------------------------naverLogin run???");
		
		System.out.println("----------------------------------------userId ???"+userId);
		User checkUser = userService.getUser(userId);
		System.out.println("----------------------------------------checkUser ???"+checkUser);
		if ( checkUser != null ) {
			session.setAttribute("user", checkUser);
		}
		else { 
			User addUser = new User();
			addUser.setUserId(userId);
			addUser.setPassword(userId);
			addUser.setUserName(name);
			
			userService.addUser(addUser);
			
			session.setAttribute("user", checkUser);
		}
		
		return "/index.jsp";
	}
	
	@RequestMapping( value = "json/kakaoLogin" )
	public void loginKakao( @RequestBody Map<String, Object> jsonMap , HttpSession session ) throws Exception {
		System.out.println("-------------------------------- kakao jsonMap ??? "+ jsonMap);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String mapString = objectMapper.writeValueAsString(jsonMap);
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);
		
		Map map = objectMapper.readValue(jsonObject.get("json").toString(), Map.class);
		System.out.println("------------------------------------------------------"+map);
		int mapId = (int)map.get("id");
		String id = Integer.toString(mapId);	
		String nickname = (String)map.get("nickname");
		System.out.println("------------------------------------------------------"+id + " / " + nickname);
		
		User checkUser = userService.getUser(id);
		
		if ( checkUser != null ) {
			session.setAttribute("user", checkUser);
		}
		else { 
			User addUser = new User();
			addUser.setUserId(id);
			addUser.setPassword(id);
			addUser.setUserName(nickname);
			
			userService.addUser(addUser);
			checkUser = userService.getUser(id);
			session.setAttribute("user", checkUser);
		}

		
	}
	
} 