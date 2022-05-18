package com.model2.mvc.view.product;

import java.net.URLEncoder;
import java.util.Vector;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.product.vo.ProductVO;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;
import com.model2.mvc.service.user.vo.UserVO;


public class GetProductAction extends Action{

	@Override
	public String execute(	HttpServletRequest request,
												HttpServletResponse response) throws Exception {
		
		int prodNo=Integer.parseInt(request.getParameter("prodNo"));
		System.out.println("prodNo : " + prodNo);
		
		ProductService service=new ProductServiceImpl();
		ProductVO vo=service.getProduct(prodNo); // int로 받음 => prodNo로 받음 
		System.out.println("vo : " + vo);
		
		HttpSession session = request.getSession(true);
		session.setAttribute("pvo", vo);
		
		Cookie[] cookies = request.getCookies();
		
		for(int i = 0; i < cookies.length; i++) {
			if (cookies[i] == null ) { 
				System.out.println("cookie null : " + request.getParameter("prodNo"));
				cookies[i] = new Cookie("history", request.getParameter("prodNo"));
				cookies[i].setMaxAge(-1);
				response.addCookie(cookies[i]);
			}
			else if (cookies[i] != null && cookies[i].getName().equals("history") ){
				System.out.println("cookie value : " + cookies[i].getValue());
				
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
		
		String menu = request.getParameter("menu");
		System.out.println("menu : " + menu);
		if (menu.equals("search") || menu.equals("ok")) {

			return "forward:/product/readProduct.jsp";
		}
		else  {
			return "forward:/product/updateProduct.jsp";
		}
	}
}