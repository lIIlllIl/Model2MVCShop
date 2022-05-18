package com.model2.mvc.view.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

@Controller
public class UserController {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	public UserController() {
		System.out.println("UserController() Wiring..." + this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping("/login.do")
	public String login(@ModelAttribute("user") User user, HttpSession session) throws Exception {
		System.out.println("/login.do");
		
		User dbUser = userService.getUser(user.getUserId());
		
		if (dbUser.getPassword().equals(user.getPassword())) {
			session.setAttribute("user", dbUser);
		}
		
		return "redirect:/index.jsp";
		
	}
}
