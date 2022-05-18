package com.model2.mvc.view.user;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;

public class UpdateUserStateAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		
		UserService userService=new UserServiceImpl();
	
		userService.updateUserState("1", userId);
		
		session.removeAttribute("user");
//		session.invalidate();

		return "redirect:/index.jsp#reload";
	}

}
