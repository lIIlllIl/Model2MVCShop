package com.model2.mvc.view.product;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;

public class DiscountProductAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ProductService service=new ProductServiceImpl();
		
		Product product = service.getProduct(Integer.parseInt(request.getParameter("prodNo")));
		System.out.println(product);
		if ( product.getCheckDC().trim().equals("0") ) {
			Vector vector = new Vector();
			
			double discount = 1.0 - Integer.parseInt(request.getParameter("discountPersent")) * 0.01 ;
			
			vector.add(discount);
			vector.add(request.getParameter("startDate"));
			vector.add(request.getParameter("endDate"));
			vector.add(request.getParameter("prodNo"));
			
			service.discountProduct(vector);

		}
		else if ( product.getCheckDC().trim().equals("1") ) {
			service.updateDiscountProduct(Integer.parseInt(request.getParameter("prodNo")));
		}
		
		return "forward:/listProduct.do?menu=manage";
	}

}
