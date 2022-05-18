package com.model2.mvc.common;

import java.sql.Date;
import java.util.Calendar;

import com.model2.mvc.service.domain.Product;

public class Event {

	private double dcPersent;
	private Date startDate;
	private Date endDate;
	private String eventType;
	private Product product;
	
	public Event() {
	}
	
	public double getDcPersent() {
		return dcPersent;
	}

	public void setDcPersent(double dcPersent) {
	
		if ( startDate != null ) {
			Calendar today = Calendar.getInstance();
			Date now = new Date(today.getTimeInMillis());
			
			int result = now.compareTo(startDate);
			
			if ( result >= 0 ) {
				product.setPrice( (int) ( dcPersent * product.getCostPrice() ) );
			}
			else {
				product.setPrice( product.getCostPrice() );
			}
		}
		else {
			product.setPrice(product.getCostPrice());
		}

		this.dcPersent = dcPersent;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getEventType() {
		return eventType;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	@Override
	public String toString() {
		return "[dcPersent]" + dcPersent + "[startDate]" + startDate + "[endDate]" + endDate + "[eventType]" + eventType + "[Product]" + product  ;
	}
	
	
}
