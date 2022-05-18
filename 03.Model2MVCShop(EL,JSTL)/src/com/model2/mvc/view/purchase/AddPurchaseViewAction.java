package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.dao.ProductDao;

public class AddPurchaseViewAction extends Action {

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		
		int prodNo = Integer.parseInt(request.getParameter("prod_no"));
		
		ProductDao productDao = new ProductDao();
		Product product = productDao.findProduct(prodNo);
		
		request.setAttribute("product", product);
		request.setAttribute("user", user);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}

}
