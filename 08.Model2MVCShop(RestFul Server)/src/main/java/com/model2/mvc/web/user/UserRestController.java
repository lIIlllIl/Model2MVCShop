package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
		
		return dbUser;
	}
	
	@RequestMapping( value="json/listUser/{currnetPage}" , method = RequestMethod.GET)
	public Map listUser( @PathVariable int currnetPage ) throws Exception{
		
		System.out.println("/user/listUser : GET");
	
		Search search = new Search();

		search.setCurrentPage(currnetPage);
		search.setPageSize(pageSize);
		
		return userService.getUserList(search);
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
	
	@RequestMapping( value = "json/addUser", method = RequestMethod.POST)
	public User addUser ( @RequestBody User user) throws Exception {
		
		userService.addUser(user);
		User returnUser = userService.getUser(user.getUserId());
		
		return returnUser;
		
	}
	
} 