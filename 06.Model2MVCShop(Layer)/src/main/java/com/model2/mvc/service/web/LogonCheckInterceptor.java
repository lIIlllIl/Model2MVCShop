
package com.model2.mvc.service.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.model2.mvc.service.domain.User;



public class LogonCheckInterceptor extends HandlerInterceptorAdapter{

	public LogonCheckInterceptor() {
		System.out.println("==> LogonCheckInterceptor() default Contructor call...");
	}
	
	public boolean preHandle( HttpServletRequest request, 
								HttpServletResponse response, 
								Object handler) throws Exception {
		System.out.println("\n[ LogonCheckInterceptor start...]");
		
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		
		if ( user != null ) {
			
			String uri = request.getRequestURI();
			if ( uri.indexOf("addUser") != -1 || uri.indexOf("checkDuplication") != -1 ||
					uri.indexOf("loginView") != -1	) {
				
			}
		}
		
		return false;
	}

}
