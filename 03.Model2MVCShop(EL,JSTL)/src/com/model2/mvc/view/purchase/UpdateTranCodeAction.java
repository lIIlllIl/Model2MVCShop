package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

public class UpdateTranCodeAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int tranNo = Integer.parseInt(request.getParameter("tranNo"));
		String tranCode = request.getParameter("tranCode");
		
		PurchaseService service = new PurchaseServiceImpl();
		Purchase purchase = null;
		
		String path = "";
		
		if ( tranCode.equals("3")) {
			purchase = service.getPurchase(tranNo);
			purchase.setTranCode(tranCode);
			service.updateTranCode(purchase);
			request.setAttribute("purchase", purchase);
			path = "forward:/listPurchase.do";
		}
		else if ( tranCode.equals("4") ) {
			service.deletePurchase(tranNo);
			path = "forward:/listPurchase.do";
		}
		else if ( tranCode.equals("2") ) {
			purchase = service.getPurchase(tranNo);
			purchase.setTranCode(tranCode);
			service.updateTranCode(purchase);
			request.setAttribute("purchase", purchase);
			path = "forward:/listSale.do";
		}
		
//		return "forward:/listPurchase.do";
		return path;
	}

}
