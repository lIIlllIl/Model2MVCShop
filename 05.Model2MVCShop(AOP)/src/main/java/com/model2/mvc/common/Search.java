package com.model2.mvc.common;

public class Search {
	
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageSize;
	private int endRowNum;
	private int startRowNum;
	private int firstPrice;
	private int secondPrice;
	private String searchPrice;
	private String searchTranCode;
	
	
	public Search() {
	}
	

	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int paseSize) {
		this.pageSize = paseSize;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		if ( searchKeyword.contains("~") ) {
			String[] priceArray = searchKeyword.split("~");
			if ( Integer.parseInt(priceArray[0]) > Integer.parseInt(priceArray[1]) ) {
				this.setFirstPrice(Integer.parseInt(priceArray[1]));
				this.setSecondPrice(Integer.parseInt(priceArray[0]));
			}
			else {
				this.setFirstPrice(Integer.parseInt(priceArray[0]));
				this.setSecondPrice(Integer.parseInt(priceArray[1]));
			}
		}
		else {
			this.searchKeyword = searchKeyword;
		}
	}
	
	public int getEndRowNum() {
		return getCurrentPage()*getPageSize();
	}

	public int getStartRowNum() {
		return (getCurrentPage()-1)*getPageSize()+1;
	}

	public int getFirstPrice() {
		return firstPrice;
	}

	public void setFirstPrice(int firstPrice) {
		this.firstPrice = firstPrice;
	}

	public int getSecondPrice() {
		return secondPrice;
	}

	public void setSecondPrice(int secondPrice) {
		this.secondPrice = secondPrice;
	}
	
	public String getSearchPrice() {
		return searchPrice;
	}

	public void setSearchPrice(String searchPrice) {
		this.searchPrice = searchPrice;
	}
	
	


	public String getSearchTranCode() {
		return searchTranCode;
	}


	public void setSearchTranCode(String searchTranCode) {
		this.searchTranCode = searchTranCode;
	}


	@Override
	public String toString() {
		return "Search [currentPage=" + currentPage + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword
				+ ", pageSize=" + pageSize + ", endRowNum=" + endRowNum
				+ ", startRowNum=" + startRowNum + "]";
	}
}