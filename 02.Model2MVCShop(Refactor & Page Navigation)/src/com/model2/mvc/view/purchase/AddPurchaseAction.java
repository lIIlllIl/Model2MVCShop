package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.dao.ProductDao;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.user.dao.UserDao;

public class AddPurchaseAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		String buyerId = request.getParameter("buyerId");
		String paymentOption = request.getParameter("paymentOption");
		String receiverName = request.getParameter("receiverName");
		String receiverPhone = request.getParameter("receiverPhone");
		String receiverAddr = request.getParameter("receiverAddr");
		String receiverRequest = request.getParameter("receiverRequest");
		String receiverDate = request.getParameter("receiverDate").replace("-", "");
		System.out.println("receiverName : " + request.getParameter("receiverName"));
		
		Purchase purchase = new Purchase();
		ProductDao productDao = new ProductDao();
		Product product = productDao.findProduct(prodNo);
		purchase.setPurchaseProd(product);
		
		UserDao userDao = new UserDao();
		User user = userDao.findUser(buyerId);
			
		System.out.println("user : " + user);
		purchase.setBuyer(user);
		System.out.println("purchaseVO.getBuyer : " + purchase.getBuyer());
		purchase.setPaymentOption(paymentOption);
		purchase.setReceiverName(receiverName);
		purchase.setReceiverPhone(receiverPhone);
		purchase.setDivyAddr(request.getParameter("receiverAddr"));
		System.out.println("request.getParameter(receiverAddr) : " + request.getParameter("receiverAddr"));
		System.out.println("receiverAddr : " + receiverAddr);
		System.out.println("purchaseVO.getDivyAddr : " + purchase.getDivyAddr());
		purchase.setDivyRequest(receiverRequest);
		purchase.setDivyDate(receiverDate);
		System.out.println("purchaseVO.getDivyDate : " + purchase.getDivyDate());
		
		PurchaseService service=new PurchaseServiceImpl();
		service.addPurchase(purchase);
		
		request.setAttribute("purchase", purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}

}
