package com.model2.mvc.view.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;

public class SelectUserState extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>userState : " + request.getParameter("userState"));
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>userState : " + request.getParameter("userId"));
		String userState = request.getParameter("userState");
		String userId = request.getParameter("userId");
		
		UserService userService=new UserServiceImpl();
		
		if ( userState.equals("0") ) {
			userService.updateUserState(userState, userId);
		}
		else if ( userState.equals("2") ) {
			userService.deleteUser(userId);
		}
		
		User user1 = userService.getUser(userId);
		System.out.println("user1 : " + user1);
		
		return "forward:/listUser.do?currentPage=1";
	}

}
